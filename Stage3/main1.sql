-- הגדרת הפונקציה
CREATE OR REPLACE FUNCTION Teacher_Bonus(percent IN NUMBER, threshold_hour IN INTEGER)
RETURN SYS_REFCURSOR IS
  message VARCHAR2(100);
  CURSOR c_teachers IS
    SELECT teacher_id, teacher_fname, teacher_lname, teacher_salary
    FROM teachers
    FOR UPDATE OF teacher_salary;
  
  -- REF CURSOR for return
  result_cursor SYS_REFCURSOR;
  
  illegal_hour EXCEPTION;
  illegal_percent EXCEPTION;
  v_total_hours NUMBER := 0;
  v_hours NUMBER;
  v_new_salary NUMBER;
  v_cost number:=0;
BEGIN
  -- Input validation
  IF threshold_hour < 6 OR threshold_hour > 24 THEN 
    message := 'Threshold hour should be an integer between 6 to 24';
    RAISE illegal_hour;
  END IF;
  
  IF percent <= 0 OR percent > 100 THEN
    message := 'Percent should be a number between 0 to 100';
    RAISE illegal_percent;
  END IF;
  
  -- DML operations
  FOR teacher IN c_teachers LOOP
    -- Implicit cursor in subquery
    SELECT NVL(SUM(GREATEST(sc.sc_time + w.workshop_hours - threshold_hour, 0)), 0)
    INTO v_hours
    FROM scheduler sc
    NATURAL JOIN workshops w
    WHERE sc.teacher_id = teacher.teacher_id;
    
    IF v_hours > 0 THEN
      v_new_salary := teacher.teacher_salary * (1 + (v_hours * percent / 100));
      
      -- Update teacher salary
      UPDATE teachers
      SET teacher_salary = v_new_salary
      WHERE CURRENT OF c_teachers;
      
      v_total_hours := v_total_hours + v_hours;
      v_cost:= v_cost+teacher.teacher_salary *  (v_hours * percent / 100);
    END IF;
  END LOOP;

  -- Prepare result cursor
  OPEN result_cursor FOR
    SELECT t.teacher_id, t.teacher_fname, t.teacher_lname, 
           t.teacher_salary AS new_salary,
           t.teacher_salary / (1 + (NVL(SUM(GREATEST(sc.sc_time + w.workshop_hours - threshold_hour, 0)), 0) * percent / 100)) AS old_salary,
           NVL(SUM(GREATEST(sc.sc_time + w.workshop_hours - threshold_hour, 0)), 0) AS extra_hours
    FROM teachers t
    LEFT JOIN scheduler sc ON t.teacher_id = sc.teacher_id
    LEFT JOIN workshops w ON sc.workshop_id = w.workshop_id
    GROUP BY t.teacher_id, t.teacher_fname, t.teacher_lname, t.teacher_salary
    HAVING NVL(SUM(GREATEST(sc.sc_time + w.workshop_hours - threshold_hour, 0)), 0) > 0;

  RETURN result_cursor;

EXCEPTION
  WHEN illegal_hour THEN
    DBMS_OUTPUT.PUT_LINE(message);
    RETURN NULL;
  WHEN illegal_percent THEN
    DBMS_OUTPUT.PUT_LINE(message);
    RETURN NULL;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
    ROLLBACK;
    RETURN NULL;
END;
/

-- הגדרת הפרוצדורה
CREATE OR REPLACE PROCEDURE update_group_amount
IS
  CURSOR group_cursor IS
    SELECT g.group_id, g.amount, COUNT(p.client_id) AS actual_participants
    FROM Groups_ g
    LEFT JOIN Participate p ON g.group_id = p.group_id
    GROUP BY g.group_id, g.amount;
  
  v_groups_updated NUMBER := 0;
  v_total_participants NUMBER := 0;
  no_groups_updated EXCEPTION;
BEGIN
  FOR group_rec IN group_cursor LOOP
    IF group_rec.actual_participants != group_rec.amount THEN
      UPDATE Groups_
      SET amount = group_rec.actual_participants
      WHERE group_id = group_rec.group_id;
      v_groups_updated := v_groups_updated + 1;
      DBMS_OUTPUT.PUT_LINE('Updated Group ID: ' || group_rec.group_id || 
                           ', Old Amount: ' || group_rec.amount || 
                           ', New Amount: ' || group_rec.actual_participants);
    else
         DBMS_OUTPUT.PUT_LINE('GOOD Group ID: ' || group_rec.group_id || 
                           ', Old Amount: ' || group_rec.amount||
                           'new amount: '||group_rec.actual_participants);
      
    END IF;
    v_total_participants := v_total_participants + group_rec.actual_participants;
  END LOOP;
    IF v_groups_updated = 0 THEN
    RAISE no_groups_updated;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Total groups updated: ' || v_groups_updated);
    DBMS_OUTPUT.PUT_LINE('Total participants across all groups: ' || v_total_participants);
  END IF; 
  --COMMIT;
EXCEPTION
  WHEN no_groups_updated THEN
    DBMS_OUTPUT.PUT_LINE('No groups required updating.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
    ROLLBACK;
END;
/

DECLARE
    v_percent NUMBER := &percent_input;
    v_threshold_hour NUMBER := &threshold_hour_input;
    v_result SYS_REFCURSOR;
    v_teacher_id NUMBER;
    v_fname VARCHAR2(50);
    v_lname VARCHAR2(50);
    v_new_salary NUMBER;
    v_old_salary NUMBER;
    v_extra_hours NUMBER;
BEGIN
    -- קריאה לפונקציה עם הערכים שהוכנסו
    v_result := teacher_bonus(percent => v_percent,
                              threshold_hour => v_threshold_hour);
    
    -- שאר הקוד נשאר ללא שינוי...
    -- בדיקה אם הפונקציה החזירה cursor
    IF v_result IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Teachers who received a bonus:');
        DBMS_OUTPUT.PUT_LINE('------------------------------');
        DBMS_OUTPUT.PUT_LINE('ID | Name | Old Salary | New Salary | Extra Hours');
        
        -- קריאה והצגה של התוצאות
        LOOP
            FETCH v_result INTO v_teacher_id, v_fname, v_lname, v_new_salary, v_old_salary, v_extra_hours;
            EXIT WHEN v_result%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE(
                v_teacher_id || ' | ' ||
                v_fname || ' ' || v_lname || ' | ' ||
                TO_CHAR(v_old_salary, '999999.99') || ' | ' ||
                TO_CHAR(v_new_salary, '999999.99') || ' | ' ||
                v_extra_hours
            );
        END LOOP;
        
        -- סגירת ה-cursor
        CLOSE v_result;
    ELSE
        DBMS_OUTPUT.PUT_LINE('No results returned or an error occurred.');
    END IF;
    
    
     -- Call the procedure
  DBMS_OUTPUT.ENABLE(10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000);  -- Increase to 1 million bytes or an appropriate value
  update_group_amount;
  
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        IF v_result%ISOPEN THEN
            CLOSE v_result;
        END IF;
        
END;
