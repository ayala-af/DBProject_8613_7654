--all queries

--DELETE

--delete1 
--delete every schedule of a teacher who teach a workshop he's not allowed to teach
--shows the problametic schedules
select scheduler.*  
from scheduler
where scheduler.workshop_id not in (
select teach.workshop_id
from teach
where teach.teacher_id = scheduler.teacher_id);

-- delete query
delete from scheduler
where scheduler.workshop_id not in (
select teach.workshop_id
from teach
where teach.teacher_id = scheduler.teacher_id);


--delete2
-- DELETE participations where clients do not match the group's age criteria
-- client age
create view client_age as (
  select c.client_id, extract(year from numtoyminterval(months_between(trunc(sysdate),c.birthday),'month')) age
  from clients c);

-- select all participations where clients do not match the group's age criteria
select *
from age_group
natural join (select g.group_id, g.age_id from groups_ g) 
natural join participate 
natural join client_age
where age < minage or age > maxage;

-- delete query
delete from participate p
where exists (
select *
from (select ag.age_id, ag.minage, ag.maxage from age_group ag)
natural join (select g.group_id, g.age_id from groups_ g) 
natural join participate 
natural join client_age
where (age < minage or age > maxage) and p.client_id = client_ID and p.group_id = group_ID
);


--UPDATE

--update1
--update each client's payment according to the cost of the workshops they take 
--(but not according to the number of times they are scheduled for the same workshop)

--foreach client - shows its calculated payment
SELECT c.client_ID, COALESCE(wp.total_price, 0) AS culculated_total_price,c.client_payment as currnt_payment
FROM Clients c
LEFT JOIN (
    SELECT p.client_ID, SUM(w.workshop_price) AS total_price
    FROM participate p
    JOIN (
        SELECT DISTINCT group_id, workshop_id
        FROM scheduler
    ) s ON s.group_id = p.group_id
    JOIN(
        SELECT DISTINCT workshop_id, workshop_price
        FROM Workshops
    ) w ON w.workshop_ID = s.workshop_id
    GROUP BY p.client_ID
) wp ON wp.client_ID = c.client_ID
ORDER BY c.client_ID;

--update query
UPDATE Clients c
SET client_payment = COALESCE((
    SELECT SUM(w.workshop_price)
    FROM clients ck left JOIN participate p on ck.client_id=p.client_id
    left JOIN (
        SELECT DISTINCT group_id, workshop_id
        FROM scheduler
    ) s ON s.group_id = p.group_id
    left JOIN (
        SELECT DISTINCT workshop_id, workshop_price
        FROM Workshops
    ) w ON w.workshop_ID = s.workshop_id
    WHERE p.client_ID = c.client_ID
    GROUP BY ck.client_ID
), 0);


--update2
--update teacher salary to the correct number
SELECT sc.teacher_ID, (t.teacher_fname || ' ' || t.teacher_lname) AS full_name, 
       t.teacher_salary AS current_salary, SUM(w.workshop_price) AS correct_salary
FROM Scheduler sc
JOIN Workshops w ON sc.workshop_ID = w.workshop_ID
JOIN Teachers t ON sc.teacher_id = t.teacher_id
GROUP BY sc.teacher_ID, t.teacher_fname, t.teacher_lname, t.teacher_salary;

-- update teacher salary to the correct number
CREATE VIEW SalaryUpdate AS (
    SELECT sc.teacher_ID, SUM(w.workshop_price) AS new_salary
    FROM Scheduler sc
    JOIN Workshops w ON sc.workshop_ID = w.workshop_ID
    GROUP BY sc.teacher_ID
);

--update query
UPDATE Teachers t
SET t.teacher_salary = (
      SELECT su.new_salary
      FROM SalaryUpdate su
      WHERE su.teacher_ID = t.teacher_ID
    )    
WHERE t.teacher_ID IN (
      SELECT su.teacher_ID
      FROM SalaryUpdate su
      );
UPDATE Teachers t
SET t.teacher_salary = 0    
WHERE t.teacher_ID NOT IN (
      SELECT su.teacher_ID
      FROM SalaryUpdate su
      );

--result
select *
from teachers



--SELECT

