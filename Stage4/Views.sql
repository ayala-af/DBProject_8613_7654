-- VIEWS

-- Our View - Workshops Scheduler View:

-- This view combines information from multiple tables to provide a comprehensive view of scheduled workshops
CREATE OR REPLACE VIEW scheduled_workshops_view AS
SELECT 
    s.scheduler_ID,
    w.workshop_name,
    t.teacher_fname || ' ' || t.teacher_lname AS teacher_name,
    r.room_ID,
    r.room_floor,
    r.room_capacity,
    g.group_ID,
    ag.descript AS age_group,
    s.sc_day,
    s.sc_time,
    g.amount AS participants,
    w.workshop_capacity
FROM 
    Scheduler s
    JOIN Workshops w ON s.workshop_ID = w.workshop_ID
    JOIN Teacher t ON s.teacher_ID = t.teacher_ID
    JOIN Rooms r ON s.room_ID = r.room_ID
    JOIN Groups_ g ON s.group_ID = g.group_ID
    JOIN Age_Group ag ON g.age_ID = ag.age_ID
WHERE T.TEACHER_ID IN (SELECT TEACHER_ID FROM WTEACHER);

-- This query selects all data from the scheduled_workshops_view
SELECT * FROM scheduled_workshops_view;

-- This query finds the top 10 busiest days and times for workshops
-- It counts the number of sessions for each day and time combination
-- and orders them in descending order of session count
SELECT *
FROM (
    SELECT s.sc_day, s.sc_time, COUNT(*) AS session_count
    FROM scheduled_workshops_view s
    GROUP BY s.sc_day, s.sc_time
    ORDER BY session_count DESC
) 
WHERE ROWNUM <= 10;

---------------------------------------------------------

-- Other View - School Lesson Details View:

-- This view combines information from multiple tables to provide a comprehensive view of lesson details
CREATE OR REPLACE VIEW LESSON_DETAILS_VIEW AS
SELECT 
    L.LESSON_ID,
    L.LESSON_DAY,
    L.LESSON_HOUR,
    L.CLASS_ID,
    C.GRADE,
    L.TEACHER_ID,
    T.TEACHER_FNAME,
    L.SUBJECT_ID,
    S.SUBJECT_NAME,
    C.ROOM_ID,
    R.ROOM_CAPACITY,
    R.IS_LAB
FROM 
    LESSON L
    LEFT JOIN CLASS_ C ON L.CLASS_ID = C.CLASS_ID
    LEFT JOIN TEACHER T ON L.TEACHER_ID = T.TEACHER_ID 
    LEFT JOIN SUBJECT S ON L.SUBJECT_ID = S.SUBJECT_ID
    LEFT JOIN ROOMS R ON C.ROOM_ID = R.ROOM_ID
WHERE T.TEACHER_ID IN (SELECT TEACHER_ID FROM SCHTEACHER);

-- This query selects all data from the LESSON_DETAILS_VIEW
SELECT * FROM LESSON_DETAILS_VIEW;

-- This query counts the number of lessons for each teacher from Sunday to Tuesday
-- and orders the results by the lesson count in descending order
SELECT TEACHER_FNAME, COUNT(*) AS LESSON_COUNT
FROM LESSON_DETAILS_VIEW
WHERE LESSON_DAY BETWEEN 1 AND 3
GROUP BY TEACHER_FNAME
ORDER BY LESSON_COUNT DESC;
