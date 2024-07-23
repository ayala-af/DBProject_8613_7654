-- Renaming tables
-- This section renames several tables, in order to differentiate them from existing tables or to prepare for integration
alter table student rename to student1;
alter table lesson rename to lesson1;
alter table class_ rename to class1;
alter table teacher rename to teacher1;
alter table subject rename to subject1;
alter table room rename to room1;

-- Selecting data from renamed tables
-- This is for verification purposes after renaming
SELECT * FROM student1;
SELECT * FROM lesson1;
SELECT * FROM class1;
SELECT * FROM teacher1;
SELECT * FROM subject1;
select * from ROOM1; 

-- Modifying ROOMS table
-- Adding new columns to the ROOMS table
alter table ROOMS add is_lab number(1);
alter table ROOMS add last_maintenance_check date;
-- verify 
select * from ROOMS;

-- Data integration: ROOM1 into ROOMS
-- This block transfers data from ROOM1 to ROOMS, updating existing records or inserting new ones
DECLARE
  v_count NUMBER;
BEGIN
  -- Loop through ROOM1 records
  FOR r IN (SELECT * FROM ROOM1)
  LOOP
    -- Check if room exists in ROOMS
    SELECT COUNT(*) INTO v_count
    FROM ROOMS
    WHERE ROOM_ID = r.ROOM_ID;
    
    IF v_count > 0 THEN
      -- Update existing room
      UPDATE ROOMS
      SET IS_LAB = r.IS_LAB,
          LAST_MAINTENANCE_CHECK = r.LAST_MAINTENANCE_CHECK,
          ROOM_CAPACITY = LEAST(ROOM_CAPACITY, r.MAX_CAPACITY),
          ROOM_FLOOR = COALESCE(ROOM_FLOOR, NULL)
      WHERE ROOM_ID = r.ROOM_ID;
    ELSE
      -- Insert new room
      INSERT INTO ROOMS (ROOM_ID, IS_LAB, LAST_MAINTENANCE_CHECK, ROOM_CAPACITY, ROOM_FLOOR, ISSTUDIO)
      VALUES (r.ROOM_ID, r.IS_LAB, r.LAST_MAINTENANCE_CHECK, r.MAX_CAPACITY, NULL, 'F');
    END IF;
  END LOOP;
  
  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('Update completed successfully..');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
    ROLLBACK;
END;
/

-- Teacher integration
-- Creating new tables for teacher data
CREATE TABLE TEACHER (
    TEACHER_ID NUMBER(5) PRIMARY KEY,
    TEACHER_FNAME VARCHAR2(15),
    TEACHER_LNAME VARCHAR2(15),
    TEACHER_TEL NUMBER(5),
    TEACHER_JOIN_DATE DATE
);

CREATE TABLE SCHTEACHER (
    TEACHER_ID NUMBER(5) PRIMARY KEY,
    HOURLY_SALARY NUMBER,
    BONUS NUMBER,
    FOREIGN KEY (TEACHER_ID) REFERENCES TEACHER(TEACHER_ID)
);

CREATE TABLE WTEACHER (
    TEACHER_ID NUMBER(5) PRIMARY KEY,
    TEACHER_SALARY NUMBER,
    TEACHER_ADDR NUMBER(5),
    FOREIGN KEY ( TEACHER_ADDR) REFERENCES CITY(CITY_NUM),
    FOREIGN KEY (TEACHER_ID) REFERENCES TEACHER(TEACHER_ID)
);

-- Transfer teacher data
-- This block moves data from TEACHERS and TEACHER1 tables to the newly created teacher tables
DECLARE
    v_count NUMBER;
BEGIN
    -- Transfer data to TEACHER table
    INSERT INTO TEACHER (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_TEL, TEACHER_JOIN_DATE)
    SELECT TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_TEL, TEACHER_JOIN_DATE
    FROM TEACHERS
    WHERE TEACHER_ID IS NOT NULL;

    -- Add teachers from TEACHER1 if they don't exist
    FOR rec IN (SELECT * FROM TEACHER1)
    LOOP
        SELECT COUNT(*) INTO v_count
        FROM TEACHER
        WHERE TEACHER_ID = rec.TEACHER_ID;

        IF v_count = 0 THEN
            INSERT INTO TEACHER (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME)
            VALUES (rec.TEACHER_ID, rec.TFIRST_NAME, rec.TLAST_NAME);
        END IF;
    END LOOP;

    -- Update teacher details from TEACHER1
    FOR rec IN (SELECT * FROM TEACHER1)
    LOOP
        UPDATE TEACHER
        SET TEACHER_FNAME = rec.TFIRST_NAME,
            TEACHER_LNAME = rec.TLAST_NAME
        WHERE TEACHER_ID = rec.TEACHER_ID;
    END LOOP;

    -- Transfer data to SCHTEACHER
    INSERT INTO SCHTEACHER (TEACHER_ID, HOURLY_SALARY, BONUS)
    SELECT TEACHER_ID, HOURLY_SALARY, BONUS
    FROM TEACHER1
    WHERE TEACHER_ID IS NOT NULL;

    -- Transfer data to WTEACHER
    INSERT INTO WTEACHER (TEACHER_ID, TEACHER_SALARY,teacher_addr)
    SELECT TEACHER_ID, TEACHER_SALARY,teacher_addr
    FROM TEACHERS
    WHERE TEACHER_ID IS NOT NULL;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Update completed successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/

