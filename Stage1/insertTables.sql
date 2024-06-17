--INSERT INTO AGE_GROUP

insert into AGE_GROUP (AGE_ID,MINAGE,MAXAGE,DESCRIPT)
values (1, 3,5,'Toddlers');

insert into AGE_GROUP (AGE_ID,MINAGE,MAXAGE,DESCRIPT)
values (2, 6,12,'Kids');

insert into AGE_GROUP (AGE_ID,MINAGE,MAXAGE,DESCRIPT)
values (3, 13,17,'Teens');

insert into AGE_GROUP (AGE_ID,MINAGE,MAXAGE,DESCRIPT)
values (4, 18,60,'Adults');

insert into AGE_GROUP (AGE_ID,MINAGE,MAXAGE,DESCRIPT)
values (5, 60,120,'Pensioners');

commit;


--INSERT INTO CITY

insert into CITY (CITY_NUM, CITY_NAME)
values (1, 'Archbold');

insert into CITY (CITY_NUM, CITY_NAME)
values (2, 'Framingaham');

insert into CITY (CITY_NUM, CITY_NAME)
values (3, 'Highton');

insert into CITY (CITY_NUM, CITY_NAME)
values (4, 'Douala');

insert into CITY (CITY_NUM, CITY_NAME)
values (5, 'Kejae City');

insert into CITY (CITY_NUM, CITY_NAME)
values (6, 'Burgess Hill');

insert into CITY (CITY_NUM, CITY_NAME)
values (7, 'Allen');

insert into CITY (CITY_NUM, CITY_NAME)
values (8, 'Natanya');

insert into CITY (CITY_NUM, CITY_NAME)
values (9, 'Bad Camberg');

insert into CITY (CITY_NUM, CITY_NAME)
values (10, 'South Hadley');

commit;


-- INSERT INTO CLIENTS

insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_TEL, CLIENT_PAYMENT, BIRTHDAY)
values (1, 'Andre', 'Burton', 1, 91284, 201, to_date('10-02-1965', 'dd-mm-yyyy'));

insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_TEL, CLIENT_PAYMENT, BIRTHDAY)
values (2, 'Glen', 'Meyer', 2, 69755, 222, to_date('23-02-1939', 'dd-mm-yyyy'));

insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_TEL, CLIENT_PAYMENT, BIRTHDAY)
values (3, 'Davis', 'Posener', 3, 16955, 362, to_date('11-01-1977', 'dd-mm-yyyy'));

insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_TEL, CLIENT_PAYMENT, BIRTHDAY)
values (4, 'Fairuza', 'Gibbons', 4, 69060, 332, to_date('16-02-1980', 'dd-mm-yyyy'));

insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_TEL, CLIENT_PAYMENT, BIRTHDAY)
values (5, 'Jackie', 'Vance', 5, 87283, 335, to_date('31-08-1942', 'dd-mm-yyyy'));

insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_TEL, CLIENT_PAYMENT, BIRTHDAY)
values (6, 'Chad', 'Sawa', 6, 36592, 182, to_date('11-12-1987', 'dd-mm-yyyy'));

insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_TEL, CLIENT_PAYMENT, BIRTHDAY)
values (7, 'Natasha', 'Cassidy', 7, 61826, 257, to_date('30-09-1928', 'dd-mm-yyyy'));

insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_TEL, CLIENT_PAYMENT, BIRTHDAY)
values (8, 'Kyra', 'Worrell', 8, 10109, 299, to_date('13-11-1989', 'dd-mm-yyyy'));

insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_TEL, CLIENT_PAYMENT, BIRTHDAY)
values (9, 'Raul', 'Mazzello', 9, 23367, 273, to_date('27-02-1988', 'dd-mm-yyyy'));

insert into CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_ADDR, CLIENT_TEL, CLIENT_PAYMENT, BIRTHDAY)
values (10, 'Wade', 'Clinton', 10, 88313, 391, to_date('24-05-1992', 'dd-mm-yyyy'));

commit;




--INSERT INTO WORKSHOPS

insert into WORKSHOPS (WORKSHOP_ID,WORKSHOP_NAME, WORKSHOP_PRICE, WORKSHOP_HOURS, WORKSHOP_CAPACITY)
values (1,'Zumba', 167, 2, 12);

insert into WORKSHOPS (WORKSHOP_ID,WORKSHOP_NAME, WORKSHOP_PRICE, WORKSHOP_HOURS, WORKSHOP_CAPACITY)
values (2, 'Cooking',237, 1, 34);

insert into WORKSHOPS (WORKSHOP_ID,WORKSHOP_NAME, WORKSHOP_PRICE, WORKSHOP_HOURS, WORKSHOP_CAPACITY)
values (3,'Drawing', 351, 1, 10);

