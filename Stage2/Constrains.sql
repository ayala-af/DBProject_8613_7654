alter table clients
--add constraint not_null_tel
modify client_tel not null;



--insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_PAYMENT, BIRTHDAY)
--values (1000, 'Andre', 'Burton', 1, 201, to_date('10-02-1965', 'dd-mm-yyyy'));

alter table teachers
--add constraint teacher_salary_0
modify teacher_salary default 0;

--insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_JOIN_DATE)
--values (1000, 'Eddie', 'Jackman', 10, 84571, to_date('06-10-1952', 'dd-mm-yyyy'));

--select teacher_salary
--from teachers
--where teacher_id=1000;



alter table rooms
add constraint boolean_isStudio
CHECK (isStudio IN ('T', 'F'))


--insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
--values (1000, 0, 'L', 26);
