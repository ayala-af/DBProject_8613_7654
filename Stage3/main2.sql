-- main2.sql
DECLARE

-- Create or replace the find_scheduling function
FUNCTION find_scheduling1(
    groupid IN scheduler.group_id%type,
    teacherid IN scheduler.teacher_id%type,
    workshopid IN scheduler.workshop_id%type
) RETURN SYS_REFCURSOR 
IS 
    -- Declare a ref cursor to return the result set
    result_cursor SYS_REFCURSOR;

    -- Variables to count occurrences in validation checks
    v_group_count NUMBER;
    v_teacher_count NUMBER;
    v_workshop_count NUMBER;
    
    -- Variable to hold the size of the group
    v_group_size NUMBER;

    -- Exception for invalid ID
    invalid_id EXCEPTION;

    -- Variable to hold error message
    err_message VARCHAR2(100);
BEGIN
    -- Validate group ID by checking its existence in the groups_ table
    SELECT COUNT(*) INTO v_group_count FROM groups_ WHERE group_id = groupid;
    IF v_group_count = 0 THEN
        err_message := 'Invalid group ID';             
        RAISE invalid_id;
    END IF;

    -- Validate teacher ID by checking its existence in the teachers table
    SELECT COUNT(*) INTO v_teacher_count FROM teachers WHERE teacher_id = teacherid;
    IF v_teacher_count = 0 THEN
        err_message := 'Invalid teacher ID';             
        RAISE invalid_id;
    END IF;

    -- Validate workshop ID by checking its existence in the workshops table
    SELECT COUNT(*) INTO v_workshop_count FROM workshops WHERE workshop_id = workshopid;
    IF v_workshop_count = 0 THEN
        err_message := 'Invalid workshop ID';             
        RAISE invalid_id;
    END IF;

    -- Get the size of the group from the groups_ table
    SELECT amount INTO v_group_size FROM groups_ WHERE group_id = groupid;

    -- Open a cursor to find all possible scheduling options
    OPEN result_cursor FOR
        SELECT 
            d.day_num AS sc_day,   -- Day of the week
            h.hour_num AS sc_time, -- Hour of the day
            r.room_id              -- Room ID
        FROM 
            -- Generate a series of day numbers (1 to 6)
            (SELECT LEVEL AS day_num FROM DUAL CONNECT BY LEVEL <= 6) d,
            -- Generate a series of hour numbers (6 AM to midnight)
            (SELECT LEVEL + 5 AS hour_num FROM DUAL CONNECT BY LEVEL <= 19) h,
            -- Select all rooms from the rooms table
            rooms r
        WHERE 
            -- Ensure the room has sufficient capacity for the group
            r.room_capacity >= v_group_size
            AND NOT EXISTS (
                -- Check for scheduling conflicts in the scheduler table
                SELECT 1
                FROM scheduler s
                WHERE s.sc_day = d.day_num
                AND s.sc_time = h.hour_num
                AND (s.room_id = r.room_id OR s.teacher_id = teacherid)
            )
        -- Order the results by day, hour, and room ID
        ORDER BY d.day_num, h.hour_num, r.room_id;

    -- Return the cursor with the result set
    RETURN result_cursor;

EXCEPTION
    WHEN invalid_id THEN
        -- Handle invalid ID exception by outputting an error message
        DBMS_OUTPUT.put_line(err_message);
        RETURN NULL;
    WHEN OTHERS THEN
        -- Handle any other exceptions by outputting a generic error message
        DBMS_OUTPUT.put_line('An error occurred: ' || SQLERRM);
        RETURN NULL;
END find_scheduling1;

------------------------------------------------------------------------------

-- Create or replace the check_and_update_schedule procedure
PROCEDURE check_and_update_schedule1
IS
    -- Cursor to iterate over all schedule entries in the Scheduler table
    CURSOR c_schedule IS
        SELECT s.scheduler_id, s.group_id, s.teacher_id, s.workshop_id, s.room_id
        FROM Scheduler s;

    -- Variables to store data fetched from tables
    v_group_size NUMBER; -- Size of the group
    v_workshop_capacity NUMBER; -- Capacity of the workshop
    v_room_capacity NUMBER; -- Capacity of the room

    -- Variables to hold values from the cursor fetch
    v_scheduler_id Scheduler.scheduler_id%TYPE;
    v_group_id Scheduler.group_id%TYPE;    
    v_teacher_id Scheduler.teacher_id%TYPE;
    v_workshop_id Scheduler.workshop_id%TYPE;
    v_room_id Scheduler.room_id%TYPE;

    -- Variables for result cursor and new schedule information
    v_result_cursor SYS_REFCURSOR; -- Cursor to hold available schedules
    v_new_day Scheduler.sc_day%TYPE; -- New day for the schedule
    v_new_time Scheduler.sc_time%TYPE; -- New time for the schedule
    v_new_room_id Scheduler.room_id%TYPE; -- New room ID for the schedule

    -- Flag to indicate if a valid new schedule was found
    v_found BOOLEAN;
    