insert into WORKSHOPS (WORKSHOP_ID,WORKSHOP_NAME, WORKSHOP_PRICE, WORKSHOP_HOURS, WORKSHOP_CAPACITY)
values (4,'Baking', 369, 1, 29);

insert into WORKSHOPS (WORKSHOP_ID,WORKSHOP_NAME, WORKSHOP_PRICE, WORKSHOP_HOURS, WORKSHOP_CAPACITY)
values (5,'Ballet', 370, 4, 27);

insert into WORKSHOPS (WORKSHOP_ID,WORKSHOP_NAME, WORKSHOP_PRICE, WORKSHOP_HOURS, WORKSHOP_CAPACITY)
values (6,'Judo', 188, 2, 19);

insert into WORKSHOPS (WORKSHOP_ID,WORKSHOP_NAME, WORKSHOP_PRICE, WORKSHOP_HOURS, WORKSHOP_CAPACITY)
values (7,'Photography', 280, 1, 20);

insert into WORKSHOPS (WORKSHOP_ID,WORKSHOP_NAME, WORKSHOP_PRICE, WORKSHOP_HOURS, WORKSHOP_CAPACITY)
values (8,'Piano', 304, 3, 1);

insert into WORKSHOPS (WORKSHOP_ID,WORKSHOP_NAME, WORKSHOP_PRICE, WORKSHOP_HOURS, WORKSHOP_CAPACITY)
values (9,'Violin', 151, 4, 1);

insert into WORKSHOPS (WORKSHOP_ID,WORKSHOP_NAME, WORKSHOP_PRICE, WORKSHOP_HOURS, WORKSHOP_CAPACITY)
values (10,'Sewing', 377, 4, 22);

commit;

--INTO TEACHERS
insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_SALARY, TEACHER_JOIN_DATE)
values (1, 'Isabella', 'Jay', 1, 68611, 13930, to_date('16-04-1956', 'dd-mm-yyyy'));

insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_SALARY, TEACHER_JOIN_DATE)
values (2, 'Shirley', 'Ermey', 2, 84533, 11977, to_date('15-06-1951', 'dd-mm-yyyy'));

insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_SALARY, TEACHER_JOIN_DATE)
values (3, 'Whoopi', 'Dafoe', 3, 18453, 15728, to_date('03-12-1951', 'dd-mm-yyyy'));

insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_SALARY, TEACHER_JOIN_DATE)
values (4, 'Chris', 'Hoskins', 4, 74083, 18193, to_date('19-09-1982', 'dd-mm-yyyy'));

insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_SALARY, TEACHER_JOIN_DATE)
values (5, 'Kate', 'Feore', 5, 42328, 10942, to_date('09-07-1958', 'dd-mm-yyyy'));

insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_SALARY, TEACHER_JOIN_DATE)
values (6, 'Nicole', 'Hackman', 6, 96996, 12575, to_date('14-10-1971', 'dd-mm-yyyy'));

insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_SALARY, TEACHER_JOIN_DATE)
values (7, 'Mika', 'Aiken', 7, 57321, 13320, to_date('01-08-1992', 'dd-mm-yyyy'));

insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_SALARY, TEACHER_JOIN_DATE)
values (8, 'Hilton', 'Salonga', 8, 70912, 13361, to_date('24-05-1958', 'dd-mm-yyyy'));

insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_SALARY, TEACHER_JOIN_DATE)
values (9, 'Aaron', 'Todd', 9, 50162, 17706, to_date('04-05-1978', 'dd-mm-yyyy'));

insert into TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_ADDR, TEACHER_TEL, TEACHER_SALARY, TEACHER_JOIN_DATE)
values (10, 'Eddie', 'Jackman', 10, 84571, 14414, to_date('06-10-1952', 'dd-mm-yyyy'));

commit;


--INTO GROUPS
insert into GROUPS_ (GROUP_ID, AMOUNT, AGE_ID)
values (1, 10, 3);

insert into GROUPS_ (GROUP_ID, AMOUNT, AGE_ID)
values (2, 34, 3);

insert into GROUPS_ (GROUP_ID, AMOUNT, AGE_ID)
values (3, 10, 3);

insert into GROUPS_ (GROUP_ID, AMOUNT, AGE_ID)
values (4, 7, 1);

insert into GROUPS_ (GROUP_ID, AMOUNT, AGE_ID)
values (5, 1, 4);

insert into GROUPS_ (GROUP_ID, AMOUNT, AGE_ID)
values (6, 8, 2);

insert into GROUPS_ (GROUP_ID, AMOUNT, AGE_ID)
values (7, 11, 2);