-- Verify content of new teacher tables
SELECT * FROM TEACHER;
SELECT * FROM SCHTEACHER;
SELECT * FROM WTEACHER;
commit;

-- STUDENT-CLIENT-INTEGRATION
-- Modifying CLIENTS table to prepare for integration
-- alter table CLIENTS modify client_addr null;
alter table CLIENTS add fathername VARCHAR2(15);
alter table CLIENTS add mothername VARCHAR2(15);
alter table CLIENTS add class_id NUMBER(3);
alter table CLIENTS
  add foreign key (CLASS_ID)
  references class1 (CLASS_ID);

-- Update existing clients with data from STUDENT1
UPDATE CLIENTS C
SET C.FATHERNAME = (SELECT S.FATHERNAME FROM STUDENT1 S WHERE S.STUDENT_ID = C.CLIENT_ID),
    C.MOTHERNAME = (SELECT S.MOTHERNAME FROM STUDENT1 S WHERE S.STUDENT_ID = C.CLIENT_ID),
    C.CLASS_ID = (SELECT S.CLASS_ID FROM STUDENT1 S WHERE S.STUDENT_ID = C.CLIENT_ID)
WHERE EXISTS (SELECT 1 FROM STUDENT1 S WHERE S.STUDENT_ID = C.CLIENT_ID);
commit;

-- Insert new students as clients
INSERT INTO CLIENTS (
    CLIENT_ID, 
    CLIENT_FNAME, 
    CLIENT_LNAME, 
    CLIENT_ADDR, 
    CLIENT_TEL, 
    CLIENT_PAYMENT, 
    BIRTHDAY, 
    FATHERNAME, 
    MOTHERNAME, 
    CLASS_ID
)
SELECT 
    S.STUDENT_ID,
    S.FIRST_NAME,
    S.LAST_NAME,
    (SELECT MIN(CITY_NUM) FROM CITY), -- Default value for CLIENT_ADDR
    MOD(S.PHONE, 100000),-- convert to fit CLIENT.Client_TEL%type
    0, -- Default value for CLIENT_PAYMENT
    S.BIRTH_DATE,
    S.FATHERNAME,
    S.MOTHERNAME,
    S.CLASS_ID
FROM STUDENT1 S
WHERE NOT EXISTS (SELECT 1 FROM CLIENTS C WHERE C.CLIENT_ID = S.STUDENT_ID);
commit;

-- Verify the results
SELECT * FROM CLIENTS;
SELECT * FROM student1;

-- CHANGING RELATIONSHIPS
-- This section updates foreign key relationships to reflect the new table structure

-- Update LESSON1 foreign key
alter table LESSON1
  drop constraint SYS_C008984;
alter table LESSON1
  add foreign key (TEACHER_ID)
  references schteacher (TEACHER_ID);

-- Update CLASS1 foreign keys
alter table CLASS1
  drop constraint SYS_C008970;
alter table CLASS1
  add foreign key (TEACHER_ID)
  references schteacher (TEACHER_ID);

alter table CLASS1
  drop constraint SYS_C008971;
alter table CLASS1
  add foreign key (ROOM_ID)
  references rooms (ROOM_ID);

-- Update TEACH foreign key
alter table TEACH
  drop constraint SYS_C009057;
alter table TEACH
  add foreign key (TEACHER_ID)
  references WTEACHER (TEACHER_ID);

-- Update SCHEDULER foreign key
alter table SCHEDULER
  drop constraint SYS_C009050;
alter table SCHEDULER
  add foreign key (TEACHER_ID)
  references WTEACHER (TEACHER_ID);

-- Clean up: drop obsolete tables
drop table student1;
drop table teacher1;
drop table room1;
drop table teachers;

-- Final renaming of tables
alter table class1 rename to class_;
alter table subject1 rename to subject;
alter table lesson1 rename to lesson;

-- Verify final table contents and counts
-- This section lists all tables and their record counts for final verification
select * from AGE_GROUP;
select count (*) from AGE_GROUP;

select * from CITY;
select count (*) from CITY;

select * from CLASS_;
select count (*) from CLASS_;

select * from CLIENTS;
select count (*) from CLIENTS;

select * from GROUPS_;
select count (*) from GROUPS_;

select * from LESSON;
select count (*) from LESSON;

select * from PARTICIPATE;
select count (*) from   PARTICIPATE;

select * from ROOMS;
select count (*) from ROOMS;

select * from SCHEDULER;
select count (*) from SCHEDULER;

select * from SUBJECT;
select count (*) from SUBJECT;

select * from TEACH;
select count (*) from TEACH;

select * from WORKSHOPS;
select count (*) from WORKSHOPS;

select * from TEACHER;
select count (*) from TEACHER;

select * from SCHTEACHER;
select count (*) from SCHTEACHER;

select * from WTEACHER;
select count (*) from WTEACHER;

