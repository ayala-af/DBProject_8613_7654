-- CONSTRAINTS

-- constraint 1 

alter table clients
modify client_tel not null;

-- input check
insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_PAYMENT, BIRTHDAY)
values (1000, 'Andre', 'Burton', 1, 201, to_date('10-02-1965', 'dd-mm-yyyy'));



-- constraint 2 

alter table teachers
modify teacher_salary 
default 0;

-- input check
insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_JOIN_DATE)
values (1000, 'Eddie', 'Jackman', 10, 84571, to_date('06-10-1952', 'dd-mm-yyyy'));

select teacher_salary
from teachers
where teacher_id=1000;


-- constraint 3 

alter table rooms
add constraint boolean_isStudio
check (isStudio in ('T', 'F'));

-- input check
insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
values (1000, 0, 'L', 26);