insert into GROUPS_ (GROUP_ID, AMOUNT, AGE_ID)
values (8, 28, 5);

insert into GROUPS_ (GROUP_ID, AMOUNT, AGE_ID)
values (9, 37, 4);

insert into GROUPS_ (GROUP_ID, AMOUNT, AGE_ID)
values (10, 1, 3);

commit;

--into rooms
insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
values (1, 4, 'F', 28);

insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
values (2, 1, 'F', 37);

insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
values (3, 1, 'F', 12);

insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
values (4, 3, 'F', 4);

insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
values (5, 1, 'F', 23);

insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
values (6, 4, 'F', 16);

insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
values (7, 3, 'F', 33);

insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
values (8, 0, 'F', 24);

insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
values (9, 0, 'F', 5);

insert into ROOMS (ROOM_ID, ROOM_FLOOR, ISSTUDIO, ROOM_CAPACITY)
values (10, 0, 'F', 26);

commit;

--scheduler
insert into SCHEDULER (SC_TIME, SC_DAY, SCHEDULER_ID, GROUP_ID, WORKSHOP_ID, ROOM_ID, TEACHER_ID)
values (19, 5, 1, 1, 1, 2, 9);

insert into SCHEDULER (SC_TIME, SC_DAY, SCHEDULER_ID, GROUP_ID, WORKSHOP_ID, ROOM_ID, TEACHER_ID)
values (16, 1, 2, 2, 2, 9, 9);

insert into SCHEDULER (SC_TIME, SC_DAY, SCHEDULER_ID, GROUP_ID, WORKSHOP_ID, ROOM_ID, TEACHER_ID)
values (21, 7, 3, 3, 3, 2, 10);

insert into SCHEDULER (SC_TIME, SC_DAY, SCHEDULER_ID, GROUP_ID, WORKSHOP_ID, ROOM_ID, TEACHER_ID)
values (20, 1, 4, 4, 4, 7, 7);

insert into SCHEDULER (SC_TIME, SC_DAY, SCHEDULER_ID, GROUP_ID, WORKSHOP_ID, ROOM_ID, TEACHER_ID)
values (17, 4, 5, 5, 5, 7, 7);

insert into SCHEDULER (SC_TIME, SC_DAY, SCHEDULER_ID, GROUP_ID, WORKSHOP_ID, ROOM_ID, TEACHER_ID)
values (20, 5, 6, 6, 6, 3, 4);

insert into SCHEDULER (SC_TIME, SC_DAY, SCHEDULER_ID, GROUP_ID, WORKSHOP_ID, ROOM_ID, TEACHER_ID)
values (13, 2, 7, 7, 7, 3, 6);

insert into SCHEDULER (SC_TIME, SC_DAY, SCHEDULER_ID, GROUP_ID, WORKSHOP_ID, ROOM_ID, TEACHER_ID)
values (19, 5, 8, 8, 8, 3, 3);

insert into SCHEDULER (SC_TIME, SC_DAY, SCHEDULER_ID, GROUP_ID, WORKSHOP_ID, ROOM_ID, TEACHER_ID)
values (20, 4, 9, 9, 9, 8, 9);

insert into SCHEDULER (SC_TIME, SC_DAY, SCHEDULER_ID, GROUP_ID, WORKSHOP_ID, ROOM_ID, TEACHER_ID)
values (22, 2, 10, 10, 10, 10, 8);

commit;

--participate
insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (1, 1);

insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (2, 2);

insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (3, 3);

insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (4, 4);

insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (5, 5);

insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (6, 6);

insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (7, 7);

insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (8, 8);

insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (9, 9);

insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (10, 10);
insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (9, 74);
insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (9, 10);
insert into PARTICIPATE (GROUP_ID, CLIENT_ID)
values (5, 10);


commit;

--teach

insert into TEACH (WORKSHOP_ID, TEACHER_ID)
values (1, 1);

insert into TEACH (WORKSHOP_ID, TEACHER_ID)
values (2, 2);

insert into TEACH (WORKSHOP_ID, TEACHER_ID)
values (3, 3);

insert into TEACH (WORKSHOP_ID, TEACHER_ID)
values (4, 4);

insert into TEACH (WORKSHOP_ID, TEACHER_ID)
values (5, 5);

insert into TEACH (WORKSHOP_ID, TEACHER_ID)
values (6, 6);

insert into TEACH (WORKSHOP_ID, TEACHER_ID)
values (7, 7);

insert into TEACH (WORKSHOP_ID, TEACHER_ID)
values (8, 8);

insert into TEACH (WORKSHOP_ID, TEACHER_ID)
values (9, 9);

insert into TEACH (WORKSHOP_ID, TEACHER_ID)
values (10, 10);

commit;

