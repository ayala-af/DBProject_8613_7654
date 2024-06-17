--PARAMS
--params1
--all teachers who teach <workshop x> and joined before <date y>
SELECT *
FROM (teachers t1 JOIN teach t2 ON t1.teacher_id = t2.teacher_id) 
WHERE workshop_id = &<name="workshop" 
list="select workshop_id,workshop_name from workshops order by workshop_id"
description="yes" restricted="yes" >
 and extract(year from To_DATE(teacher_join_date,'DD/MM/YYYY') )<=  &<name=join_date type=integer hint="4 digit number of year">; 
 
--params2
-- find all clients who participate in more than a specified number of workshops

SELECT c.client_ID, c.client_fname, c.client_lname, COUNT(DISTINCT sc.workshop_ID) AS workshop_count
FROM Clients c
left JOIN Participate p ON c.client_ID = p.client_ID
JOIN Groups_ g ON p.group_ID = g.group_ID
JOIN Scheduler sc ON g.group_ID = sc.group_ID
GROUP BY c.client_ID, c.client_fname, c.client_lname
HAVING COUNT(DISTINCT sc.workshop_ID) > &<name="min workshops" 
                                          hint="min value bigger than 0"
                                          type="integer"
                                          default=0>;

--params3
--show a schedule (room, teache, and workshop) for <day x> and <hour y>
select workshop_id,workshop_name,teacher_id,teacher_fname,teacher_lname,group_id,room_id,room_floor,isstudio,room_capacity
from teachers natural join scheduler natural join workshops natural join  rooms
where sc_day=&<name="day" list="1,2,3,4,5,6" type=integer default=1> and sc_time=&<name="hour" type=integer hint="a number between 6 and 24" default=6>

select*-- workshop_id,workshop_name,teacher_id,teacher_fname,teacher_lname,group_id,room_id,room_floor,isstudio,room_capacity
from teachers natural join scheduler natural join workshops natural join  rooms
--where sc_day=&<name="day" list="1,2,3,4,5,6" type=integer default=1> and sc_time=&<name="hour" type=integer hint="a number between 6 and 24" default=6>

--params4
-- find clients living in the same city as the teacher with the specified teacher_id

SELECT c.client_ID, c.client_fname, c.client_lname, ci.city_name
FROM Clients c
JOIN City ci ON c.client_addr = ci.city_num
WHERE c.client_addr = (
        SELECT t.teacher_addr
        FROM Teachers t
        WHERE t.teacher_ID = &<name="teacher_id"
                               list="SELECT teacher_id FROM Teachers">
      );

  