BEGIN
    -- Open the cursor to iterate through all schedules
    OPEN c_schedule;
    LOOP
        -- Fetch the next schedule entry into variables
        FETCH c_schedule INTO v_scheduler_id, v_group_id, v_teacher_id, v_workshop_id, v_room_id;
        EXIT WHEN c_schedule%NOTFOUND; -- Exit the loop when no more rows are found
        
        -- Get the size of the group from the Groups_ table
        SELECT amount INTO v_group_size FROM Groups_ g WHERE g.group_id = v_group_id;

        -- Get the capacity of the workshop from the Workshops table
        SELECT w.workshop_capacity INTO v_workshop_capacity FROM Workshops w WHERE w.workshop_id = v_workshop_id;

        -- Get the capacity of the room from the Rooms table
        SELECT r.room_capacity INTO v_room_capacity FROM Rooms r WHERE r.room_id = v_room_id;
        
        -- Check if the group size exceeds the workshop capacity
        IF v_group_size > v_workshop_capacity THEN
            -- Delete the schedule entry if the group size exceeds workshop capacity
            DELETE FROM Scheduler WHERE scheduler_ID = v_scheduler_id;
            DBMS_OUTPUT.PUT_LINE('Deleted schedule ID: ' || v_scheduler_id || ' due to workshop overcapacity.');
        
        -- Check if the group size exceeds the room capacity
        ELSIF v_group_size > v_room_capacity THEN
            DBMS_OUTPUT.PUT_LINE('Group size exceeds room capacity for schedule ID: ' || v_scheduler_id || '. Calling find_scheduling.');
            
            -- Call the find_scheduling1 function to get a new suitable schedule
            v_result_cursor := find_scheduling1(v_group_id, v_teacher_id, v_workshop_id);
            
            -- Initialize the found flag to FALSE
            v_found := FALSE;
            
            -- Loop through the result cursor to find a suitable new schedule
            LOOP
                FETCH v_result_cursor INTO v_new_day, v_new_time, v_new_room_id;
                EXIT WHEN v_result_cursor%NOTFOUND; -- Exit the loop when no more rows are found
                
                -- Set the found flag to TRUE as we have found a new schedule
                v_found := TRUE;

                -- Update the existing schedule with the new schedule details
                UPDATE Scheduler
                SET sc_day = v_new_day, 
                    sc_time = v_new_time, 
                    room_id = v_new_room_id
                WHERE scheduler_id = v_scheduler_id;
                
                -- Output a message indicating the schedule update
                DBMS_OUTPUT.PUT_LINE('Updated schedule ID: ' || v_scheduler_id || ' to new day: ' || v_new_day 
                                     || ' and time: ' || v_new_time || ' in room: ' || v_new_room_id);
                EXIT; -- Exit the loop after updating with the first available slot
            END LOOP;
            
            -- Close the result cursor
            CLOSE v_result_cursor;
            
            -- If no new schedule was found, output a message indicating the same
            IF NOT v_found THEN
                DBMS_OUTPUT.PUT_LINE('No suitable schedule found for schedule ID: ' || v_scheduler_id);
            END IF;
        END IF;
    END LOOP;
    
    -- Close the schedule cursor
    CLOSE c_schedule;
    
    -- Commit the changes
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any exceptions that occur
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK; -- Rollback changes in case of an error
END check_and_update_schedule1;

------------------------------------------------------------------------------

-- Run the check_and_update_schedule procedure
BEGIN
    DBMS_OUTPUT.PUT_LINE('Running check_and_update_schedule procedure:');
    DBMS_OUTPUT.ENABLE(10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000);  -- Increase to 1 million bytes or an appropriate value
    check_and_update_schedule1;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Main script completed.');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