--select1
--The workshop with the fewest registrants
-- side query: forech workshop shows its number of paticipants
SELECT DISTINCT w.WORKSHOP_NAME, g.GROUP_ID, g.AMOUNT
FROM WORKSHOPS w
JOIN SCHEDULER s ON w.WORKSHOP_ID = s.WORKSHOP_ID  
JOIN GROUPS_ g ON s.GROUP_ID = g.GROUP_ID
ORDER BY w.WORKSHOP_NAME, g.GROUP_ID;

SELECT w.WORKSHOP_NAME, COALESCE(SUM(g.AMOUNT), 0) AS total_participants
FROM WORKSHOPS w
LEFT JOIN SCHEDULER s ON w.WORKSHOP_ID = s.WORKSHOP_ID
LEFT JOIN GROUPS_ g ON s.GROUP_ID = g.GROUP_ID
GROUP BY w.WORKSHOP_NAME
ORDER BY total_participants DESC;

-- the workshop with the least number of participants
SELECT w.workshop_id, w.WORKSHOP_NAME, COALESCE(SUM(g.AMOUNT), 0) AS total_participants
FROM WORKSHOPS w
LEFT JOIN SCHEDULER s ON w.WORKSHOP_ID = s.WORKSHOP_ID
LEFT JOIN GROUPS_ g ON s.GROUP_ID = g.GROUP_ID
GROUP BY w.WORKSHOP_NAME, w.workshop_id
HAVING  COALESCE(SUM(g.AMOUNT), 0) = (
        SELECT COALESCE(MIN(total_participants), 0)
        FROM (
            SELECT COALESCE(SUM(g.AMOUNT), 0) AS total_participants
            FROM WORKSHOPS w
            LEFT JOIN SCHEDULER s ON w.WORKSHOP_ID = s.WORKSHOP_ID
            LEFT JOIN GROUPS_ g ON s.GROUP_ID = g.GROUP_ID
            GROUP BY w.WORKSHOP_NAME
        )
    )
ORDER BY total_participants DESC;
      
      
    
-- select2
-- select teacher(s) who teaches the most clients

WITH ClientCounts AS (
     SELECT teacher_ID, teacher_fname, teacher_lname, COUNT(DISTINCT client_ID) AS num_clients
     FROM Teachers
     NATURAL JOIN Scheduler
     NATURAL JOIN Groups_
     NATURAL JOIN Participate
     GROUP BY teacher_ID, teacher_fname, teacher_lname
     ORDER BY num_clients DESC
)

SELECT teacher_ID, teacher_fname, teacher_lname, num_clients
FROM ClientCounts
WHERE num_clients = (SELECT MAX(num_clients) FROM ClientCounts);



-- select3
-- foreach workshop - returns the number of students for each teacher for each workshop

-- all schedules
select *   
from scheduler  natural join groups_ 
order by teacher_id,
workshop_ID;

-- select query
SELECT T.teacher_ID, T.teacher_fname, T.teacher_lname, W.workshop_ID, 
       W.workshop_name, COALESCE(SUM(G.amount), 0) AS num_students
FROM Teachers T
LEFT JOIN Scheduler S ON T.teacher_ID = S.teacher_ID 
LEFT JOIN Workshops W ON S.workshop_ID = W.workshop_ID
LEFT JOIN Groups_ G ON S.group_ID = G.group_ID
GROUP BY T.teacher_ID, T.teacher_fname, T.teacher_lname, 
      W.workshop_ID, W.workshop_name
ORDER BY T.teacher_ID, W.workshop_ID;



-- select4
-- select the teacher(s) who gets above average with in the other teachers of each workshop 

WITH WorkshopAvgSalary AS (
    SELECT te.workshop_ID, AVG(t.teacher_salary) AS avg_salary
    FROM Teach te
    JOIN Teachers t ON te.teacher_ID = t.teacher_ID
    GROUP BY te.workshop_ID
)

SELECT te.workshop_ID, w.workshop_name, was.avg_salary, t.teacher_id,
       t.teacher_fname, t.teacher_lname, t.teacher_salary
FROM Teach te                                                      -- each workshop and its teachers 
JOIN Workshops w ON te.workshop_id = w.workshop_id                 -- for workshop name   
JOIN WorkshopAvgSalary was ON te.workshop_id = was.workshop_ID     -- for workshop avg salary
JOIN Teachers t ON te.teacher_id = t.teacher_id                    -- for teachers name and salary   
WHERE t.teacher_salary > was.avg_salary;


