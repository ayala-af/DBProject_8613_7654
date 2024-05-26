prompt PL/SQL Developer import file
prompt Created on יום ראשון 26 מאי 2024 by User
set feedback off
set define off
prompt Creating AGE_GROUP...
create table AGE_GROUP
(
  age_id   NUMBER(5) not null,
  minage   NUMBER(5),
  maxage   NUMBER(5),
  descript VARCHAR2(15)
)
;
alter table AGE_GROUP
  add primary key (AGE_ID)
;

prompt Creating CITY...
create table CITY
(
  city_num  NUMBER(5) not null,
  city_name VARCHAR2(15)
)
;
alter table CITY
  add primary key (CITY_NUM)
;
alter table CITY
  add unique (CITY_NAME)
;

prompt Creating CLIENTS...
create table CLIENTS
(
  client_id      NUMBER(5) not null,
  client_fname   VARCHAR2(15),
  client_lname   VARCHAR2(15),
  client_addr    NUMBER(5),
  client_tel     NUMBER(5),
  client_payment NUMBER(5),
  birthday       DATE
)
;
alter table CLIENTS
  add primary key (CLIENT_ID)
;
alter table CLIENTS
  add foreign key (CLIENT_ADDR)
  references CITY (CITY_NUM);

prompt Creating GROUPS_...
create table GROUPS_
(
  group_id NUMBER(5) not null,
  amount   NUMBER(5),
  age_id   NUMBER(5)
)
;
alter table GROUPS_
  add primary key (GROUP_ID)
;
alter table GROUPS_
  add foreign key (AGE_ID)
  references AGE_GROUP (AGE_ID);

prompt Creating PARTICIPATE...
create table PARTICIPATE
(
  group_id  NUMBER(5) not null,
  client_id NUMBER(5) not null
)
;
alter table PARTICIPATE
  add primary key (GROUP_ID, CLIENT_ID)
  ;
alter table PARTICIPATE
  add foreign key (GROUP_ID)
  references GROUPS_ (GROUP_ID);
alter table PARTICIPATE
  add foreign key (CLIENT_ID)
  references CLIENTS (CLIENT_ID);

prompt Creating ROOMS...
create table ROOMS
(
  room_id       NUMBER(5) not null,
  room_floor    NUMBER(5),
  isstudio      CHAR(1),
  room_capacity NUMBER(5)
)
;
alter table ROOMS
  add primary key (ROOM_ID)
;
alter table ROOMS
  add check (isStudio IN ('T', 'F'));

prompt Creating TEACHERS...
create table TEACHERS
(
  teacher_id        NUMBER(5) not null,
  teacher_fname     VARCHAR2(15),
  teacher_lname     VARCHAR2(15),
  teacher_addr      NUMBER(5),
  teacher_tel       NUMBER(5),
  teacher_salary    NUMBER(5),
  teacher_join_date DATE
)
;
alter table TEACHERS
  add primary key (TEACHER_ID)
;
alter table TEACHERS
  add foreign key (TEACHER_ADDR)
  references CITY (CITY_NUM);

prompt Creating WORKSHOPS...
create table WORKSHOPS
(
  workshop_id       NUMBER(5) not null,
  workshop_name     VARCHAR2(15),
  workshop_price    NUMBER(5),
  workshop_hours    NUMBER(5),
  workshop_capacity NUMBER(5)
)
;
alter table WORKSHOPS
  add primary key (WORKSHOP_ID)
;

prompt Creating SCHEDULER...
create table SCHEDULER
(
  sc_time      NUMBER(5),
  sc_day       NUMBER(5),
  scheduler_id NUMBER(5) not null,
  group_id     NUMBER(5),
  workshop_id  NUMBER(5),
  room_id      NUMBER(5),
  teacher_id   NUMBER(5)
)
;
alter table SCHEDULER
  add primary key (SCHEDULER_ID)
 
alter table SCHEDULER
  add unique (SC_DAY, SC_TIME, ROOM_ID)
;
alter table SCHEDULER
  add unique (SC_DAY, SC_TIME, TEACHER_ID)
;
alter table SCHEDULER
  add foreign key (GROUP_ID)
  references GROUPS_ (GROUP_ID);
alter table SCHEDULER
  add foreign key (WORKSHOP_ID)
  references WORKSHOPS (WORKSHOP_ID);
alter table SCHEDULER
  add foreign key (ROOM_ID)
  references ROOMS (ROOM_ID);
alter table SCHEDULER
  add foreign key (TEACHER_ID)
  references TEACHERS (TEACHER_ID);
alter table SCHEDULER
  add check (sc_time BETWEEN 6 AND 24);
alter table SCHEDULER
  add check (sc_day BETWEEN 1 AND 7);

prompt Creating TEACH...
create table TEACH
(
  workshop_id NUMBER(5) not null,
  teacher_id  NUMBER(5) not null
)
;
alter table TEACH
  add primary key (WORKSHOP_ID, TEACHER_ID)
;
alter table TEACH
  add foreign key (WORKSHOP_ID)
  references WORKSHOPS (WORKSHOP_ID);
alter table TEACH
  add foreign key (TEACHER_ID)
  references TEACHERS (TEACHER_ID);

prompt Disabling triggers for AGE_GROUP...
alter table AGE_GROUP disable all triggers;
prompt Disabling triggers for CITY...
alter table CITY disable all triggers;
prompt Disabling triggers for CLIENTS...
alter table CLIENTS disable all triggers;
prompt Disabling triggers for GROUPS_...
alter table GROUPS_ disable all triggers;
prompt Disabling triggers for PARTICIPATE...
alter table PARTICIPATE disable all triggers;
prompt Disabling triggers for ROOMS...
alter table ROOMS disable all triggers;
prompt Disabling triggers for TEACHERS...
alter table TEACHERS disable all triggers;
prompt Disabling triggers for WORKSHOPS...
alter table WORKSHOPS disable all triggers;
prompt Disabling triggers for SCHEDULER...
alter table SCHEDULER disable all triggers;
prompt Disabling triggers for TEACH...
alter table TEACH disable all triggers;
prompt Disabling foreign key constraints for CLIENTS...
alter table CLIENTS disable constraint SYS_C007462;
prompt Disabling foreign key constraints for GROUPS_...
alter table GROUPS_ disable constraint SYS_C007467;
prompt Disabling foreign key constraints for PARTICIPATE...
alter table PARTICIPATE disable constraint SYS_C007483;
alter table PARTICIPATE disable constraint SYS_C007484;
prompt Disabling foreign key constraints for TEACHERS...
alter table TEACHERS disable constraint SYS_C007465;
prompt Disabling foreign key constraints for SCHEDULER...
alter table SCHEDULER disable constraint SYS_C007475;
alter table SCHEDULER disable constraint SYS_C007476;
alter table SCHEDULER disable constraint SYS_C007477;
alter table SCHEDULER disable constraint SYS_C007478;
prompt Disabling foreign key constraints for TEACH...
alter table TEACH disable constraint SYS_C007480;
alter table TEACH disable constraint SYS_C007481;
prompt Deleting TEACH...
delete from TEACH;
commit;
prompt Deleting SCHEDULER...
delete from SCHEDULER;
commit;
prompt Deleting WORKSHOPS...
delete from WORKSHOPS;
commit;
prompt Deleting TEACHERS...
delete from TEACHERS;
commit;
prompt Deleting ROOMS...
delete from ROOMS;
commit;
prompt Deleting PARTICIPATE...
delete from PARTICIPATE;
commit;
prompt Deleting GROUPS_...
delete from GROUPS_;
commit;
prompt Deleting CLIENTS...
delete from CLIENTS;
commit;
prompt Deleting CITY...
delete from CITY;
commit;
prompt Deleting AGE_GROUP...
delete from AGE_GROUP;
commit;
prompt Loading AGE_GROUP...
insert into AGE_GROUP (age_id, minage, maxage, descript)
values (1, 3, 5, 'Toddlers');
insert into AGE_GROUP (age_id, minage, maxage, descript)
values (2, 6, 12, 'Kids');
insert into AGE_GROUP (age_id, minage, maxage, descript)
values (3, 13, 17, 'Teens');
insert into AGE_GROUP (age_id, minage, maxage, descript)
values (4, 18, 60, 'Adults');
insert into AGE_GROUP (age_id, minage, maxage, descript)
values (5, 60, 120, 'Pensioners');
commit;
prompt 5 records loaded
prompt Loading CITY...
insert into CITY (city_num, city_name)
values (1, 'Archbold');
insert into CITY (city_num, city_name)
values (2, 'Framingaham');
insert into CITY (city_num, city_name)
values (3, 'Highton');
insert into CITY (city_num, city_name)
values (4, 'Douala');
insert into CITY (city_num, city_name)
values (5, 'Kejae City');
insert into CITY (city_num, city_name)
values (6, 'Burgess Hill');
insert into CITY (city_num, city_name)
values (7, 'Allen');
insert into CITY (city_num, city_name)
values (8, 'Natanya');
insert into CITY (city_num, city_name)
values (9, 'Bad Camberg');
insert into CITY (city_num, city_name)
values (10, 'South Hadley');
insert into CITY (city_num, city_name)
values (11, 'Belgrad');
insert into CITY (city_num, city_name)
values (12, 'Blacksburg');
insert into CITY (city_num, city_name)
values (13, 'Vallauris');
insert into CITY (city_num, city_name)
values (14, 'Chur');
insert into CITY (city_num, city_name)
values (15, 'Aniטres');
insert into CITY (city_num, city_name)
values (16, 'San Dimas');
insert into CITY (city_num, city_name)
values (17, 'Tours');
insert into CITY (city_num, city_name)
values (18, 'Reisterstown');
insert into CITY (city_num, city_name)
values (19, 'Pandrup');
insert into CITY (city_num, city_name)
values (20, 'Redhill');
insert into CITY (city_num, city_name)
values (21, 'Leawood');
insert into CITY (city_num, city_name)
values (22, 'Antwerpen');
insert into CITY (city_num, city_name)
values (23, 'Sendai');
insert into CITY (city_num, city_name)
values (24, 'Sundsvall');
insert into CITY (city_num, city_name)
values (25, 'Horsham');
insert into CITY (city_num, city_name)
values (26, 'Mechanicsburg');
insert into CITY (city_num, city_name)
values (27, 'Southampton');
insert into CITY (city_num, city_name)
values (28, 'Maserada sul Pi');
insert into CITY (city_num, city_name)
values (29, 'Gdansk');
insert into CITY (city_num, city_name)
values (30, 'Guadalajara');
insert into CITY (city_num, city_name)
values (31, 'South Weber');
insert into CITY (city_num, city_name)
values (32, 'Rancho Palos Ve');
insert into CITY (city_num, city_name)
values (33, 'Gaza');
insert into CITY (city_num, city_name)
values (34, 'Neustadt');
insert into CITY (city_num, city_name)
values (35, 'Kyoto');
insert into CITY (city_num, city_name)
values (36, 'Delafield');
insert into CITY (city_num, city_name)
values (37, 'Houston');
insert into CITY (city_num, city_name)
values (38, 'East Providence');
insert into CITY (city_num, city_name)
values (39, 'Szazhalombatta');
insert into CITY (city_num, city_name)
values (40, 'Barcelona');
insert into CITY (city_num, city_name)
values (41, 'Butner');
insert into CITY (city_num, city_name)
values (42, 'Burr Ridge');
insert into CITY (city_num, city_name)
values (43, 'Winnipeg');
insert into CITY (city_num, city_name)
values (44, 'Duesseldorf');
insert into CITY (city_num, city_name)
values (45, 'Chinnor');
insert into CITY (city_num, city_name)
values (46, 'Tulsa');
insert into CITY (city_num, city_name)
values (47, 'New York');
insert into CITY (city_num, city_name)
values (48, 'West Point');
insert into CITY (city_num, city_name)
values (49, 'Bad Oeynhausen');
insert into CITY (city_num, city_name)
values (50, 'Schlieren');
insert into CITY (city_num, city_name)
values (52, 'Yomgok-dong');
insert into CITY (city_num, city_name)
values (53, 'Kuopio');
insert into CITY (city_num, city_name)
values (54, 'S. Bernardo do ');
insert into CITY (city_num, city_name)
values (55, 'Berlin-Adlersho');
insert into CITY (city_num, city_name)
values (56, 'Charlotte');
insert into CITY (city_num, city_name)
values (57, 'Ohtsu');
insert into CITY (city_num, city_name)
values (58, 'Bangalore');
insert into CITY (city_num, city_name)
values (60, 'Kaysville');
insert into CITY (city_num, city_name)
values (61, 'Koeln');
insert into CITY (city_num, city_name)
values (62, 'Woodbridge');
insert into CITY (city_num, city_name)
values (63, 'Ashland');
insert into CITY (city_num, city_name)
values (65, 'Storrington');
insert into CITY (city_num, city_name)
values (66, 'Sapporo');
insert into CITY (city_num, city_name)
values (67, 'Lyngby');
insert into CITY (city_num, city_name)
values (68, 'Guelph');
insert into CITY (city_num, city_name)
values (69, 'Barnegat');
insert into CITY (city_num, city_name)
values (70, 'Helsinki');
insert into CITY (city_num, city_name)
values (71, 'Hunt Valley');
insert into CITY (city_num, city_name)
values (72, 'Osaka');
insert into CITY (city_num, city_name)
values (73, 'O''fallon');
insert into CITY (city_num, city_name)
values (74, 'Sutton');
insert into CITY (city_num, city_name)
values (75, 'Maarssen');
insert into CITY (city_num, city_name)
values (76, 'Forest Park');
insert into CITY (city_num, city_name)
values (77, 'Dreieich');
insert into CITY (city_num, city_name)
values (78, 'Hamburg');
insert into CITY (city_num, city_name)
values (79, 'Rorschach');
insert into CITY (city_num, city_name)
values (80, 'Bingham Farms');
insert into CITY (city_num, city_name)
values (82, 'Stocksbridge');
insert into CITY (city_num, city_name)
values (83, 'Araras');
insert into CITY (city_num, city_name)
values (84, 'Alexandria');
insert into CITY (city_num, city_name)
values (85, 'Waldbronn');
insert into CITY (city_num, city_name)
values (86, 'Maebashi');
insert into CITY (city_num, city_name)
values (88, 'Brisbane');
insert into CITY (city_num, city_name)
values (90, 'Kuraby');
insert into CITY (city_num, city_name)
values (91, 'Lefkosa');
insert into CITY (city_num, city_name)
values (92, 'Potsdam');
insert into CITY (city_num, city_name)
values (93, 'Cheshire');
insert into CITY (city_num, city_name)
values (94, 'Amsterdam');
insert into CITY (city_num, city_name)
values (95, 'St. Petersburg');
insert into CITY (city_num, city_name)
values (96, 'Milford');
insert into CITY (city_num, city_name)
values (97, 'Derwood');
insert into CITY (city_num, city_name)
values (98, 'Tyne & Wear');
insert into CITY (city_num, city_name)
values (100, 'Ringwood');
insert into CITY (city_num, city_name)
values (101, 'Bartlett');
insert into CITY (city_num, city_name)
values (102, 'Bozeman');
insert into CITY (city_num, city_name)
values (103, 'Pusan');
insert into CITY (city_num, city_name)
values (104, 'West Launceston');
insert into CITY (city_num, city_name)
values (105, 'Calgary');
insert into CITY (city_num, city_name)
values (106, 'Deerfield');
insert into CITY (city_num, city_name)
values (107, 'New boston');
commit;
prompt 100 records committed...
insert into CITY (city_num, city_name)
values (108, 'Peine');
insert into CITY (city_num, city_name)
values (109, 'Pomona');
insert into CITY (city_num, city_name)
values (110, 'Brookfield');
insert into CITY (city_num, city_name)
values (111, 'Kצln');
insert into CITY (city_num, city_name)
values (112, 'Silverdale');
insert into CITY (city_num, city_name)
values (113, 'Bekescsaba');
insert into CITY (city_num, city_name)
values (114, 'Soest');
insert into CITY (city_num, city_name)
values (115, 'Hartmannsdorf');
insert into CITY (city_num, city_name)
values (116, 'Foster City');
insert into CITY (city_num, city_name)
values (117, 'Eschborn');
insert into CITY (city_num, city_name)
values (118, 'Ft. Lauderdale');
insert into CITY (city_num, city_name)
values (119, 'Hanover');
insert into CITY (city_num, city_name)
values (120, 'Rockville');
insert into CITY (city_num, city_name)
values (121, 'Billerica');
insert into CITY (city_num, city_name)
values (122, 'Immenstaad');
insert into CITY (city_num, city_name)
values (123, 'New orleans');
insert into CITY (city_num, city_name)
values (125, 'Saudarkrokur');
insert into CITY (city_num, city_name)
values (126, 'Paisley');
insert into CITY (city_num, city_name)
values (127, 'Vantaa');
insert into CITY (city_num, city_name)
values (128, 'Ipswich');
insert into CITY (city_num, city_name)
values (129, 'Battle Creek');
insert into CITY (city_num, city_name)
values (130, 'Roanoke');
insert into CITY (city_num, city_name)
values (131, 'Fort gordon');
insert into CITY (city_num, city_name)
values (132, 'Slmea');
insert into CITY (city_num, city_name)
values (133, 'Ettlingen');
insert into CITY (city_num, city_name)
values (134, 'Tualatin');
insert into CITY (city_num, city_name)
values (135, 'Anyang-si');
insert into CITY (city_num, city_name)
values (137, 'San Antonio');
insert into CITY (city_num, city_name)
values (138, 'Hackensack');
insert into CITY (city_num, city_name)
values (139, 'Orlando');
insert into CITY (city_num, city_name)
values (141, 'Hearst');
insert into CITY (city_num, city_name)
values (142, 'Paris');
insert into CITY (city_num, city_name)
values (143, 'Londrina');
insert into CITY (city_num, city_name)
values (144, 'Bristol');
insert into CITY (city_num, city_name)
values (145, 'Itu');
insert into CITY (city_num, city_name)
values (146, 'Warrenton');
insert into CITY (city_num, city_name)
values (147, 'Ilmenau');
insert into CITY (city_num, city_name)
values (151, 'Kobe');
insert into CITY (city_num, city_name)
values (152, 'Matsuyama');
insert into CITY (city_num, city_name)
values (153, 'Kרbenhavn');
insert into CITY (city_num, city_name)
values (154, 'Huntsville');
insert into CITY (city_num, city_name)
values (155, 'Paal Beringen');
insert into CITY (city_num, city_name)
values (156, 'Biella');
insert into CITY (city_num, city_name)
values (157, 'Fort Lee');
insert into CITY (city_num, city_name)
values (158, 'Kingston');
insert into CITY (city_num, city_name)
values (159, 'Silver Spring');
insert into CITY (city_num, city_name)
values (160, 'Holts Summit');
insert into CITY (city_num, city_name)
values (161, 'Suberg');
insert into CITY (city_num, city_name)
values (162, 'durham');
insert into CITY (city_num, city_name)
values (163, 'Moreno Valley');
insert into CITY (city_num, city_name)
values (164, 'Nantes');
insert into CITY (city_num, city_name)
values (165, 'Salzburg');
insert into CITY (city_num, city_name)
values (166, 'Shizuoka');
insert into CITY (city_num, city_name)
values (167, 'Doncaster');
insert into CITY (city_num, city_name)
values (168, 'Yokohama');
insert into CITY (city_num, city_name)
values (169, 'Brussel');
insert into CITY (city_num, city_name)
values (170, 'Melrose park');
insert into CITY (city_num, city_name)
values (171, 'Drogenbos');
insert into CITY (city_num, city_name)
values (172, 'Morioka');
insert into CITY (city_num, city_name)
values (173, 'Ternitz');
insert into CITY (city_num, city_name)
values (174, 'Naestved');
insert into CITY (city_num, city_name)
values (175, 'Corona');
insert into CITY (city_num, city_name)
values (176, 'Annandale');
insert into CITY (city_num, city_name)
values (177, 'Gainesville');
insert into CITY (city_num, city_name)
values (178, 'Olsztyn');
insert into CITY (city_num, city_name)
values (179, 'Waldorf');
insert into CITY (city_num, city_name)
values (180, 'San Ramon');
insert into CITY (city_num, city_name)
values (182, 'Gelsenkirchen');
insert into CITY (city_num, city_name)
values (183, 'Redwood Shores');
insert into CITY (city_num, city_name)
values (184, 'Kozani');
insert into CITY (city_num, city_name)
values (185, 'Daejeon');
insert into CITY (city_num, city_name)
values (187, 'New York City');
insert into CITY (city_num, city_name)
values (188, 'Saint-vincent-d');
insert into CITY (city_num, city_name)
values (189, 'Dearborn');
insert into CITY (city_num, city_name)
values (190, 'Tokyo');
insert into CITY (city_num, city_name)
values (191, 'Eden prairie');
insert into CITY (city_num, city_name)
values (194, 'Valladolid');
insert into CITY (city_num, city_name)
values (195, 'Ohita');
insert into CITY (city_num, city_name)
values (196, 'Knoxville');
insert into CITY (city_num, city_name)
values (197, 'Neuchגtel');
insert into CITY (city_num, city_name)
values (198, 'Stellenbosch');
insert into CITY (city_num, city_name)
values (200, 'Bham');
insert into CITY (city_num, city_name)
values (201, 'Rosemead');
insert into CITY (city_num, city_name)
values (202, 'Fort Lewis');
insert into CITY (city_num, city_name)
values (203, 'Philadelphia');
insert into CITY (city_num, city_name)
values (204, 'Gummersbach');
insert into CITY (city_num, city_name)
values (205, 'Joinville');
insert into CITY (city_num, city_name)
values (206, 'Coppell');
insert into CITY (city_num, city_name)
values (207, 'Venice');
insert into CITY (city_num, city_name)
values (208, 'Campana');
insert into CITY (city_num, city_name)
values (210, 'Pottendorf');
insert into CITY (city_num, city_name)
values (211, 'Canal Wincheste');
insert into CITY (city_num, city_name)
values (212, 'Bologna');
insert into CITY (city_num, city_name)
values (214, 'Algermissen');
insert into CITY (city_num, city_name)
values (215, 'Fornacette');
insert into CITY (city_num, city_name)
values (216, 'Toulouse');
insert into CITY (city_num, city_name)
values (217, 'East sussex');
insert into CITY (city_num, city_name)
values (218, 'Suwon');
insert into CITY (city_num, city_name)
values (220, 'Bedford');
insert into CITY (city_num, city_name)
values (221, 'Budapest');
commit;
prompt 200 records committed...
insert into CITY (city_num, city_name)
values (222, 'Cobham');
insert into CITY (city_num, city_name)
values (223, 'Juneau');
insert into CITY (city_num, city_name)
values (224, 'Harsum');
insert into CITY (city_num, city_name)
values (226, 'Schenectady');
insert into CITY (city_num, city_name)
values (228, 'Karachi');
insert into CITY (city_num, city_name)
values (229, 'Tokushima');
insert into CITY (city_num, city_name)
values (230, 'Claymont');
insert into CITY (city_num, city_name)
values (231, 'High Wycombe');
insert into CITY (city_num, city_name)
values (232, 'Long Island Cit');
insert into CITY (city_num, city_name)
values (233, 'Takamatsu');
insert into CITY (city_num, city_name)
values (234, 'Bretzfeld-Waldb');
insert into CITY (city_num, city_name)
values (235, 'Rueil-Malmaison');
insert into CITY (city_num, city_name)
values (236, 'Billund');
insert into CITY (city_num, city_name)
values (237, 'West Windsor');
insert into CITY (city_num, city_name)
values (239, 'Chiba');
insert into CITY (city_num, city_name)
values (240, 'Tsu');
insert into CITY (city_num, city_name)
values (241, 'Golden');
insert into CITY (city_num, city_name)
values (242, 'Lathrop');
insert into CITY (city_num, city_name)
values (243, 'Yamaguchi');
insert into CITY (city_num, city_name)
values (244, 'Raleigh');
insert into CITY (city_num, city_name)
values (245, 'Luzern');
insert into CITY (city_num, city_name)
values (247, 'Wehrheim');
insert into CITY (city_num, city_name)
values (248, 'Lahr');
insert into CITY (city_num, city_name)
values (249, 'Colorado Spring');
insert into CITY (city_num, city_name)
values (250, 'Debary');
insert into CITY (city_num, city_name)
values (251, 'Rua eteno');
insert into CITY (city_num, city_name)
values (252, 'Fambach');
insert into CITY (city_num, city_name)
values (253, 'Ankara');
insert into CITY (city_num, city_name)
values (256, 'Reading');
insert into CITY (city_num, city_name)
values (257, 'Purley');
insert into CITY (city_num, city_name)
values (258, 'Dartmouth');
insert into CITY (city_num, city_name)
values (259, 'Athens');
insert into CITY (city_num, city_name)
values (260, 'Westport');
insert into CITY (city_num, city_name)
values (261, 'Buenos Aires');
insert into CITY (city_num, city_name)
values (262, 'Houma');
insert into CITY (city_num, city_name)
values (263, 'Paחo de Arcos');
insert into CITY (city_num, city_name)
values (264, 'Bruxelles');
insert into CITY (city_num, city_name)
values (265, 'London');
insert into CITY (city_num, city_name)
values (266, 'Adelaide');
insert into CITY (city_num, city_name)
values (267, 'Fairborn');
insert into CITY (city_num, city_name)
values (268, 'Burlington');
insert into CITY (city_num, city_name)
values (269, 'Fleet');
insert into CITY (city_num, city_name)
values (270, 'Porto alegre');
insert into CITY (city_num, city_name)
values (271, 'Carlingford');
insert into CITY (city_num, city_name)
values (272, 'Vienna');
insert into CITY (city_num, city_name)
values (274, 'Kaunas');
insert into CITY (city_num, city_name)
values (275, 'Bay Shore');
insert into CITY (city_num, city_name)
values (277, 'Victoria');
insert into CITY (city_num, city_name)
values (279, 'Trenton');
insert into CITY (city_num, city_name)
values (281, 'Glasgow');
insert into CITY (city_num, city_name)
values (282, 'Livermore');
insert into CITY (city_num, city_name)
values (283, 'Istanbul');
insert into CITY (city_num, city_name)
values (284, 'Tהby');
insert into CITY (city_num, city_name)
values (285, 'Chambery');
insert into CITY (city_num, city_name)
values (286, 'Tucson');
insert into CITY (city_num, city_name)
values (288, 'Cincinnati');
insert into CITY (city_num, city_name)
values (289, 'Erpe-Mere');
insert into CITY (city_num, city_name)
values (290, 'Reston');
insert into CITY (city_num, city_name)
values (291, 'Edison');
insert into CITY (city_num, city_name)
values (292, 'Mclean');
insert into CITY (city_num, city_name)
values (293, 'North Point');
insert into CITY (city_num, city_name)
values (294, 'Buffalo');
insert into CITY (city_num, city_name)
values (295, 'Brampton');
insert into CITY (city_num, city_name)
values (296, 'Benbrook');
insert into CITY (city_num, city_name)
values (297, 'Lund');
insert into CITY (city_num, city_name)
values (298, 'Germantown');
insert into CITY (city_num, city_name)
values (299, 'Dubai');
insert into CITY (city_num, city_name)
values (301, 'Alpharetta');
insert into CITY (city_num, city_name)
values (304, 'Vancouver');
insert into CITY (city_num, city_name)
values (305, 'Arlington');
insert into CITY (city_num, city_name)
values (306, 'Michendorf');
insert into CITY (city_num, city_name)
values (307, 'Regensburg');
insert into CITY (city_num, city_name)
values (308, 'Wilmington');
insert into CITY (city_num, city_name)
values (310, 'Netanya');
insert into CITY (city_num, city_name)
values (312, 'Dublin');
insert into CITY (city_num, city_name)
values (313, 'Regina');
insert into CITY (city_num, city_name)
values (314, 'Barbengo');
insert into CITY (city_num, city_name)
values (315, 'Los Alamos');
insert into CITY (city_num, city_name)
values (316, 'Redondo beach');
insert into CITY (city_num, city_name)
values (317, 'Irving');
insert into CITY (city_num, city_name)
values (318, 'Schaumburg');
insert into CITY (city_num, city_name)
values (319, 'Guamo');
insert into CITY (city_num, city_name)
values (320, 'Cleveland');
insert into CITY (city_num, city_name)
values (324, 'Madrid');
insert into CITY (city_num, city_name)
values (325, 'Dietikon');
insert into CITY (city_num, city_name)
values (326, 'Coventry');
insert into CITY (city_num, city_name)
values (327, 'Scottsdale');
insert into CITY (city_num, city_name)
values (330, 'Abbotsford');
insert into CITY (city_num, city_name)
values (331, 'Anchorage');
insert into CITY (city_num, city_name)
values (333, 'Woking');
insert into CITY (city_num, city_name)
values (334, 'Bellevue');
insert into CITY (city_num, city_name)
values (335, 'Pecs');
insert into CITY (city_num, city_name)
values (336, 'Hannover');
insert into CITY (city_num, city_name)
values (337, 'Milton');
insert into CITY (city_num, city_name)
values (340, 'Monterey');
insert into CITY (city_num, city_name)
values (344, 'Farnham');
insert into CITY (city_num, city_name)
values (345, 'Olympia');
insert into CITY (city_num, city_name)
values (347, 'Alcobendas');
insert into CITY (city_num, city_name)
values (348, 'Fredericia');
insert into CITY (city_num, city_name)
values (349, 'Thצrishaus');
commit;
prompt 300 records committed...
insert into CITY (city_num, city_name)
values (350, 'Durban');
insert into CITY (city_num, city_name)
values (351, 'Boucherville');
insert into CITY (city_num, city_name)
values (352, 'Groton');
insert into CITY (city_num, city_name)
values (354, 'Richardson');
insert into CITY (city_num, city_name)
values (355, 'Braintree');
insert into CITY (city_num, city_name)
values (356, 'Spring Valley');
insert into CITY (city_num, city_name)
values (357, 'West Drayton');
insert into CITY (city_num, city_name)
values (359, 'Altstהtten');
insert into CITY (city_num, city_name)
values (361, 'Birmingham');
insert into CITY (city_num, city_name)
values (363, 'Nagoya');
insert into CITY (city_num, city_name)
values (364, 'Brossard');
insert into CITY (city_num, city_name)
values (365, 'Edinburgh');
insert into CITY (city_num, city_name)
values (366, 'North Sydney');
insert into CITY (city_num, city_name)
values (367, 'Los Angeles');
insert into CITY (city_num, city_name)
values (368, 'Fuerth');
insert into CITY (city_num, city_name)
values (369, 'Hampton');
insert into CITY (city_num, city_name)
values (370, 'Milano');
insert into CITY (city_num, city_name)
values (371, 'Zagreb');
insert into CITY (city_num, city_name)
values (372, 'Exeter');
insert into CITY (city_num, city_name)
values (375, 'Princeton');
insert into CITY (city_num, city_name)
values (376, 'Kerava');
insert into CITY (city_num, city_name)
values (377, 'Kwun Tong');
insert into CITY (city_num, city_name)
values (379, 'Pusan-city');
insert into CITY (city_num, city_name)
values (380, 'Batavia');
insert into CITY (city_num, city_name)
values (382, 'Durham');
insert into CITY (city_num, city_name)
values (383, 'North Wales');
insert into CITY (city_num, city_name)
values (384, 'Heubach');
insert into CITY (city_num, city_name)
values (385, 'Unionville');
insert into CITY (city_num, city_name)
values (386, 'Peachtree City');
insert into CITY (city_num, city_name)
values (387, 'Pretoria');
insert into CITY (city_num, city_name)
values (389, 'Giessen');
insert into CITY (city_num, city_name)
values (390, 'Gaithersburg');
insert into CITY (city_num, city_name)
values (391, 'Aiken');
insert into CITY (city_num, city_name)
values (392, 'Stafford');
insert into CITY (city_num, city_name)
values (393, 'North bethesda');
insert into CITY (city_num, city_name)
values (394, 'Newbury');
insert into CITY (city_num, city_name)
values (395, 'Jakarta');
insert into CITY (city_num, city_name)
values (396, 'Bonn');
insert into CITY (city_num, city_name)
values (397, 'Warsaw');
insert into CITY (city_num, city_name)
values (398, 'Sevilla');
insert into CITY (city_num, city_name)
values (399, 'Saint Ouen');
insert into CITY (city_num, city_name)
values (400, 'Zuerich');
insert into CITY (city_num, city_name)
values (401, 'Kista');
insert into CITY (city_num, city_name)
values (403, 'Munich');
insert into CITY (city_num, city_name)
values (405, 'Tartu');
insert into CITY (city_num, city_name)
values (406, 'Cottbus');
insert into CITY (city_num, city_name)
values (408, 'Amherst');
insert into CITY (city_num, city_name)
values (411, 'Luedenscheid');
insert into CITY (city_num, city_name)
values (412, 'Walnut Creek');
insert into CITY (city_num, city_name)
values (413, 'Chennai');
insert into CITY (city_num, city_name)
values (414, 'St-bruno');
insert into CITY (city_num, city_name)
values (415, 'Coburg');
insert into CITY (city_num, city_name)
values (416, 'Sugar Land');
insert into CITY (city_num, city_name)
values (419, 'Herndon');
insert into CITY (city_num, city_name)
values (420, 'Dardilly');
insert into CITY (city_num, city_name)
values (421, 'Augsburg');
insert into CITY (city_num, city_name)
values (422, 'Genטve');
insert into CITY (city_num, city_name)
values (424, 'El Segundo');
insert into CITY (city_num, city_name)
values (425, 'Wuerzburg');
insert into CITY (city_num, city_name)
values (428, 'Syracuse');
insert into CITY (city_num, city_name)
values (430, 'St-laurent');
insert into CITY (city_num, city_name)
values (431, 'Waite Park');
insert into CITY (city_num, city_name)
values (432, 'Steyr');
insert into CITY (city_num, city_name)
values (433, 'Hyderabad');
insert into CITY (city_num, city_name)
values (434, 'Boulogne');
insert into CITY (city_num, city_name)
values (435, 'Nepean');
insert into CITY (city_num, city_name)
values (436, 'Kloten');
insert into CITY (city_num, city_name)
values (437, 'Ravensburg');
insert into CITY (city_num, city_name)
values (439, 'Fukui');
insert into CITY (city_num, city_name)
values (440, 'Bradenton');
insert into CITY (city_num, city_name)
values (441, 'Edenbridge');
insert into CITY (city_num, city_name)
values (442, 'Gauteng');
insert into CITY (city_num, city_name)
values (443, 'Kansas City');
insert into CITY (city_num, city_name)
values (445, 'Ismaning');
insert into CITY (city_num, city_name)
values (447, 'Hilversum');
insert into CITY (city_num, city_name)
values (449, 'Hהssleholm');
insert into CITY (city_num, city_name)
values (450, 'Concordville');
insert into CITY (city_num, city_name)
values (455, 'New Haven');
insert into CITY (city_num, city_name)
values (456, 'Waco');
insert into CITY (city_num, city_name)
values (458, 'Parma');
insert into CITY (city_num, city_name)
values (459, 'Virginia Beach');
insert into CITY (city_num, city_name)
values (461, 'Marietta');
insert into CITY (city_num, city_name)
values (463, 'Park Ridge');
insert into CITY (city_num, city_name)
values (464, 'Fremont');
insert into CITY (city_num, city_name)
values (466, 'Herne');
insert into CITY (city_num, city_name)
values (467, 'Kungki');
insert into CITY (city_num, city_name)
values (468, 'Roma');
insert into CITY (city_num, city_name)
values (469, 'Greenwood Villa');
insert into CITY (city_num, city_name)
values (472, 'Richmond');
insert into CITY (city_num, city_name)
values (473, 'Pompton Plains');
insert into CITY (city_num, city_name)
values (474, 'Warren');
insert into CITY (city_num, city_name)
values (476, 'Enschede');
insert into CITY (city_num, city_name)
values (478, 'Enfield');
insert into CITY (city_num, city_name)
values (479, 'Turku');
insert into CITY (city_num, city_name)
values (480, 'Clark');
insert into CITY (city_num, city_name)
values (482, 'Canberra');
insert into CITY (city_num, city_name)
values (483, 'Gattico');
insert into CITY (city_num, city_name)
values (484, 'Somerset');
insert into CITY (city_num, city_name)
values (485, 'Hayward');
insert into CITY (city_num, city_name)
values (486, 'Huntington');
commit;
prompt 400 records committed...
insert into CITY (city_num, city_name)
values (487, 'Bracknell');
insert into CITY (city_num, city_name)
values (488, 'Bielefeld');
insert into CITY (city_num, city_name)
values (493, 'Cape town');
insert into CITY (city_num, city_name)
values (494, 'Rockford');
insert into CITY (city_num, city_name)
values (495, 'Grand Rapids');
insert into CITY (city_num, city_name)
values (496, 'Vista');
insert into CITY (city_num, city_name)
values (497, 'Beaverton');
insert into CITY (city_num, city_name)
values (499, 'Koufu');
insert into CITY (city_num, city_name)
values (500, 'Melbourne');
insert into CITY (city_num, city_name)
values (503, 'Chicago');
insert into CITY (city_num, city_name)
values (504, 'Manchester');
insert into CITY (city_num, city_name)
values (505, 'Media');
insert into CITY (city_num, city_name)
values (508, 'Cannock');
insert into CITY (city_num, city_name)
values (509, 'Verdun');
insert into CITY (city_num, city_name)
values (510, 'Summerside');
commit;
prompt 415 records loaded
prompt Loading CLIENTS...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1, 'Andre', 'Burton', 1, 91284, 201, to_date('10-02-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (2, 'Glen', 'Meyer', 2, 69755, 222, to_date('23-02-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (3, 'Davis', 'Posener', 3, 16955, 362, to_date('11-01-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (4, 'Fairuza', 'Gibbons', 4, 69060, 332, to_date('16-02-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (5, 'Jackie', 'Vance', 5, 87283, 335, to_date('31-08-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (6, 'Chad', 'Sawa', 6, 36592, 182, to_date('11-12-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (7, 'Natasha', 'Cassidy', 7, 61826, 257, to_date('30-09-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (8, 'Kyra', 'Worrell', 8, 10109, 299, to_date('13-11-1989', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (9, 'Raul', 'Mazzello', 9, 23367, 273, to_date('27-02-1988', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (10, 'Wade', 'Clinton', 10, 88313, 391, to_date('24-05-1992', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (11, 'Seann', 'Pleasure', 383, 23724, 223, to_date('18-03-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (13, 'Tzi', 'Dickinson', 178, 14932, 306, to_date('14-04-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (14, 'Dick', 'Andrews', 325, 78976, 165, to_date('02-08-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (15, 'Mae', 'Mohr', 295, 19379, 331, to_date('16-09-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (16, 'Vin', 'Lipnicki', 146, 95435, 206, to_date('20-03-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (17, 'Dennis', 'Chambers', 371, 13246, 334, to_date('18-09-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (18, 'Amanda', 'Galecki', 253, 73631, 265, to_date('17-04-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (19, 'Nik', 'Peet', 26, 55925, 228, to_date('22-02-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (20, 'Warren', 'Rodgers', 272, 97220, 308, to_date('19-06-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (21, 'Jonny Lee', 'Peet', 296, 21980, 157, to_date('29-05-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (22, 'Allan', 'Heron', 32, 38091, 293, to_date('02-07-1988', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (23, 'Anjelica', 'Flatts', 372, 77805, 194, to_date('29-11-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (24, 'Jose', 'Fiennes', 39, 56454, 313, to_date('29-10-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (25, 'Kazem', 'Kudrow', 397, 53761, 197, to_date('01-10-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (26, 'Christian', 'Craig', 182, 92722, 247, to_date('01-11-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (27, 'Ray', 'O''Keefe', 379, 25072, 209, to_date('10-10-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (28, 'Mitchell', 'Phifer', 368, 90739, 312, to_date('20-09-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (29, 'Kelly', 'Cheadle', 170, 27265, 333, to_date('02-05-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (31, 'Christine', 'Pacino', 377, 94427, 338, to_date('19-04-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (32, 'Trick', 'Bonham', 37, 92020, 156, to_date('28-01-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (33, 'Jeroen', 'Krieger', 155, 31070, 321, to_date('07-03-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (34, 'Andie', 'Bloch', 162, 36013, 383, to_date('21-12-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (35, 'Charlie', 'Willis', 335, 60877, 299, to_date('20-05-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (36, 'Mia', 'Grant', 292, 56531, 283, to_date('04-06-2005', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (37, 'Emilio', 'Saucedo', 58, 98120, 161, to_date('13-01-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (38, 'Phil', 'Shorter', 306, 31971, 160, to_date('03-11-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (39, 'Peabo', 'Waits', 347, 90018, 256, to_date('24-10-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (40, 'Gene', 'Cobbs', 183, 60360, 381, to_date('17-07-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (41, 'Burt', 'Colon', 198, 30829, 165, to_date('27-09-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (43, 'Emma', 'Schwimmer', 32, 70950, 297, to_date('28-11-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (44, 'Cuba', 'Dean', 232, 60641, 376, to_date('04-09-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (45, 'William', 'Starr', 269, 86805, 236, to_date('09-08-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (46, 'Paula', 'Moreno', 232, 91908, 352, to_date('31-07-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (47, 'Jeremy', 'Shatner', 74, 79810, 370, to_date('18-03-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (48, 'Taye', 'Himmelman', 16, 62370, 250, to_date('20-04-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (49, 'Maury', 'Richards', 243, 95190, 336, to_date('06-12-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (50, 'Rutger', 'Gooding', 137, 37426, 320, to_date('06-05-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (52, 'Nicholas', 'Devine', 85, 20844, 186, to_date('22-06-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (53, 'Thin', 'Suvari', 183, 63641, 177, to_date('12-07-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (54, 'Liev', 'Def', 382, 20224, 204, to_date('06-09-1989', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (55, 'Sonny', 'Schreiber', 131, 56626, 285, to_date('08-05-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (56, 'Robert', 'Aykroyd', 195, 19734, 290, to_date('24-09-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (58, 'Noah', 'Witt', 65, 47156, 302, to_date('28-09-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (59, 'Sophie', 'Rankin', 355, 52604, 381, to_date('25-07-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (62, 'Millie', 'Carradine', 260, 36093, 313, to_date('04-09-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (63, 'Nathan', 'Langella', 94, 64000, 314, to_date('18-07-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (66, 'Geoffrey', 'Puckett', 364, 30551, 327, to_date('12-09-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (67, 'Max', 'Buffalo', 293, 17035, 282, to_date('14-08-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (69, 'Fairuza', 'Malone', 166, 82076, 385, to_date('27-05-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (70, 'Johnny', 'Pride', 382, 59947, 374, to_date('14-09-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (72, 'Sophie', 'Venora', 379, 19970, 386, to_date('08-08-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (73, 'Frank', 'Hauer', 97, 90421, 365, to_date('07-04-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (74, 'Crispin', 'Stamp', 318, 95472, 319, to_date('15-06-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (75, 'Sona', 'Cole', 243, 87687, 252, to_date('24-01-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (76, 'Ty', 'Foley', 218, 62302, 205, to_date('09-11-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (77, 'Curt', 'Scott', 391, 32722, 174, to_date('26-03-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (78, 'Tracy', 'Cantrell', 307, 11604, 323, to_date('26-04-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (79, 'Kelli', 'Rispoli', 29, 46876, 325, to_date('17-04-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (81, 'Faye', 'Foster', 14, 93949, 348, to_date('11-02-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (82, 'Marlon', 'Rudd', 264, 93226, 389, to_date('03-08-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (83, 'Rosanne', 'Theron', 330, 68548, 150, to_date('10-10-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (84, 'Mandy', 'Puckett', 114, 13562, 338, to_date('15-06-1967', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (85, 'Harvey', 'Slater', 283, 25863, 165, to_date('23-10-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (86, 'Chrissie', 'Willard', 258, 18391, 230, to_date('01-05-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (87, 'Joey', 'Stevens', 204, 31138, 342, to_date('02-06-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (88, 'Joy', 'Orbit', 174, 69124, 183, to_date('24-05-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (90, 'Geena', 'Sizemore', 15, 96692, 225, to_date('29-10-1953', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (91, 'Jarvis', 'Weiss', 71, 70257, 346, to_date('21-02-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (92, 'Corey', 'Cronin', 298, 70088, 201, to_date('30-08-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (93, 'Hex', 'Mattea', 367, 68976, 355, to_date('27-05-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (94, 'Solomon', 'Dunn', 344, 83271, 188, to_date('29-07-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (95, 'Rolando', 'Gere', 347, 29725, 325, to_date('05-05-1973', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (96, 'Aaron', 'Stanton', 143, 84975, 191, to_date('31-10-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (97, 'Hookah', 'Walken', 91, 44165, 374, to_date('20-10-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (98, 'Whoopi', 'Callow', 86, 68447, 233, to_date('03-11-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (99, 'Jessica', 'Badalucco', 201, 43229, 231, to_date('23-05-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (100, 'Jeffrey', 'Idol', 241, 30651, 240, to_date('26-12-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (101, 'Deborah', 'Cazale', 392, 16345, 363, to_date('21-07-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (103, 'Donald', 'Winstone', 36, 86612, 342, to_date('19-03-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (104, 'Junior', 'Ruiz', 147, 97903, 379, to_date('08-05-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (105, 'Ed', 'Redgrave', 206, 32704, 286, to_date('26-10-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (106, 'Randall', 'Epps', 120, 68888, 177, to_date('25-01-1989', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (107, 'Kathleen', 'Cale', 97, 30780, 241, to_date('27-11-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (108, 'Busta', 'Flanery', 95, 12624, 323, to_date('12-07-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (109, 'Horace', 'Crimson', 357, 92186, 199, to_date('02-06-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (110, 'Joy', 'Postlethwaite', 167, 36082, 329, to_date('11-04-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (111, 'Sammy', 'Marshall', 3, 15237, 259, to_date('20-06-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (112, 'Vin', 'Uggams', 190, 12632, 287, to_date('09-04-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (113, 'Nicole', 'Creek', 60, 71837, 235, to_date('17-04-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (114, 'Tobey', 'Gore', 112, 14362, 323, to_date('15-07-1949', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (115, 'Chantי', 'Snider', 3, 62248, 364, to_date('11-07-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (117, 'Vivica', 'DiBiasio', 333, 63773, 276, to_date('24-01-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (119, 'Ceili', 'Coe', 361, 11624, 255, to_date('06-03-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (120, 'Raul', 'Mitchell', 397, 49674, 341, to_date('27-09-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (121, 'Walter', 'Crewson', 347, 42785, 342, to_date('15-08-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (122, 'Gran', 'Mann', 33, 65288, 322, to_date('27-08-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (123, 'Tea', 'Sainte-Marie', 58, 46126, 161, to_date('13-11-1995', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (124, 'Gord', 'Wilder', 114, 22064, 311, to_date('15-07-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (125, 'Mia', 'Tucci', 292, 34558, 173, to_date('15-10-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (126, 'Johnette', 'Coward', 207, 95179, 277, to_date('10-01-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (127, 'Clive', 'Jackson', 29, 97510, 340, to_date('02-05-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (128, 'Davis', 'Tarantino', 240, 53459, 243, to_date('11-07-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (129, 'Willie', 'Weiss', 372, 64517, 277, to_date('25-01-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (130, 'Chely', 'Caldwell', 256, 24280, 360, to_date('12-01-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (131, 'Hilary', 'Salt', 116, 23179, 281, to_date('17-08-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (133, 'Rowan', 'Garr', 326, 67303, 159, to_date('04-06-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (134, 'Machine', 'Khan', 125, 90922, 253, to_date('11-09-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (135, 'Marc', 'Wolf', 154, 13473, 367, to_date('06-03-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (136, 'Brent', 'Donovan', 157, 60458, 365, to_date('02-11-1967', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (137, 'Hex', 'Fraser', 274, 26868, 280, to_date('13-02-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (139, 'Emilio', 'Driver', 375, 59574, 225, to_date('30-11-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (140, 'Alana', 'Ruffalo', 196, 18219, 209, to_date('12-04-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (142, 'Don', 'Stoltz', 326, 25861, 181, to_date('06-03-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (145, 'Loreena', 'Badalucco', 57, 23668, 175, to_date('01-10-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (146, 'Leslie', 'Belles', 60, 46663, 285, to_date('10-12-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (147, 'Jonatha', 'Kleinenberg', 400, 50003, 363, to_date('17-07-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (148, 'Percy', 'Malone', 365, 47724, 256, to_date('28-02-1961', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (149, 'Bonnie', 'Yankovic', 173, 84997, 226, to_date('07-05-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (150, 'Loreena', 'MacDowell', 48, 89901, 252, to_date('31-05-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (151, 'Juice', 'Neil', 71, 30867, 231, to_date('17-12-1989', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (152, 'Debbie', 'Lynn', 188, 98933, 171, to_date('11-12-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (153, 'Seann', 'Burmester', 208, 65866, 383, to_date('05-10-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (154, 'Janice', 'Crosby', 224, 69397, 210, to_date('14-01-1967', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (156, 'Mary', 'Melvin', 310, 68555, 360, to_date('14-11-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (157, 'Wayman', 'Matarazzo', 17, 20127, 153, to_date('26-10-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (158, 'Udo', 'Lachey', 217, 33583, 300, to_date('15-11-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (159, 'Naomi', 'Fogerty', 134, 35765, 393, to_date('29-05-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (160, 'Madeline', 'De Niro', 262, 66681, 199, to_date('28-08-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (163, 'Kenny', 'Nunn', 196, 43107, 380, to_date('30-06-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (164, 'Graham', 'Lineback', 68, 65813, 299, to_date('06-06-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (165, 'Candice', 'Costner', 55, 63826, 396, to_date('12-03-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (166, 'Jean', 'Griggs', 274, 96207, 200, to_date('24-05-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (167, 'Tcheky', 'Wills', 48, 93920, 173, to_date('03-03-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (168, 'Ruth', 'Cagle', 384, 56434, 159, to_date('14-05-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (169, 'Gin', 'Idle', 152, 84601, 260, to_date('16-02-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (170, 'Maggie', 'Harrelson', 253, 89345, 186, to_date('08-02-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (172, 'Cyndi', 'Mandrell', 157, 28197, 156, to_date('11-12-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (173, 'Eugene', 'Viterelli', 375, 92263, 375, to_date('12-09-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (174, 'Hope', 'Faithfull', 202, 43957, 256, to_date('31-12-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (175, 'Merrilee', 'Kramer', 286, 86972, 389, to_date('25-05-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (176, 'Mel', 'Garza', 222, 46743, 367, to_date('30-08-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (177, 'Taylor', 'Pride', 179, 56757, 158, to_date('02-01-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (178, 'LeVar', 'Carnes', 187, 98460, 254, to_date('21-10-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (179, 'Joshua', 'Cube', 326, 39283, 250, to_date('11-02-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (180, 'Joy', 'Himmelman', 5, 66140, 205, to_date('06-06-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (181, 'Greg', 'Eastwood', 138, 19664, 295, to_date('20-12-2005', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (182, 'Bebe', 'Osbourne', 145, 98029, 341, to_date('02-09-2004', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (183, 'Giovanni', 'Kingsley', 103, 54151, 288, to_date('04-05-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (184, 'Madeleine', 'Graham', 168, 16950, 400, to_date('09-06-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (185, 'Harrison', 'Black', 291, 31799, 358, to_date('09-12-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (186, 'Harrison', 'Beckham', 390, 67974, 319, to_date('18-01-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (188, 'Collin', 'Baldwin', 371, 79924, 296, to_date('19-08-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (189, 'Garland', 'Eat World', 207, 51436, 153, to_date('15-05-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (190, 'Bridget', 'Allan', 38, 62751, 287, to_date('19-03-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (191, 'Judge', 'Parsons', 157, 85396, 329, to_date('11-09-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (192, 'Powers', 'Skaggs', 158, 65313, 234, to_date('23-09-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (193, 'Cuba', 'Hamilton', 385, 73149, 257, to_date('11-07-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (194, 'Wayman', 'Murphy', 153, 20581, 371, to_date('30-04-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (195, 'CeCe', 'Choice', 296, 31731, 286, to_date('30-05-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (196, 'Kurtwood', 'Kudrow', 173, 57812, 256, to_date('24-10-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (197, 'Glen', 'Yorn', 167, 37292, 258, to_date('22-04-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (198, 'Carlos', 'Portman', 30, 73713, 279, to_date('12-01-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (199, 'Mae', 'Dunst', 336, 34486, 187, to_date('22-11-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (200, 'Carlos', 'Hong', 98, 77129, 392, to_date('30-06-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (201, 'Arnold', 'Osborne', 191, 60094, 200, to_date('23-01-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (202, 'Lucinda', 'Olin', 190, 54296, 195, to_date('29-08-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (203, 'Alessandro', 'Pleasence', 232, 44153, 347, to_date('13-08-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (204, 'Julio', 'Pfeiffer', 113, 14171, 273, to_date('06-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (205, 'Stephen', 'Rickman', 152, 84379, 240, to_date('16-07-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (206, 'Fisher', 'Vai', 110, 85888, 241, to_date('14-12-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (207, 'Jack', 'Brody', 384, 42164, 275, to_date('03-06-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (208, 'Eric', 'Loggia', 291, 22864, 325, to_date('16-06-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (210, 'Denny', 'Benet', 270, 10582, 269, to_date('23-05-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (211, 'Bret', 'Oszajca', 289, 60058, 194, to_date('16-10-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (213, 'Mos', 'Kweller', 268, 90399, 325, to_date('27-06-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (214, 'Thomas', 'Farris', 131, 81761, 233, to_date('15-01-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (215, 'Roberta', 'Buffalo', 126, 69259, 255, to_date('21-02-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (216, 'Vendetta', 'Davison', 260, 76273, 310, to_date('24-11-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (217, 'Bebe', 'Roundtree', 397, 76024, 398, to_date('30-06-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (218, 'Garth', 'Palminteri', 37, 42476, 392, to_date('01-01-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (220, 'Judge', 'Keen', 281, 39031, 383, to_date('07-01-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (221, 'Simon', 'Zane', 24, 86735, 342, to_date('22-07-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (222, 'Todd', 'Sewell', 236, 99450, 333, to_date('28-05-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (223, 'Vondie', 'Mantegna', 91, 59812, 308, to_date('03-08-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (225, 'Earl', 'Beck', 268, 51058, 191, to_date('11-04-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (228, 'Jay', 'Oldman', 252, 69906, 180, to_date('01-12-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (230, 'Katie', 'Palin', 82, 80833, 285, to_date('07-01-1948', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (231, 'Jackie', 'Hewett', 137, 14206, 395, to_date('18-04-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (232, 'Marc', 'Jane', 272, 46343, 254, to_date('06-01-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (233, 'Morris', 'Slater', 40, 10036, 389, to_date('22-05-1995', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (235, 'Joe', 'Johansen', 275, 71128, 223, to_date('07-07-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (236, 'Victoria', 'Lindo', 299, 60251, 224, to_date('30-07-1961', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (237, 'Donald', 'Walken', 24, 23050, 373, to_date('02-06-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (238, 'Marlon', 'Yankovic', 66, 79672, 388, to_date('10-07-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (239, 'Angela', 'Maguire', 78, 62282, 276, to_date('03-02-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (240, 'Nancy', 'Ifans', 90, 50094, 400, to_date('22-05-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (241, 'Ashton', 'Jones', 1, 98467, 282, to_date('15-04-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (242, 'Candice', 'McDonnell', 188, 96361, 180, to_date('11-03-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (243, 'Kelly', 'Rudd', 95, 74798, 172, to_date('14-05-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (244, 'Howie', 'Morton', 15, 36824, 374, to_date('09-07-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (245, 'Clarence', 'Gambon', 301, 92330, 220, to_date('19-09-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (247, 'Daniel', 'Dalton', 310, 86473, 277, to_date('10-06-1988', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (248, 'Leo', 'Lynne', 85, 31952, 250, to_date('31-03-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (249, 'Ozzy', 'Coughlan', 27, 86480, 196, to_date('07-01-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (250, 'Meg', 'Streep', 366, 86856, 232, to_date('22-06-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (251, 'Rowan', 'Emmett', 53, 41184, 251, to_date('06-02-1974', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (252, 'Curtis', 'Gallant', 125, 41237, 194, to_date('28-06-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (253, 'Benjamin', 'Wilson', 331, 16778, 202, to_date('05-10-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (255, 'Rita', 'Craig', 31, 64922, 300, to_date('22-09-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (256, 'Wayne', 'Beck', 257, 74003, 310, to_date('13-11-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (257, 'Mykelti', 'Neil', 203, 71949, 262, to_date('28-06-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (258, 'Cyndi', 'Coughlan', 284, 96095, 172, to_date('17-08-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (259, 'Garry', 'Holly', 84, 12456, 378, to_date('26-04-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (260, 'Lea', 'Lynch', 114, 68081, 351, to_date('07-04-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (261, 'Timothy', 'Tate', 391, 63061, 166, to_date('11-07-1926', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (262, 'Miki', 'Murphy', 23, 17459, 329, to_date('03-01-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (263, 'Ewan', 'Danes', 270, 54611, 344, to_date('29-07-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (264, 'Daryl', 'Quinlan', 379, 90374, 250, to_date('26-12-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (265, 'Meg', 'Bacon', 250, 13616, 174, to_date('26-10-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (266, 'Hal', 'Blackwell', 175, 37171, 219, to_date('18-01-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (267, 'Andie', 'DiFranco', 68, 56187, 323, to_date('04-01-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (268, 'Teena', 'McGowan', 248, 93049, 242, to_date('21-06-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (269, 'Joey', 'Smurfit', 306, 80278, 160, to_date('06-11-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (271, 'Richie', 'Dench', 113, 84486, 268, to_date('02-03-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (272, 'Leelee', 'Niven', 19, 35356, 298, to_date('27-07-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (273, 'Boyd', 'Lillard', 153, 74217, 214, to_date('15-08-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (274, 'Alessandro', 'Pierce', 320, 61625, 153, to_date('23-12-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (276, 'Loren', 'Albright', 3, 11065, 399, to_date('21-05-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (277, 'Debby', 'Peniston', 73, 23084, 199, to_date('18-09-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (278, 'Rolando', 'Gryner', 35, 93113, 301, to_date('02-07-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (279, 'Carol', 'Randal', 123, 48578, 307, to_date('26-07-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (280, 'Treat', 'Woodard', 166, 21535, 382, to_date('30-08-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (282, 'Terry', 'Pesci', 282, 47571, 209, to_date('08-04-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (283, 'Chantי', 'Thomas', 71, 27072, 359, to_date('26-08-1967', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (284, 'Elizabeth', 'Fox', 88, 24405, 368, to_date('03-10-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (285, 'Mary', 'Perlman', 91, 24816, 280, to_date('06-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (286, 'Ty', 'Tisdale', 130, 65013, 289, to_date('18-12-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (287, 'Sigourney', 'Blaine', 170, 49134, 339, to_date('29-12-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (288, 'Juliette', 'Snipes', 55, 77909, 265, to_date('04-03-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (289, 'Ronny', 'Tinsley', 115, 51886, 304, to_date('29-07-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (290, 'Famke', 'Tyson', 122, 77819, 210, to_date('03-04-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (291, 'Philip', 'Kristofferson', 386, 64497, 395, to_date('25-05-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (292, 'Meryl', 'Tah', 69, 40822, 356, to_date('16-08-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (293, 'Ann', 'Shandling', 179, 20617, 397, to_date('04-10-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (295, 'Jody', 'Reeves', 55, 19736, 397, to_date('09-03-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (296, 'Bette', 'Bentley', 390, 88020, 196, to_date('14-09-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (297, 'Lou', 'Martinez', 272, 82524, 220, to_date('27-04-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (298, 'Heath', 'Finn', 29, 18004, 218, to_date('10-07-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (299, 'Boyd', 'Van Helden', 94, 91177, 171, to_date('30-10-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (300, 'Tcheky', 'Ramirez', 396, 61676, 370, to_date('07-02-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (302, 'Etta', 'Lang', 286, 17369, 223, to_date('26-08-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (303, 'Daryl', 'Reinhold', 131, 68432, 190, to_date('31-08-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (304, 'Shannon', 'Arkenstone', 173, 88075, 291, to_date('14-05-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (305, 'Warren', 'Kravitz', 132, 65482, 277, to_date('16-05-1973', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (306, 'Wally', 'Newman', 345, 84704, 165, to_date('26-09-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (307, 'Neve', 'Schreiber', 162, 48562, 208, to_date('16-08-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (308, 'Gin', 'Freeman', 28, 30054, 359, to_date('28-03-1926', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (309, 'John', 'Richardson', 324, 82787, 290, to_date('15-10-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (310, 'Kay', 'Buscemi', 135, 55516, 322, to_date('01-06-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (311, 'Humberto', 'Springfield', 334, 10856, 364, to_date('01-02-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (312, 'Susan', 'Keen', 326, 25071, 175, to_date('28-07-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (315, 'Maggie', 'Collie', 50, 72250, 220, to_date('26-09-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (316, 'Swoosie', 'Haggard', 55, 38894, 351, to_date('11-10-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (317, 'Jose', 'Swayze', 366, 46600, 182, to_date('09-12-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (318, 'Jake', 'McGriff', 258, 29912, 200, to_date('12-04-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (319, 'Gavin', 'Ward', 4, 73355, 270, to_date('14-07-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (320, 'Michelle', 'Fox', 115, 54922, 380, to_date('12-11-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (321, 'Eileen', 'Spector', 29, 19434, 213, to_date('09-03-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (322, 'Crystal', 'Pepper', 78, 57462, 331, to_date('17-12-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (323, 'Howard', 'Schock', 335, 25119, 386, to_date('13-09-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (324, 'Orlando', 'Pigott-Smith', 128, 89117, 348, to_date('04-01-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (325, 'Max', 'Harper', 102, 35624, 371, to_date('26-07-1995', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (326, 'Sander', 'Hannah', 33, 21303, 281, to_date('29-11-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (327, 'Harriet', 'Frakes', 110, 66114, 228, to_date('27-10-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (328, 'Marley', 'Kimball', 379, 30582, 223, to_date('22-09-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (329, 'Jimmie', 'Arkin', 56, 70949, 250, to_date('12-02-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (331, 'Eddie', 'McGoohan', 135, 20443, 358, to_date('16-12-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (332, 'Ralph', 'Allison', 78, 27744, 213, to_date('25-07-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (333, 'Vickie', 'Keith', 247, 90910, 320, to_date('25-07-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (334, 'Clint', 'McKennitt', 282, 19817, 226, to_date('27-05-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (336, 'Rosie', 'Ness', 351, 70174, 210, to_date('23-05-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (338, 'Famke', 'Tilly', 40, 96430, 255, to_date('25-09-1953', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (339, 'Beverley', 'Roth', 137, 45025, 287, to_date('25-02-2017', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (340, 'Fiona', 'Phillippe', 348, 26026, 313, to_date('24-03-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (341, 'Remy', 'Walsh', 290, 44067, 335, to_date('01-07-1967', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (343, 'Caroline', 'Ammons', 214, 51091, 278, to_date('31-10-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (344, 'Jennifer', 'Cartlidge', 86, 45108, 169, to_date('27-08-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (345, 'Christine', 'Speaks', 161, 32130, 266, to_date('19-01-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (346, 'Bonnie', 'Osbourne', 187, 26321, 353, to_date('16-05-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (347, 'Joaquin', 'Forrest', 23, 32315, 331, to_date('17-06-1952', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (348, 'Katie', 'Perez', 11, 67568, 158, to_date('05-10-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (349, 'Rolando', 'Linney', 320, 40384, 330, to_date('29-11-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (350, 'Cate', 'Holeman', 27, 74413, 170, to_date('03-05-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (351, 'Lindsey', 'Serbedzija', 326, 40994, 252, to_date('21-09-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (352, 'Faye', 'Parish', 84, 58213, 391, to_date('08-09-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (353, 'Stephen', 'Ribisi', 71, 25657, 200, to_date('21-03-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (354, 'Rosanne', 'Campbell', 182, 67104, 227, to_date('15-02-1961', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (356, 'Andie', 'Diesel', 399, 66452, 294, to_date('13-09-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (357, 'Dave', 'Bush', 47, 71958, 338, to_date('19-08-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (358, 'Ethan', 'Cummings', 185, 90804, 219, to_date('23-05-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (359, 'Paula', 'Kirshner', 356, 12777, 324, to_date('10-06-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (360, 'Julie', 'Douglas', 116, 21858, 271, to_date('06-11-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (361, 'Holland', 'Danger', 52, 35581, 302, to_date('31-08-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (362, 'Beverley', 'Warwick', 129, 79488, 371, to_date('23-12-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (363, 'Jackson', 'McCann', 71, 70832, 282, to_date('15-08-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (365, 'Meg', 'Choice', 232, 50819, 282, to_date('06-02-1976', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (366, 'Lara', 'Keen', 191, 91188, 266, to_date('01-03-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (367, 'Guy', 'Beck', 398, 52688, 398, to_date('18-03-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (368, 'Thora', 'Stiles', 49, 46077, 201, to_date('04-07-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (369, 'Julianna', 'Tyler', 372, 96318, 319, to_date('26-06-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (370, 'Kim', 'Darren', 85, 50132, 274, to_date('22-06-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (371, 'Josh', 'Leary', 182, 20337, 190, to_date('02-04-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (372, 'Gavin', 'Lithgow', 123, 43719, 382, to_date('01-10-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (373, 'Franz', 'Unger', 111, 62050, 239, to_date('28-08-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (374, 'Jack', 'Caine', 37, 34493, 290, to_date('17-01-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (375, 'Maury', 'Sweeney', 330, 89566, 192, to_date('15-11-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (376, 'Shelby', 'Hiatt', 269, 16697, 209, to_date('01-11-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (377, 'Luke', 'Malkovich', 88, 46905, 285, to_date('10-05-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (378, 'Jessica', 'Colon', 84, 29768, 316, to_date('24-07-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (379, 'Connie', 'Salt', 119, 55363, 247, to_date('09-03-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (380, 'Rhett', 'Postlethwaite', 40, 25787, 363, to_date('27-02-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (381, 'Brenda', 'Snipes', 15, 76918, 204, to_date('18-11-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (382, 'Gran', 'Peet', 104, 47784, 358, to_date('25-09-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (383, 'Dwight', 'Van Der Beek', 30, 57960, 256, to_date('18-03-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (384, 'Kirk', 'Holmes', 110, 73459, 350, to_date('16-08-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (385, 'Raul', 'Capshaw', 66, 54119, 286, to_date('01-11-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (386, 'Giovanni', 'Birch', 162, 71323, 158, to_date('19-05-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (388, 'Azucar', 'Alston', 293, 28812, 220, to_date('18-03-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (389, 'Lance', 'Scorsese', 2, 25997, 358, to_date('23-11-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (390, 'Gaby', 'Caine', 389, 94383, 260, to_date('10-01-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (391, 'Kyle', 'Baranski', 10, 61259, 233, to_date('29-03-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (393, 'Rosanna', 'Def', 11, 55609, 226, to_date('06-09-2005', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (394, 'Juliana', 'Wilkinson', 382, 78048, 385, to_date('05-02-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (395, 'Milla', 'Klugh', 286, 41687, 156, to_date('21-04-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (396, 'Lili', 'Krabbe', 282, 41147, 281, to_date('17-07-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (397, 'Trey', 'Klugh', 78, 52292, 331, to_date('30-08-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (398, 'Edie', 'MacLachlan', 128, 92000, 154, to_date('27-08-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (399, 'Ice', 'Gandolfini', 35, 84813, 375, to_date('14-07-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (400, 'Sigourney', 'Fichtner', 65, 12708, 220, to_date('31-10-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (401, 'Frederic', 'Holbrook', 285, 13018, 342, to_date('24-02-1926', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (402, 'Joan', 'Matthau', 58, 11640, 387, to_date('16-09-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (403, 'Garland', 'Cheadle', 203, 49469, 209, to_date('19-12-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (404, 'Lennie', 'Hughes', 214, 60369, 250, to_date('12-06-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (405, 'Jeanne', 'Meniketti', 23, 44364, 219, to_date('27-04-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (406, 'Reese', 'Collins', 220, 30851, 207, to_date('30-01-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (407, 'Keith', 'Himmelman', 152, 69063, 312, to_date('17-07-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (408, 'Nicole', 'Warburton', 198, 77384, 207, to_date('15-04-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (409, 'Natascha', 'Karyo', 141, 75108, 218, to_date('01-05-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (411, 'Laurence', 'Gaines', 172, 41988, 338, to_date('06-07-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (412, 'Nanci', 'Channing', 327, 31412, 351, to_date('09-09-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (413, 'Alana', 'Garofalo', 15, 69456, 352, to_date('24-06-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (414, 'Marley', 'Allison', 55, 91791, 229, to_date('25-04-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (415, 'Emerson', 'Romijn-Stamos', 111, 72660, 316, to_date('17-11-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (416, 'Murray', 'Donovan', 40, 18831, 371, to_date('04-12-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (417, 'Emily', 'Pony', 340, 20884, 306, to_date('08-06-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (418, 'Cuba', 'Nicholson', 247, 57202, 196, to_date('06-08-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (419, 'Jane', 'Everett', 131, 63174, 235, to_date('25-11-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (420, 'Lisa', 'Rippy', 120, 54685, 216, to_date('26-04-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (421, 'Marisa', 'Lillard', 56, 86618, 305, to_date('15-07-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (422, 'Edward', 'Rhames', 337, 44431, 323, to_date('22-09-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (423, 'Veruca', 'Blair', 392, 75593, 317, to_date('01-09-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (424, 'Cameron', 'Foley', 29, 48245, 259, to_date('12-11-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (425, 'Irene', 'Hart', 182, 52723, 184, to_date('18-02-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (426, 'Russell', 'Waits', 274, 97928, 367, to_date('27-04-2017', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (427, 'Heath', 'Cassidy', 60, 24856, 259, to_date('27-09-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (429, 'Dan', 'Belushi', 197, 19832, 166, to_date('02-01-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (431, 'Neil', 'Hutch', 33, 52315, 166, to_date('30-10-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (432, 'Max', 'Rossellini', 95, 79490, 287, to_date('23-09-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (433, 'Ivan', 'Spine', 127, 59491, 332, to_date('05-11-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (434, 'Celia', 'Daniels', 37, 69285, 319, to_date('12-06-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (435, 'Fairuza', 'Buffalo', 207, 49892, 197, to_date('03-08-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (436, 'Gordie', 'Esposito', 379, 75712, 163, to_date('19-03-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (437, 'Rene', 'Cocker', 365, 11135, 304, to_date('19-10-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (438, 'Tyrone', 'Stevenson', 179, 55813, 163, to_date('25-03-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (439, 'Lydia', 'Robinson', 49, 44867, 154, to_date('28-05-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (440, 'Patrick', 'O''Neal', 93, 27220, 385, to_date('11-06-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (441, 'Pelvic', 'Andrews', 19, 49679, 384, to_date('25-01-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (442, 'Praga', 'Kilmer', 283, 17080, 366, to_date('20-04-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (443, 'King', 'Stormare', 112, 95287, 285, to_date('19-04-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (444, 'Hector', 'Tippe', 356, 44804, 324, to_date('19-04-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (446, 'Miriam', 'Cube', 345, 10703, 318, to_date('08-03-2004', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (447, 'Rhett', 'Bullock', 62, 56002, 278, to_date('13-11-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (448, 'Grace', 'Chestnut', 221, 15005, 380, to_date('26-01-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (449, 'Alex', 'MacDonald', 118, 44519, 154, to_date('03-09-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (450, 'Anjelica', 'Dayne', 365, 34319, 222, to_date('01-12-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (451, 'Walter', 'Summer', 35, 25324, 219, to_date('17-04-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (452, 'Lindsey', 'Leachman', 288, 65057, 186, to_date('13-01-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (453, 'Nik', 'Loring', 395, 15197, 364, to_date('30-12-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (454, 'Nigel', 'Aniston', 218, 65841, 395, to_date('25-08-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (455, 'Josh', 'Strathairn', 122, 32312, 250, to_date('05-06-1970', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (456, 'Javon', 'Hingle', 248, 43455, 396, to_date('11-08-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (457, 'Azucar', 'Dukakis', 118, 61111, 152, to_date('28-03-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (458, 'Maceo', 'Feliciano', 260, 19333, 154, to_date('01-11-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (462, 'Mary-Louise', 'Kahn', 250, 66515, 293, to_date('24-12-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (465, 'Adam', 'Hauser', 172, 95553, 342, to_date('07-05-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (466, 'Sissy', 'Mraz', 200, 63895, 362, to_date('09-12-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (468, 'Grace', 'de Lancie', 78, 21984, 181, to_date('14-03-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (470, 'Carlene', 'Deejay', 356, 65520, 299, to_date('12-10-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (471, 'Wally', 'Herrmann', 91, 94760, 301, to_date('19-04-1995', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (472, 'Yolanda', 'Porter', 279, 48753, 278, to_date('23-12-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (473, 'Famke', 'Tucker', 324, 16058, 162, to_date('28-11-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (474, 'Mykelti', 'Cantrell', 292, 31354, 373, to_date('28-03-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (475, 'Grant', 'Oates', 372, 70855, 333, to_date('27-08-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (476, 'Gabrielle', 'Crouch', 114, 48826, 292, to_date('16-03-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (477, 'Reese', 'Wilder', 78, 48047, 208, to_date('10-04-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (479, 'Cole', 'Twilley', 277, 91395, 299, to_date('25-07-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (481, 'Roy', 'Studi', 326, 86086, 293, to_date('14-06-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (482, 'Rob', 'Hobson', 144, 34756, 182, to_date('16-09-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (483, 'Amy', 'Byrd', 369, 57158, 164, to_date('04-10-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (484, 'Fionnula', 'Lachey', 109, 93413, 345, to_date('20-08-1988', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (485, 'Garry', 'Hector', 109, 45611, 284, to_date('14-12-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (486, 'Jonny Lee', 'Barkin', 325, 36006, 270, to_date('16-03-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (487, 'Rita', 'Allan', 318, 20450, 270, to_date('19-06-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (488, 'Dan', 'Lillard', 305, 97574, 194, to_date('01-03-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (489, 'Vern', 'Palmieri', 267, 47464, 166, to_date('18-06-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (490, 'King', 'Perrineau', 94, 14967, 397, to_date('01-02-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (491, 'Timothy', 'Fraser', 312, 58017, 307, to_date('14-01-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (492, 'Toni', 'Duvall', 10, 41088, 235, to_date('25-08-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (493, 'Burton', 'Murdock', 207, 23617, 319, to_date('05-04-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (494, 'Faye', 'Jessee', 368, 53754, 230, to_date('05-07-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (495, 'Howie', 'Stiller', 188, 14579, 263, to_date('18-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (496, 'Pete', 'Loggins', 291, 73706, 208, to_date('08-12-1992', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (497, 'Leslie', 'Hector', 397, 93516, 238, to_date('09-09-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (498, 'Danny', 'Makowicz', 28, 38802, 367, to_date('08-09-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (499, 'Lynette', 'Shepard', 289, 16990, 309, to_date('29-12-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (500, 'Jeffrey', 'Mulroney', 72, 33921, 174, to_date('18-10-1976', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (501, 'Val', 'Sizemore', 188, 91058, 221, to_date('11-09-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (502, 'Phil', 'Lindo', 91, 38615, 317, to_date('05-04-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (503, 'Whoopi', 'Wright', 46, 49026, 393, to_date('14-04-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (504, 'Rachid', 'Lightfoot', 376, 77032, 234, to_date('25-10-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (505, 'Cathy', 'Calle', 155, 42183, 249, to_date('11-06-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (506, 'Sara', 'Richter', 212, 57149, 339, to_date('24-03-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (507, 'Lenny', 'Chambers', 283, 26789, 290, to_date('06-12-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (508, 'Colin', 'Keitel', 84, 48838, 331, to_date('10-11-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (509, 'Embeth', 'Geldof', 168, 63104, 320, to_date('20-12-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1400, 'Ethan', 'Garcia', 7, 94999, 296, to_date('26-04-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1401, 'Ethan', 'Anderson', 1, 27387, 339, to_date('30-05-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1402, 'Michael', 'Miller', 2, 36293, 275, to_date('21-10-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1403, 'Alexander', 'Gonzalez', 6, 32432, 354, to_date('21-09-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1404, 'Elijah', 'Williams', 2, 34216, 344, to_date('14-04-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1405, 'William', 'Martinez', 5, 23234, 391, to_date('23-02-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1406, 'Amelia', 'Rodriguez', 2, 95451, 215, to_date('16-01-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1407, 'Lucas', 'Taylor', 7, 23986, 153, to_date('22-09-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1408, 'Ava', 'Gonzalez', 6, 95771, 222, to_date('23-09-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1409, 'Alexander', 'Martin', 2, 57827, 336, to_date('30-10-2017', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1410, 'Elijah', 'Garcia', 4, 85379, 322, to_date('03-12-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1411, 'Evelyn', 'Taylor', 10, 70376, 307, to_date('16-04-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1412, 'Benjamin', 'Martinez', 2, 55099, 230, to_date('05-11-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1413, 'Amelia', 'Johnson', 3, 80868, 300, to_date('23-07-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1414, 'Alexander', 'Brown', 10, 64795, 243, to_date('02-04-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1415, 'James', 'Smith', 4, 39146, 391, to_date('06-02-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1416, 'Sophia', 'Hernandez', 1, 71947, 228, to_date('27-03-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1417, 'Lucas', 'Jones', 9, 89405, 363, to_date('23-01-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1418, 'Abigail', 'Martinez', 4, 63133, 158, to_date('30-12-1948', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1419, 'James', 'Wilson', 4, 53876, 217, to_date('16-06-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1420, 'Ava', 'Jackson', 4, 67600, 283, to_date('06-05-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1421, 'Mia', 'Miller', 7, 52493, 249, to_date('05-06-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1422, 'Isabella', 'Hernandez', 10, 56587, 369, to_date('14-03-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1423, 'Mia', 'Wilson', 9, 23214, 252, to_date('06-05-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1424, 'Olivia', 'Martinez', 7, 81361, 224, to_date('11-04-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1425, 'Emma', 'Hernandez', 1, 94975, 288, to_date('12-12-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1426, 'John', 'Martinez', 9, 65292, 163, to_date('13-12-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1427, 'James', 'Taylor', 5, 69736, 191, to_date('15-04-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1428, 'John', 'Hernandez', 5, 29268, 151, to_date('01-02-1974', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1429, 'Lucas', 'Anderson', 10, 97274, 251, to_date('19-04-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1430, 'Alexander', 'Moore', 3, 70929, 343, to_date('07-09-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1431, 'Evelyn', 'Martinez', 6, 84553, 347, to_date('25-12-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1432, 'Michael', 'Lopez', 10, 28652, 341, to_date('27-12-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1433, 'James', 'Rodriguez', 4, 86463, 232, to_date('01-05-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1434, 'Evelyn', 'Miller', 3, 21243, 297, to_date('25-03-1976', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1435, 'Amelia', 'Rodriguez', 9, 38002, 174, to_date('07-06-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1436, 'Emma', 'Rodriguez', 9, 98077, 315, to_date('16-02-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1437, 'Benjamin', 'Lopez', 4, 82813, 369, to_date('15-03-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1438, 'Michael', 'Rodriguez', 7, 11934, 208, to_date('02-03-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1439, 'Michael', 'Hernandez', 6, 78829, 297, to_date('08-08-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1440, 'Olivia', 'Anderson', 3, 73015, 209, to_date('21-09-1948', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1441, 'Lucas', 'Johnson', 8, 25215, 343, to_date('14-07-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1442, 'Mia', 'Brown', 4, 95279, 184, to_date('04-11-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1443, 'John', 'Martin', 9, 80911, 219, to_date('18-05-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1444, 'James', 'Hernandez', 2, 18108, 217, to_date('09-04-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1445, 'Ava', 'Smith', 6, 11588, 343, to_date('27-11-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1446, 'Mason', 'Smith', 2, 96164, 394, to_date('06-10-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1447, 'Elijah', 'Anderson', 8, 28809, 159, to_date('16-11-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1448, 'James', 'Jackson', 6, 92733, 395, to_date('30-07-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1449, 'Alexander', 'Gonzalez', 6, 51344, 275, to_date('04-01-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1450, 'Mason', 'Miller', 1, 47558, 209, to_date('18-04-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1451, 'Benjamin', 'Miller', 6, 20320, 151, to_date('25-11-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1452, 'William', 'Miller', 4, 42503, 260, to_date('01-11-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1453, 'John', 'Garcia', 3, 77132, 220, to_date('11-04-2004', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1454, 'Sophia', 'Moore', 6, 80153, 290, to_date('06-01-1958', 'dd-mm-yyyy'));
commit;
prompt 500 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1455, 'Olivia', 'Wilson', 9, 53443, 263, to_date('17-10-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1456, 'Elijah', 'Williams', 3, 65280, 221, to_date('17-04-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1457, 'Benjamin', 'Miller', 3, 73750, 329, to_date('09-11-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1458, 'Isabella', 'Martin', 10, 21115, 162, to_date('08-08-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1459, 'Mason', 'Gonzalez', 6, 73899, 314, to_date('13-03-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1460, 'Ethan', 'Moore', 6, 92686, 314, to_date('01-10-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1461, 'Evelyn', 'Johnson', 4, 66192, 368, to_date('27-01-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1462, 'James', 'Smith', 4, 31297, 174, to_date('13-08-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1463, 'Emma', 'Johnson', 3, 11827, 159, to_date('27-01-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1464, 'Olivia', 'Rodriguez', 7, 69571, 394, to_date('06-02-1988', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1465, 'Benjamin', 'Smith', 9, 86395, 155, to_date('17-11-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1466, 'William', 'Jones', 2, 14226, 288, to_date('08-08-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1467, 'John', 'Taylor', 8, 95831, 342, to_date('23-05-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1468, 'Ethan', 'Johnson', 9, 34183, 152, to_date('28-04-1953', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1469, 'Michael', 'Hernandez', 10, 15124, 237, to_date('23-02-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1470, 'Benjamin', 'Miller', 10, 49111, 252, to_date('21-08-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1471, 'Abigail', 'Taylor', 6, 27735, 368, to_date('24-01-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1472, 'Olivia', 'Moore', 7, 93467, 362, to_date('14-10-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1473, 'Amelia', 'Davis', 4, 53548, 369, to_date('14-01-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1474, 'Evelyn', 'Davis', 3, 35492, 253, to_date('18-12-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1475, 'Elijah', 'Jones', 2, 91616, 215, to_date('26-10-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1476, 'Ava', 'Rodriguez', 3, 71285, 242, to_date('11-04-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1477, 'Abigail', 'Johnson', 10, 89826, 160, to_date('18-04-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1478, 'Elijah', 'Brown', 10, 52759, 276, to_date('05-09-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1479, 'Michael', 'Rodriguez', 7, 14722, 273, to_date('21-12-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1480, 'James', 'Taylor', 1, 26266, 235, to_date('11-11-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1481, 'Lucas', 'Jackson', 6, 85688, 327, to_date('30-05-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1482, 'Sophia', 'Miller', 1, 61271, 347, to_date('01-03-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1483, 'Olivia', 'Lopez', 9, 48553, 316, to_date('10-10-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1484, 'Mia', 'Davis', 1, 39795, 212, to_date('29-04-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1485, 'Lucas', 'Miller', 4, 37327, 159, to_date('13-06-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1486, 'William', 'Garcia', 9, 56604, 232, to_date('27-07-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1487, 'Evelyn', 'Williams', 7, 28554, 346, to_date('15-06-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1488, 'Elijah', 'Lopez', 8, 84532, 332, to_date('15-04-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1489, 'Harper', 'Miller', 6, 33225, 386, to_date('13-12-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1490, 'Amelia', 'Martinez', 9, 38090, 255, to_date('15-05-1992', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1491, 'Lucas', 'Garcia', 1, 15059, 161, to_date('07-04-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1492, 'Abigail', 'Williams', 9, 13327, 182, to_date('15-12-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1493, 'Evelyn', 'Smith', 6, 85565, 398, to_date('28-03-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1494, 'Abigail', 'Johnson', 2, 58513, 186, to_date('11-11-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1495, 'Sophia', 'Brown', 6, 67038, 343, to_date('08-12-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1496, 'Evelyn', 'Williams', 10, 28735, 335, to_date('05-12-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1497, 'Mason', 'Williams', 5, 79728, 274, to_date('25-07-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1498, 'James', 'Hernandez', 5, 27593, 352, to_date('16-03-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1499, 'Alexander', 'Jackson', 7, 94223, 184, to_date('08-04-1926', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1100, 'Elijah', 'Martinez', 6, 87441, 222, to_date('04-08-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1101, 'Isabella', 'Miller', 8, 89405, 339, to_date('19-01-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1102, 'Abigail', 'Wilson', 6, 33097, 374, to_date('26-07-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1103, 'John', 'Johnson', 7, 59002, 247, to_date('23-08-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1104, 'Lucas', 'Thomas', 3, 85122, 302, to_date('28-10-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1105, 'Michael', 'Johnson', 5, 95150, 389, to_date('03-08-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1106, 'Isabella', 'Davis', 7, 64095, 214, to_date('13-05-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1107, 'Olivia', 'Jackson', 9, 68907, 365, to_date('25-01-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1108, 'Isabella', 'Thomas', 8, 90409, 367, to_date('25-06-2005', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1109, 'Mia', 'Thomas', 9, 42856, 336, to_date('14-07-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1110, 'Mia', 'Jackson', 2, 55209, 169, to_date('02-04-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1111, 'Isabella', 'Brown', 1, 71705, 209, to_date('29-11-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1112, 'John', 'Smith', 3, 69505, 150, to_date('02-01-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1113, 'John', 'Williams', 9, 53260, 380, to_date('27-12-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1114, 'Lucas', 'Jones', 5, 35967, 164, to_date('07-07-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1115, 'William', 'Gonzalez', 8, 36759, 242, to_date('25-04-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1116, 'Isabella', 'Miller', 9, 98608, 271, to_date('25-11-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1117, 'Emma', 'Martinez', 5, 99909, 337, to_date('06-03-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1118, 'Evelyn', 'Taylor', 9, 45447, 376, to_date('03-10-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1119, 'Evelyn', 'Taylor', 10, 56223, 177, to_date('08-10-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1120, 'Benjamin', 'Davis', 8, 38120, 215, to_date('25-08-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1121, 'Sophia', 'Smith', 4, 16532, 195, to_date('07-05-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1122, 'Isabella', 'Rodriguez', 8, 45264, 218, to_date('29-07-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1123, 'Olivia', 'Taylor', 4, 61553, 166, to_date('01-11-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1124, 'Mia', 'Garcia', 1, 35033, 160, to_date('20-08-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1125, 'Evelyn', 'Garcia', 9, 10004, 317, to_date('02-08-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1126, 'Sophia', 'Anderson', 4, 52594, 292, to_date('04-06-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1127, 'Ethan', 'Moore', 8, 61999, 204, to_date('18-05-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1128, 'James', 'Johnson', 7, 91519, 299, to_date('29-04-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1129, 'Elijah', 'Moore', 7, 29008, 335, to_date('16-07-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1130, 'Sophia', 'Smith', 6, 96294, 162, to_date('22-10-2005', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1131, 'Michael', 'Martin', 4, 71265, 227, to_date('29-12-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1132, 'Harper', 'Miller', 1, 73174, 287, to_date('02-01-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1133, 'James', 'Garcia', 3, 79068, 216, to_date('24-11-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1134, 'Harper', 'Rodriguez', 9, 51933, 305, to_date('14-06-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1135, 'Amelia', 'Johnson', 10, 59274, 153, to_date('07-05-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1136, 'Elijah', 'Thomas', 7, 88682, 318, to_date('05-08-1943', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1137, 'Sophia', 'Williams', 9, 84674, 165, to_date('06-05-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1138, 'Abigail', 'Garcia', 10, 69508, 325, to_date('15-05-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1139, 'Elijah', 'Wilson', 2, 37653, 176, to_date('15-07-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1140, 'Ava', 'Anderson', 3, 55122, 220, to_date('25-09-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1141, 'Michael', 'Brown', 7, 24355, 324, to_date('20-03-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1142, 'Abigail', 'Johnson', 1, 53350, 200, to_date('21-08-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1143, 'Lucas', 'Wilson', 9, 23036, 239, to_date('14-10-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1144, 'Olivia', 'Moore', 1, 62597, 251, to_date('01-12-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1145, 'Benjamin', 'Hernandez', 4, 23498, 234, to_date('28-08-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1146, 'Olivia', 'Jones', 9, 68588, 261, to_date('04-04-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1147, 'Abigail', 'Taylor', 4, 28612, 386, to_date('27-03-1992', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1148, 'Emma', 'Wilson', 7, 30784, 209, to_date('26-11-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1149, 'Elijah', 'Lopez', 3, 73748, 207, to_date('20-02-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1150, 'Lucas', 'Rodriguez', 6, 38421, 399, to_date('03-03-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1151, 'John', 'Williams', 9, 11231, 370, to_date('09-01-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1152, 'Mason', 'Lopez', 9, 77319, 345, to_date('02-11-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1153, 'James', 'Johnson', 4, 23841, 382, to_date('26-12-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1154, 'Olivia', 'Miller', 6, 84865, 229, to_date('23-04-1969', 'dd-mm-yyyy'));
commit;
prompt 600 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1155, 'Evelyn', 'Taylor', 10, 40706, 388, to_date('24-07-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1156, 'Michael', 'Thomas', 9, 39566, 282, to_date('24-03-1961', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1157, 'Mia', 'Martinez', 5, 12407, 258, to_date('03-09-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1158, 'Abigail', 'Lopez', 5, 34613, 258, to_date('21-04-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1159, 'Olivia', 'Gonzalez', 10, 72518, 167, to_date('23-10-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1160, 'Sophia', 'Anderson', 10, 74677, 231, to_date('01-04-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1161, 'Alexander', 'Williams', 1, 30795, 300, to_date('13-03-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1162, 'John', 'Rodriguez', 5, 59577, 194, to_date('07-11-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1163, 'Benjamin', 'Williams', 1, 35753, 316, to_date('10-09-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1164, 'Abigail', 'Lopez', 2, 73591, 309, to_date('08-02-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1165, 'James', 'Jones', 4, 12376, 322, to_date('29-03-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1166, 'Harper', 'Johnson', 2, 53627, 390, to_date('27-07-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1167, 'Elijah', 'Johnson', 3, 31031, 378, to_date('05-08-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1168, 'William', 'Miller', 6, 46297, 323, to_date('01-07-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1169, 'Harper', 'Brown', 6, 97419, 218, to_date('12-03-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1170, 'Elijah', 'Taylor', 10, 36943, 229, to_date('17-06-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1171, 'William', 'Miller', 4, 84793, 240, to_date('09-05-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1172, 'Benjamin', 'Wilson', 3, 91204, 210, to_date('27-08-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1173, 'Abigail', 'Miller', 6, 63002, 262, to_date('09-05-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1174, 'Ava', 'Anderson', 4, 96875, 155, to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1175, 'Olivia', 'Jackson', 1, 96301, 305, to_date('26-06-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1176, 'Alexander', 'Brown', 3, 94111, 190, to_date('25-10-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1177, 'Harper', 'Johnson', 7, 52619, 374, to_date('30-01-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1178, 'Mason', 'Jackson', 4, 41559, 161, to_date('17-10-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1179, 'Amelia', 'Jones', 3, 48919, 355, to_date('29-10-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1180, 'Mason', 'Jackson', 4, 40120, 196, to_date('03-03-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1181, 'Lucas', 'Miller', 3, 26973, 364, to_date('03-04-2017', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1182, 'Abigail', 'Brown', 2, 33035, 312, to_date('13-05-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1183, 'Harper', 'Johnson', 6, 50628, 388, to_date('28-06-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1184, 'Mia', 'Davis', 9, 91456, 295, to_date('02-04-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1185, 'Olivia', 'Moore', 9, 66501, 307, to_date('28-12-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1186, 'Mia', 'Taylor', 3, 46731, 367, to_date('27-03-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1187, 'Ava', 'Miller', 6, 79308, 196, to_date('11-04-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1188, 'Sophia', 'Lopez', 9, 37531, 210, to_date('27-04-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1189, 'Ethan', 'Thomas', 3, 52102, 206, to_date('08-09-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1190, 'James', 'Wilson', 1, 13382, 259, to_date('24-08-1973', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1191, 'Abigail', 'Wilson', 3, 11042, 371, to_date('23-10-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1192, 'Sophia', 'Martin', 8, 81083, 170, to_date('01-08-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1193, 'Michael', 'Martin', 9, 31520, 356, to_date('11-10-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1194, 'John', 'Johnson', 2, 30803, 242, to_date('29-10-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1195, 'Ava', 'Garcia', 2, 83217, 324, to_date('16-11-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1196, 'John', 'Jones', 5, 23009, 194, to_date('20-02-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1197, 'Sophia', 'Hernandez', 2, 88887, 263, to_date('15-04-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1198, 'Sophia', 'Miller', 1, 24757, 255, to_date('20-11-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1199, 'Emma', 'Jackson', 4, 13978, 286, to_date('20-05-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1200, 'Evelyn', 'Moore', 1, 54934, 198, to_date('12-01-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1201, 'John', 'Miller', 2, 24686, 188, to_date('28-09-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1202, 'Emma', 'Smith', 5, 71666, 311, to_date('08-11-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1203, 'Mia', 'Lopez', 4, 60010, 269, to_date('15-09-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1204, 'Michael', 'Davis', 3, 82083, 262, to_date('17-11-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1205, 'Benjamin', 'Rodriguez', 8, 37745, 358, to_date('30-10-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1206, 'Evelyn', 'Miller', 3, 50003, 224, to_date('14-07-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1207, 'Ethan', 'Williams', 10, 46360, 232, to_date('07-01-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1208, 'Elijah', 'Martinez', 4, 65952, 370, to_date('07-12-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1209, 'Lucas', 'Hernandez', 10, 79204, 305, to_date('07-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1210, 'Sophia', 'Martin', 3, 26509, 334, to_date('04-03-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1211, 'James', 'Jones', 6, 62471, 323, to_date('20-11-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1212, 'John', 'Jackson', 3, 74617, 221, to_date('25-03-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1213, 'Elijah', 'Smith', 4, 96682, 384, to_date('26-10-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1214, 'Evelyn', 'Rodriguez', 2, 96006, 227, to_date('13-12-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1215, 'Emma', 'Garcia', 10, 94833, 244, to_date('17-09-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1216, 'Lucas', 'Anderson', 9, 86835, 166, to_date('13-09-1976', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1217, 'Ethan', 'Taylor', 5, 73923, 303, to_date('09-12-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1218, 'Harper', 'Martin', 3, 95295, 264, to_date('28-09-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1219, 'Sophia', 'Taylor', 9, 52528, 301, to_date('04-07-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1220, 'Sophia', 'Brown', 8, 57352, 228, to_date('14-10-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1221, 'Evelyn', 'Davis', 1, 62718, 213, to_date('20-12-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1222, 'John', 'Davis', 9, 96856, 306, to_date('06-03-1989', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1223, 'Alexander', 'Smith', 9, 39859, 324, to_date('20-08-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1224, 'Harper', 'Brown', 5, 47275, 389, to_date('14-06-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1225, 'Michael', 'Gonzalez', 7, 38371, 235, to_date('02-08-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1226, 'James', 'Miller', 6, 57436, 384, to_date('15-05-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1227, 'Amelia', 'Anderson', 10, 55542, 282, to_date('18-08-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1228, 'William', 'Jones', 2, 31772, 183, to_date('07-01-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1229, 'Michael', 'Jones', 2, 25585, 269, to_date('12-02-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1230, 'Elijah', 'Wilson', 6, 51375, 218, to_date('15-07-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1231, 'Olivia', 'Rodriguez', 10, 37954, 359, to_date('20-08-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1232, 'Abigail', 'Smith', 8, 14853, 330, to_date('01-04-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1233, 'Abigail', 'Rodriguez', 9, 48225, 309, to_date('27-05-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1234, 'James', 'Jackson', 9, 36642, 219, to_date('03-04-1953', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1235, 'Sophia', 'Jackson', 9, 21911, 161, to_date('19-06-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1236, 'Amelia', 'Davis', 5, 22720, 391, to_date('26-02-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1237, 'Mason', 'Brown', 1, 98590, 251, to_date('17-11-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1238, 'Mia', 'Davis', 6, 84926, 262, to_date('20-09-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1239, 'Olivia', 'Garcia', 6, 97369, 400, to_date('01-08-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1240, 'Lucas', 'Brown', 8, 37392, 397, to_date('13-01-2004', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1241, 'Benjamin', 'Miller', 8, 53373, 166, to_date('17-11-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1242, 'Alexander', 'Johnson', 3, 26879, 277, to_date('10-11-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1243, 'Ethan', 'Johnson', 1, 92006, 178, to_date('26-06-1953', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1244, 'Abigail', 'Anderson', 5, 14793, 159, to_date('24-06-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1245, 'Harper', 'Jackson', 5, 90248, 225, to_date('06-07-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1246, 'Sophia', 'Miller', 6, 93673, 162, to_date('20-07-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1247, 'Sophia', 'Moore', 6, 55087, 335, to_date('26-06-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1248, 'Olivia', 'Garcia', 1, 98938, 383, to_date('08-10-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1249, 'Sophia', 'Lopez', 4, 76779, 169, to_date('18-10-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1250, 'Emma', 'Wilson', 10, 61530, 207, to_date('10-09-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1251, 'Abigail', 'Rodriguez', 4, 78836, 169, to_date('25-10-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1252, 'William', 'Brown', 6, 17186, 272, to_date('24-08-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1253, 'Evelyn', 'Taylor', 10, 63293, 373, to_date('25-03-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1254, 'William', 'Johnson', 8, 53395, 349, to_date('15-12-1956', 'dd-mm-yyyy'));
commit;
prompt 700 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1255, 'Amelia', 'Taylor', 1, 50654, 157, to_date('22-04-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1256, 'Sophia', 'Jones', 4, 54758, 350, to_date('28-03-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1257, 'Ava', 'Brown', 2, 66619, 340, to_date('04-04-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1258, 'Benjamin', 'Williams', 4, 94986, 167, to_date('02-03-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1259, 'Harper', 'Brown', 3, 75919, 382, to_date('07-10-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1260, 'Lucas', 'Taylor', 7, 57172, 269, to_date('27-03-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1261, 'Elijah', 'Brown', 10, 69687, 246, to_date('25-05-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1262, 'Lucas', 'Brown', 10, 32184, 189, to_date('24-03-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1263, 'Abigail', 'Brown', 2, 68188, 226, to_date('12-10-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1264, 'James', 'Taylor', 10, 65947, 301, to_date('22-09-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1265, 'Evelyn', 'Miller', 5, 74204, 159, to_date('05-12-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1266, 'Michael', 'Moore', 4, 68776, 183, to_date('18-08-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1267, 'Lucas', 'Taylor', 4, 36601, 246, to_date('28-09-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1268, 'Mia', 'Jackson', 2, 82605, 345, to_date('26-03-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1269, 'Harper', 'Jackson', 10, 85607, 314, to_date('10-08-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1270, 'Ava', 'Thomas', 7, 35084, 265, to_date('14-11-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1271, 'Elijah', 'Hernandez', 10, 10465, 283, to_date('10-02-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1272, 'Elijah', 'Martinez', 1, 72278, 197, to_date('25-01-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1273, 'William', 'Martin', 2, 99439, 298, to_date('11-11-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1274, 'Ava', 'Garcia', 5, 50005, 400, to_date('29-12-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1275, 'Olivia', 'Martin', 1, 95166, 368, to_date('19-03-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1276, 'Harper', 'Anderson', 6, 77230, 336, to_date('18-10-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1277, 'Mason', 'Taylor', 6, 76588, 225, to_date('21-02-1973', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1278, 'Sophia', 'Smith', 2, 70846, 335, to_date('22-01-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1279, 'Benjamin', 'Williams', 2, 36301, 171, to_date('04-11-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1280, 'Mia', 'Miller', 2, 66815, 399, to_date('19-06-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1281, 'Benjamin', 'Brown', 2, 26036, 388, to_date('17-05-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1282, 'Elijah', 'Taylor', 4, 30009, 393, to_date('07-01-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1283, 'Elijah', 'Smith', 8, 18877, 154, to_date('16-09-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1284, 'Abigail', 'Davis', 6, 76894, 387, to_date('07-09-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1285, 'Isabella', 'Wilson', 5, 50148, 377, to_date('01-05-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1286, 'Mia', 'Martin', 9, 78098, 206, to_date('10-01-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1287, 'Sophia', 'Hernandez', 9, 29770, 150, to_date('11-09-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1288, 'Amelia', 'Smith', 4, 41292, 294, to_date('14-02-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1289, 'Mason', 'Garcia', 2, 95022, 379, to_date('04-05-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1290, 'Amelia', 'Martin', 3, 61660, 389, to_date('05-11-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1291, 'Alexander', 'Williams', 1, 93316, 270, to_date('27-09-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1292, 'Elijah', 'Martin', 10, 58261, 204, to_date('17-12-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1293, 'Lucas', 'Anderson', 9, 42008, 208, to_date('10-01-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1294, 'Harper', 'Rodriguez', 5, 22004, 340, to_date('12-02-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1295, 'Harper', 'Thomas', 9, 43666, 257, to_date('29-03-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1296, 'Harper', 'Davis', 1, 68978, 349, to_date('26-07-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1297, 'James', 'Johnson', 4, 82060, 259, to_date('15-04-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1298, 'Sophia', 'Wilson', 2, 41832, 150, to_date('17-04-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1299, 'Mason', 'Williams', 2, 15040, 176, to_date('05-03-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1300, 'Alexander', 'Thomas', 5, 29233, 314, to_date('27-04-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1301, 'William', 'Martinez', 1, 59849, 175, to_date('31-10-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1302, 'Elijah', 'Jones', 8, 86425, 167, to_date('19-02-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1303, 'Abigail', 'Jones', 9, 79038, 351, to_date('22-04-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1304, 'Ava', 'Anderson', 9, 47972, 390, to_date('21-01-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1305, 'Emma', 'Wilson', 6, 66740, 154, to_date('13-10-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1306, 'Lucas', 'Davis', 1, 28770, 160, to_date('25-03-1974', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1307, 'Mason', 'Davis', 1, 45726, 217, to_date('03-01-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1308, 'Mason', 'Gonzalez', 3, 89063, 179, to_date('01-02-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1309, 'William', 'Williams', 10, 75604, 242, to_date('15-08-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1310, 'Harper', 'Wilson', 4, 22510, 153, to_date('09-03-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1311, 'Emma', 'Williams', 4, 92702, 369, to_date('28-07-1976', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1312, 'Emma', 'Davis', 5, 15889, 255, to_date('26-01-2004', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1313, 'Alexander', 'Anderson', 1, 85136, 301, to_date('23-01-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1314, 'James', 'Martin', 7, 38009, 339, to_date('10-01-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1315, 'Michael', 'Martin', 9, 34992, 347, to_date('09-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1316, 'James', 'Wilson', 9, 98054, 257, to_date('06-03-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1317, 'Lucas', 'Smith', 10, 73854, 383, to_date('07-01-1943', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1318, 'Benjamin', 'Miller', 2, 13261, 290, to_date('11-06-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1319, 'Isabella', 'Wilson', 8, 35212, 154, to_date('22-08-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1320, 'William', 'Martin', 9, 64196, 316, to_date('13-04-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1321, 'Emma', 'Lopez', 3, 93219, 368, to_date('10-06-1995', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1322, 'Elijah', 'Brown', 10, 37492, 357, to_date('18-10-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1323, 'Sophia', 'Lopez', 1, 43937, 360, to_date('09-04-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1324, 'Ava', 'Brown', 9, 45647, 303, to_date('21-08-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1325, 'Harper', 'Smith', 3, 94043, 150, to_date('20-02-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1326, 'Lucas', 'Miller', 7, 82100, 292, to_date('29-08-2017', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1327, 'Isabella', 'Brown', 9, 85836, 189, to_date('23-11-1953', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1328, 'Evelyn', 'Smith', 3, 93644, 210, to_date('23-08-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1329, 'Ethan', 'Miller', 5, 26625, 210, to_date('01-11-1973', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1330, 'Evelyn', 'Miller', 5, 73435, 305, to_date('05-06-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1331, 'Olivia', 'Taylor', 10, 93596, 354, to_date('10-03-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1332, 'Harper', 'Smith', 1, 43873, 152, to_date('16-05-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1333, 'John', 'Johnson', 5, 60085, 201, to_date('15-06-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1334, 'Mia', 'Rodriguez', 9, 66446, 298, to_date('16-08-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1335, 'Alexander', 'Brown', 9, 88740, 186, to_date('09-04-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1336, 'Ethan', 'Lopez', 3, 48657, 365, to_date('08-07-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1337, 'Harper', 'Taylor', 6, 31453, 177, to_date('19-11-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1338, 'Isabella', 'Brown', 4, 20696, 186, to_date('21-02-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1339, 'Evelyn', 'Miller', 1, 69219, 298, to_date('02-05-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1340, 'Evelyn', 'Anderson', 1, 77209, 344, to_date('25-02-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1341, 'Emma', 'Miller', 6, 25576, 342, to_date('17-04-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1342, 'Mason', 'Gonzalez', 5, 24107, 221, to_date('08-11-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1343, 'Amelia', 'Smith', 9, 62135, 397, to_date('22-02-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1344, 'Amelia', 'Smith', 7, 96660, 314, to_date('27-09-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1345, 'Lucas', 'Jackson', 5, 63139, 394, to_date('05-08-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1346, 'Elijah', 'Miller', 4, 16770, 311, to_date('28-05-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1347, 'Evelyn', 'Anderson', 2, 39086, 238, to_date('31-07-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1348, 'John', 'Williams', 5, 71043, 368, to_date('11-07-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1349, 'Isabella', 'Martin', 8, 25234, 163, to_date('24-05-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1350, 'William', 'Miller', 7, 63983, 376, to_date('28-03-1926', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1351, 'Harper', 'Martinez', 10, 51375, 308, to_date('25-07-1943', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1352, 'Ava', 'Brown', 6, 28269, 208, to_date('15-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1353, 'Evelyn', 'Miller', 6, 75246, 226, to_date('26-12-1967', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1354, 'Isabella', 'Moore', 3, 74469, 223, to_date('13-12-1924', 'dd-mm-yyyy'));
commit;
prompt 800 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1355, 'Sophia', 'Williams', 5, 72814, 333, to_date('12-12-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1356, 'Alexander', 'Jackson', 4, 94311, 217, to_date('11-04-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1357, 'Alexander', 'Williams', 1, 46848, 261, to_date('11-02-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1358, 'Ethan', 'Johnson', 6, 40678, 228, to_date('01-10-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1359, 'John', 'Martin', 1, 42726, 279, to_date('28-01-1961', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1360, 'Alexander', 'Williams', 10, 90478, 160, to_date('05-03-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1361, 'Isabella', 'Martin', 4, 94820, 155, to_date('22-03-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1362, 'Ethan', 'Davis', 8, 92556, 351, to_date('27-09-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1363, 'William', 'Gonzalez', 2, 39369, 280, to_date('18-06-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1364, 'James', 'Wilson', 5, 73890, 276, to_date('04-12-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1365, 'Sophia', 'Wilson', 10, 68676, 364, to_date('17-03-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1366, 'Olivia', 'Rodriguez', 3, 22327, 317, to_date('29-12-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1367, 'Ethan', 'Williams', 5, 81660, 208, to_date('24-03-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1368, 'Olivia', 'Martin', 7, 58602, 168, to_date('02-02-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1369, 'Benjamin', 'Brown', 1, 91136, 201, to_date('03-02-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1370, 'Sophia', 'Martin', 2, 23834, 199, to_date('22-01-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1371, 'James', 'Brown', 1, 59950, 371, to_date('26-05-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1372, 'Abigail', 'Miller', 9, 36903, 220, to_date('06-10-1992', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1373, 'John', 'Anderson', 7, 20548, 256, to_date('08-12-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1374, 'Ethan', 'Jones', 9, 99160, 233, to_date('04-08-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1375, 'James', 'Martinez', 9, 86491, 223, to_date('24-01-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1376, 'John', 'Williams', 7, 64396, 363, to_date('18-06-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1377, 'Ava', 'Miller', 4, 54015, 156, to_date('18-06-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1378, 'Olivia', 'Martin', 1, 88601, 299, to_date('24-02-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1379, 'Lucas', 'Smith', 7, 94383, 365, to_date('15-01-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1380, 'Ethan', 'Anderson', 6, 92925, 298, to_date('08-02-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1381, 'Ava', 'Gonzalez', 2, 81899, 398, to_date('12-09-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1382, 'Abigail', 'Gonzalez', 8, 82384, 264, to_date('08-09-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1383, 'William', 'Brown', 10, 31880, 225, to_date('20-12-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1384, 'Evelyn', 'Moore', 6, 91318, 317, to_date('21-04-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1385, 'Evelyn', 'Wilson', 3, 33125, 261, to_date('13-05-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1386, 'Alexander', 'Wilson', 5, 23562, 216, to_date('05-12-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1387, 'Mia', 'Gonzalez', 8, 47339, 184, to_date('16-05-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1388, 'Harper', 'Garcia', 7, 95196, 247, to_date('28-12-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1389, 'Harper', 'Miller', 10, 15001, 280, to_date('10-08-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1390, 'Michael', 'Johnson', 1, 28054, 206, to_date('26-09-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1391, 'John', 'Smith', 5, 69997, 165, to_date('21-11-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1392, 'Evelyn', 'Anderson', 3, 28356, 266, to_date('02-05-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1393, 'John', 'Taylor', 7, 25186, 394, to_date('16-01-1974', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1394, 'Emma', 'Rodriguez', 9, 80336, 303, to_date('23-08-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1395, 'Alexander', 'Jones', 2, 21907, 279, to_date('10-07-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1396, 'Ethan', 'Thomas', 10, 68355, 217, to_date('19-11-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1397, 'James', 'Anderson', 5, 35742, 312, to_date('02-05-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1398, 'Mason', 'Thomas', 10, 35503, 275, to_date('26-02-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1399, 'Benjamin', 'Wilson', 10, 98272, 259, to_date('20-12-1953', 'dd-mm-yyyy'));
commit;
prompt 845 records loaded
prompt Loading GROUPS_...
insert into GROUPS_ (group_id, amount, age_id)
values (1, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (2, 34, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (3, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (4, 7, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (5, 1, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (6, 8, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (7, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (8, 28, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (9, 37, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (10, 1, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (11, 9, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (12, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (13, 20, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (14, 12, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (15, 9, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (16, 39, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (17, 36, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (18, 26, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (19, 25, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (20, 26, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (21, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (22, 20, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (23, 4, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (24, 14, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (25, 8, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (26, 2, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (27, 21, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (28, 38, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (29, 29, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (30, 24, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (31, 3, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (32, 25, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (33, 31, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (34, 26, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (35, 35, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (36, 2, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (37, 13, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (38, 31, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (39, 27, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (40, 23, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (41, 33, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (42, 17, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (43, 38, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (44, 39, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (45, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (46, 14, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (47, 18, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (48, 12, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (49, 35, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (50, 3, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (51, 34, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (52, 8, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (53, 8, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (54, 38, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (55, 30, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (56, 16, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (57, 22, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (58, 9, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (59, 9, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (60, 29, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (61, 2, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (62, 29, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (63, 12, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (64, 5, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (65, 5, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (66, 22, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (67, 3, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (68, 14, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (69, 9, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (70, 19, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (71, 38, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (72, 23, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (73, 11, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (74, 3, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (75, 13, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (76, 32, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (77, 40, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (78, 35, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (79, 15, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (80, 37, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (81, 34, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (82, 8, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (83, 20, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (84, 37, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (85, 6, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (86, 29, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (87, 28, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (88, 22, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (89, 18, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (90, 2, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (91, 22, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (92, 38, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (93, 20, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (94, 38, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (95, 11, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (96, 10, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (97, 5, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (98, 22, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (99, 15, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (100, 23, 5);
commit;
prompt 100 records committed...
insert into GROUPS_ (group_id, amount, age_id)
values (101, 30, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (102, 2, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (103, 11, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (104, 17, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (105, 4, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (106, 26, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (107, 23, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (108, 9, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (109, 5, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (110, 40, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (111, 17, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (112, 11, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (113, 18, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (114, 22, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (115, 8, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (116, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (117, 39, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (118, 29, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (119, 28, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (120, 1, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (121, 33, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (122, 34, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (123, 15, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (124, 31, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (125, 24, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (126, 2, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (127, 2, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (128, 40, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (129, 1, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (130, 29, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (131, 38, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (132, 28, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (133, 32, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (134, 1, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (135, 38, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (136, 37, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (137, 33, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (138, 4, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (139, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (140, 1, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (141, 27, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (142, 2, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (143, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (144, 1, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (145, 22, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (146, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (147, 31, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (148, 19, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (149, 11, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (150, 5, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (151, 29, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (152, 13, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (153, 34, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (154, 9, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (155, 33, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (156, 24, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (157, 9, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (158, 38, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (159, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (160, 29, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (161, 13, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (162, 19, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (163, 11, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (164, 37, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (165, 21, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (166, 8, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (167, 24, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (168, 9, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (169, 10, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (170, 23, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (171, 4, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (172, 10, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (173, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (174, 25, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (175, 31, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (176, 5, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (177, 10, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (178, 9, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (179, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (180, 29, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (181, 30, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (182, 13, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (183, 40, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (184, 8, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (185, 38, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (186, 38, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (187, 13, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (188, 2, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (189, 18, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (190, 36, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (191, 15, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (192, 38, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (193, 31, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (194, 17, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (195, 1, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (196, 28, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (197, 12, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (198, 24, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (199, 4, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (200, 26, 2);
commit;
prompt 200 records committed...
insert into GROUPS_ (group_id, amount, age_id)
values (201, 18, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (202, 23, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (203, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (204, 6, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (205, 8, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (206, 22, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (207, 6, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (208, 28, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (209, 37, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (210, 31, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (211, 1, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (212, 38, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (213, 20, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (214, 40, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (215, 40, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (216, 25, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (217, 33, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (218, 4, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (219, 19, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (220, 1, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (221, 24, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (222, 14, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (223, 11, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (224, 19, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (225, 14, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (226, 18, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (227, 7, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (228, 30, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (229, 32, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (230, 20, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (231, 22, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (232, 35, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (233, 30, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (234, 29, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (235, 24, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (236, 10, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (237, 35, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (238, 39, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (239, 33, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (240, 8, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (241, 8, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (242, 3, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (243, 25, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (244, 21, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (245, 30, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (246, 2, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (247, 18, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (248, 34, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (249, 17, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (250, 1, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (251, 6, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (252, 26, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (253, 12, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (254, 2, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (255, 26, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (256, 15, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (257, 12, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (258, 28, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (259, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (260, 39, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (261, 38, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (262, 19, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (263, 11, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (264, 28, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (265, 27, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (266, 1, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (267, 2, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (268, 12, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (269, 13, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (270, 7, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (271, 18, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (272, 12, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (273, 38, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (274, 34, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (275, 35, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (276, 40, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (277, 2, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (278, 25, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (279, 14, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (280, 13, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (281, 35, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (282, 9, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (283, 21, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (284, 15, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (285, 15, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (286, 38, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (287, 31, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (288, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (289, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (290, 21, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (291, 27, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (292, 26, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (293, 34, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (294, 10, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (295, 35, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (296, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (297, 1, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (298, 25, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (299, 7, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (300, 13, 4);
commit;
prompt 300 records committed...
insert into GROUPS_ (group_id, amount, age_id)
values (301, 1, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (302, 32, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (303, 38, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (304, 36, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (305, 12, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (306, 5, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (307, 33, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (308, 9, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (309, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (310, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (311, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (312, 33, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (313, 27, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (314, 23, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (315, 38, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (316, 31, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (317, 36, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (318, 10, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (319, 7, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (320, 26, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (321, 23, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (322, 23, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (323, 7, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (324, 8, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (325, 37, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (326, 37, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (327, 10, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (328, 38, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (329, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (330, 39, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (331, 3, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (332, 24, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (333, 28, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (334, 28, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (335, 19, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (336, 9, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (337, 24, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (338, 6, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (339, 34, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (340, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (341, 5, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (342, 10, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (343, 25, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (344, 13, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (345, 18, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (346, 5, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (347, 4, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (348, 32, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (349, 9, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (350, 19, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (351, 27, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (352, 16, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (353, 26, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (354, 28, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (355, 14, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (356, 13, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (357, 34, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (358, 29, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (359, 19, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (360, 13, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (361, 23, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (362, 31, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (363, 37, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (364, 26, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (365, 13, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (366, 37, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (367, 18, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (368, 27, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (369, 20, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (370, 17, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (371, 20, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (372, 19, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (373, 9, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (374, 35, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (375, 8, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (376, 2, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (377, 7, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (378, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (379, 32, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (380, 23, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (381, 38, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (382, 13, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (383, 12, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (384, 9, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (385, 23, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (386, 2, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (387, 16, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (388, 40, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (389, 19, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (390, 8, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (391, 37, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (392, 11, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (393, 25, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (394, 38, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (395, 12, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (396, 9, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (397, 4, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (398, 35, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (399, 22, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (400, 37, 3);
commit;
prompt 400 records committed...
insert into GROUPS_ (group_id, amount, age_id)
values (401, 34, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (402, 28, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (403, 23, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (404, 16, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (405, 38, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (406, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (407, 26, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (408, 20, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (409, 40, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (410, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (411, 10, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (412, 19, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (413, 35, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (414, 30, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (415, 14, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (416, 15, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (417, 34, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (418, 40, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (419, 32, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (420, 16, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (421, 40, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (422, 6, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (423, 7, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (424, 37, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (425, 34, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (426, 29, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (427, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (428, 14, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (429, 19, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (430, 4, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (431, 27, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (432, 35, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (433, 30, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (434, 40, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (435, 8, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (436, 36, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (437, 4, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (438, 22, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (439, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (440, 17, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (441, 15, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (442, 12, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (443, 32, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (444, 6, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (445, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (446, 40, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (447, 15, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (448, 17, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (449, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (450, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (451, 8, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (452, 1, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (453, 32, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (454, 25, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (455, 4, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (456, 25, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (457, 13, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (458, 20, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (459, 32, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (460, 13, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (461, 7, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (462, 19, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (463, 1, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (464, 30, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (465, 25, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (466, 21, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (467, 26, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (468, 2, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (469, 29, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (470, 26, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (471, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (472, 32, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (473, 40, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (474, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (475, 4, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (476, 21, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (477, 2, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (478, 21, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (479, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (480, 8, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (481, 29, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (482, 18, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (483, 24, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (484, 21, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (485, 22, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (486, 34, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (487, 32, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (488, 39, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (489, 12, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (490, 39, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (491, 9, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (492, 25, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (493, 7, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (494, 3, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (495, 39, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (496, 37, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (497, 1, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (498, 33, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (499, 20, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (500, 7, 3);
commit;
prompt 500 records loaded
prompt Loading PARTICIPATE...
insert into PARTICIPATE (group_id, client_id)
values (1, 1);
insert into PARTICIPATE (group_id, client_id)
values (2, 2);
insert into PARTICIPATE (group_id, client_id)
values (3, 3);
insert into PARTICIPATE (group_id, client_id)
values (4, 4);
insert into PARTICIPATE (group_id, client_id)
values (5, 5);
insert into PARTICIPATE (group_id, client_id)
values (6, 6);
insert into PARTICIPATE (group_id, client_id)
values (7, 7);
insert into PARTICIPATE (group_id, client_id)
values (8, 8);
insert into PARTICIPATE (group_id, client_id)
values (9, 9);
insert into PARTICIPATE (group_id, client_id)
values (10, 10);
commit;
prompt 10 records loaded
prompt Loading ROOMS...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (1, 4, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (2, 1, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (3, 1, 'F', 12);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (4, 3, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (5, 1, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (6, 4, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (7, 3, 'F', 33);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (8, 0, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (9, 0, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (10, 0, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (11, 3, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (12, 2, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (13, 3, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (14, 4, 'F', 31);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (15, 2, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (16, 2, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (17, 1, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (18, 0, 'F', 10);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (19, 4, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (20, 3, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (21, 0, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (22, 1, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (23, 4, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (24, 2, 'F', 9);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (25, 3, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (26, 2, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (27, 1, 'F', 19);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (28, 4, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (29, 4, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (30, 2, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (31, 4, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (32, 2, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (33, 3, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (34, 3, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (35, 1, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (36, 2, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (37, 4, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (38, 3, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (39, 0, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (40, 1, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (41, 3, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (42, 0, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (43, 1, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (44, 3, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (45, 2, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (46, 4, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (47, 0, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (48, 2, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (49, 2, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (50, 3, 'F', 19);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (51, 3, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (52, 3, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (53, 4, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (54, 0, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (55, 2, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (56, 2, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (57, 0, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (58, 3, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (59, 2, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (60, 4, 'F', 10);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (61, 0, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (62, 2, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (63, 1, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (64, 3, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (65, 1, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (66, 4, 'F', 9);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (67, 2, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (68, 3, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (69, 4, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (70, 2, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (71, 1, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (72, 1, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (73, 1, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (74, 4, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (75, 1, 'F', 31);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (76, 3, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (77, 1, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (78, 3, 'F', 32);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (79, 0, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (80, 3, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (81, 1, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (82, 0, 'F', 33);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (83, 1, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (84, 0, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (85, 0, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (86, 0, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (87, 2, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (88, 2, 'F', 33);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (89, 4, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (90, 4, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (91, 1, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (92, 4, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (93, 0, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (94, 2, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (95, 2, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (96, 3, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (97, 1, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (98, 0, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (99, 2, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (100, 4, 'F', 21);
commit;
prompt 100 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (101, 1, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (102, 1, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (103, 4, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (104, 2, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (105, 0, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (106, 3, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (107, 3, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (108, 2, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (109, 1, 'F', 12);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (110, 0, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (111, 4, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (112, 2, 'F', 10);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (113, 3, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (114, 4, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (115, 2, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (116, 1, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (117, 2, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (118, 1, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (119, 2, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (120, 3, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (121, 1, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (122, 3, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (123, 4, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (124, 0, 'F', 9);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (125, 1, 'F', 40);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (126, 1, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (127, 0, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (128, 4, 'F', 10);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (129, 3, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (130, 1, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (131, 0, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (132, 3, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (133, 2, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (134, 0, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (135, 4, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (136, 1, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (137, 4, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (138, 2, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (139, 0, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (140, 4, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (141, 0, 'F', 19);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (142, 3, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (143, 1, 'F', 10);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (144, 2, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (145, 0, 'F', 12);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (146, 4, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (147, 4, 'F', 19);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (148, 4, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (149, 1, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (150, 2, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (151, 4, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (152, 4, 'F', 33);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (153, 2, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (154, 3, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (155, 4, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (156, 1, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (157, 2, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (158, 0, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (159, 4, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (160, 1, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (161, 1, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (162, 4, 'F', 33);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (163, 2, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (164, 3, 'F', 9);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (165, 1, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (166, 2, 'F', 32);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (167, 3, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (168, 1, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (169, 3, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (170, 1, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (171, 3, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (172, 3, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (173, 4, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (174, 3, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (175, 4, 'F', 12);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (176, 2, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (177, 1, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (178, 0, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (179, 4, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (180, 2, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (181, 4, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (182, 3, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (183, 0, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (184, 0, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (185, 3, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (186, 1, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (187, 4, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (188, 0, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (189, 4, 'F', 31);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (190, 3, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (191, 4, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (192, 3, 'F', 40);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (193, 3, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (194, 1, 'F', 33);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (195, 3, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (196, 4, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (197, 3, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (198, 0, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (199, 0, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (200, 4, 'F', 5);
commit;
prompt 200 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (201, 0, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (202, 4, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (203, 3, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (204, 4, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (205, 2, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (206, 3, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (207, 1, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (208, 2, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (209, 0, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (210, 2, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (211, 4, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (212, 2, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (213, 0, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (214, 2, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (215, 4, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (216, 0, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (217, 1, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (218, 2, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (219, 0, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (220, 0, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (221, 3, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (222, 4, 'F', 31);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (223, 1, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (224, 1, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (225, 1, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (226, 3, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (227, 3, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (228, 2, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (229, 1, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (230, 3, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (231, 3, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (232, 0, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (233, 3, 'F', 32);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (234, 0, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (235, 0, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (236, 3, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (237, 2, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (238, 3, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (239, 2, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (240, 4, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (241, 4, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (242, 3, 'F', 40);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (243, 3, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (244, 1, 'F', 40);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (245, 4, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (246, 3, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (247, 1, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (248, 2, 'F', 40);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (249, 1, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (250, 4, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (251, 3, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (252, 1, 'F', 12);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (253, 1, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (254, 3, 'F', 9);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (255, 4, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (256, 1, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (257, 0, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (258, 3, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (259, 0, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (260, 0, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (261, 0, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (262, 2, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (263, 2, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (264, 1, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (265, 0, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (266, 1, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (267, 2, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (268, 3, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (269, 2, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (270, 0, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (271, 2, 'F', 19);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (272, 1, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (273, 4, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (274, 2, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (275, 0, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (276, 0, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (277, 1, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (278, 4, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (279, 2, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (280, 4, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (281, 2, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (282, 1, 'F', 19);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (283, 1, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (284, 3, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (285, 2, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (286, 2, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (287, 0, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (288, 4, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (289, 3, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (290, 0, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (291, 4, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (292, 1, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (293, 4, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (294, 4, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (295, 1, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (296, 3, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (297, 3, 'F', 31);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (298, 2, 'F', 12);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (299, 1, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (300, 3, 'F', 22);
commit;
prompt 300 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (301, 1, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (302, 0, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (303, 4, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (304, 2, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (305, 4, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (306, 3, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (307, 2, 'F', 40);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (308, 0, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (309, 0, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (310, 1, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (311, 4, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (312, 1, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (313, 1, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (314, 3, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (315, 1, 'F', 31);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (316, 0, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (317, 2, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (318, 2, 'F', 19);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (319, 1, 'F', 12);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (320, 3, 'F', 31);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (321, 4, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (322, 0, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (323, 2, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (324, 0, 'F', 9);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (325, 4, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (326, 1, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (327, 1, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (328, 4, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (329, 3, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (330, 3, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (331, 1, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (332, 3, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (333, 0, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (334, 1, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (335, 0, 'F', 33);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (336, 2, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (337, 3, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (338, 3, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (339, 0, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (340, 2, 'F', 10);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (341, 3, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (342, 3, 'F', 12);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (343, 1, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (344, 3, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (345, 4, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (346, 2, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (347, 0, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (348, 3, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (349, 1, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (350, 0, 'F', 9);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (351, 3, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (352, 4, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (353, 4, 'F', 40);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (354, 0, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (355, 2, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (356, 4, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (357, 4, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (358, 4, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (359, 2, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (360, 1, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (361, 3, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (362, 2, 'F', 9);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (363, 0, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (364, 0, 'F', 12);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (365, 2, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (366, 4, 'F', 40);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (367, 1, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (368, 3, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (369, 3, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (370, 3, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (371, 3, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (372, 1, 'F', 33);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (373, 1, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (374, 1, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (375, 2, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (376, 2, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (377, 1, 'F', 31);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (378, 4, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (379, 3, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (380, 3, 'F', 32);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (381, 3, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (382, 4, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (383, 2, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (384, 0, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (385, 4, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (386, 2, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (387, 3, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (388, 0, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (389, 0, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (390, 2, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (391, 0, 'F', 9);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (392, 1, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (393, 3, 'F', 33);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (394, 2, 'F', 32);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (395, 2, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (396, 1, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (397, 4, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (398, 0, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (399, 2, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (400, 2, 'F', 38);
commit;
prompt 400 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (401, 0, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (402, 3, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (403, 0, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (404, 1, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (405, 4, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (406, 0, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (407, 0, 'F', 40);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (408, 1, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (409, 2, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (410, 0, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (411, 3, 'F', 33);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (412, 1, 'F', 32);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (413, 1, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (414, 1, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (415, 0, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (416, 0, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (417, 2, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (418, 1, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (419, 0, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (420, 1, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (421, 4, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (422, 3, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (423, 1, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (424, 4, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (425, 3, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (426, 2, 'F', 21);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (427, 2, 'F', 31);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (428, 1, 'F', 19);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (429, 0, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (430, 4, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (431, 1, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (432, 0, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (433, 3, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (434, 3, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (435, 4, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (436, 2, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (437, 4, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (438, 3, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (439, 1, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (440, 0, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (441, 2, 'F', 19);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (442, 4, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (443, 4, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (444, 3, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (445, 1, 'F', 12);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (446, 4, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (447, 4, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (448, 2, 'F', 36);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (449, 2, 'F', 5);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (450, 2, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (451, 0, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (452, 2, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (453, 4, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (454, 4, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (455, 3, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (456, 0, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (457, 1, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (458, 3, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (459, 4, 'F', 4);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (460, 0, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (461, 3, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (462, 2, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (463, 4, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (464, 1, 'F', 9);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (465, 2, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (466, 2, 'F', 22);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (467, 0, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (468, 3, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (469, 2, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (470, 4, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (471, 4, 'F', 7);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (472, 0, 'F', 39);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (473, 0, 'F', 13);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (474, 2, 'F', 25);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (475, 0, 'F', 40);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (476, 3, 'F', 8);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (477, 3, 'F', 40);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (478, 3, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (479, 3, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (480, 3, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (481, 3, 'F', 29);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (482, 2, 'F', 27);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (483, 1, 'F', 31);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (484, 0, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (485, 3, 'F', 10);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (486, 1, 'F', 23);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (487, 0, 'F', 30);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (488, 4, 'F', 14);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (489, 3, 'F', 28);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (490, 3, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (491, 3, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (492, 4, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (493, 3, 'F', 17);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (494, 3, 'F', 6);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (495, 4, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (496, 2, 'F', 34);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (497, 2, 'F', 16);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (498, 4, 'F', 38);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (499, 2, 'F', 26);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (500, 2, 'F', 18);
commit;
prompt 500 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (501, 0, 'F', 32);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (502, 3, 'F', 24);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (503, 4, 'F', 19);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (504, 2, 'F', 37);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (505, 3, 'F', 15);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (506, 3, 'F', 35);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (507, 4, 'F', 20);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (508, 2, 'F', 18);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (509, 0, 'F', 11);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity)
values (510, 2, 'F', 31);
commit;
prompt 510 records loaded
prompt Loading TEACHERS...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (1, 'Isabella', 'Jay', 1, 68611, 13930, to_date('16-04-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (2, 'Shirley', 'Ermey', 2, 84533, 11977, to_date('15-06-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (3, 'Whoopi', 'Dafoe', 3, 18453, 15728, to_date('03-12-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (4, 'Chris', 'Hoskins', 4, 74083, 18193, to_date('19-09-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (5, 'Kate', 'Feore', 5, 42328, 10942, to_date('09-07-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (6, 'Nicole', 'Hackman', 6, 96996, 12575, to_date('14-10-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (7, 'Mika', 'Aiken', 7, 57321, 13320, to_date('01-08-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (8, 'Hilton', 'Salonga', 8, 70912, 13361, to_date('24-05-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (9, 'Aaron', 'Todd', 9, 50162, 17706, to_date('04-05-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (10, 'Eddie', 'Jackman', 10, 84571, 14414, to_date('06-10-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (11, 'Tcheky', 'Sartain', 105, 37587, 19600, to_date('26-12-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (12, 'Madeleine', 'Mandrell', 366, 42958, 13982, to_date('21-08-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (13, 'Shirley', 'Mahood', 11, 18621, 8729, to_date('04-12-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (14, 'Nancy', 'Cartlidge', 312, 51064, 16295, to_date('09-02-1955', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (15, 'Manu', 'Bergen', 96, 89284, 10304, to_date('15-08-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (16, 'Corey', 'Bruce', 12, 91867, 18003, to_date('03-07-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (17, 'Delroy', 'Akins', 245, 89543, 9550, to_date('12-08-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (18, 'Azucar', 'Getty', 70, 28757, 12000, to_date('29-08-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (19, 'Kylie', 'Streep', 371, 90146, 12090, to_date('23-02-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (20, 'Nanci', 'Schiff', 185, 23674, 9136, to_date('10-12-1964', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (21, 'Dylan', 'Kirkwood', 151, 95046, 17319, to_date('13-07-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (24, 'Saul', 'Penders', 42, 57489, 10760, to_date('24-10-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (25, 'Jeffrey', 'Dorn', 134, 50348, 11924, to_date('29-04-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (26, 'Machine', 'Blades', 226, 57119, 9208, to_date('18-02-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (27, 'Oded', 'Snipes', 336, 84523, 11897, to_date('02-10-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (29, 'Peabo', 'Kline', 170, 10314, 12434, to_date('02-07-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (30, 'Liam', 'Beck', 20, 61518, 17974, to_date('22-04-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (31, 'Sylvester', 'May', 314, 70916, 12155, to_date('01-12-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (32, 'Fisher', 'Burton', 5, 11255, 16524, to_date('06-03-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (33, 'Marianne', 'Swayze', 1, 18298, 18995, to_date('22-12-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (34, 'Hookah', 'Caan', 5, 84558, 14945, to_date('11-04-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (35, 'Kiefer', 'Tate', 142, 24922, 13761, to_date('31-03-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (37, 'Nancy', 'Leto', 251, 15622, 12478, to_date('04-10-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (38, 'Larenz', 'Rodgers', 101, 64689, 13017, to_date('25-03-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (39, 'Cheryl', 'Houston', 215, 47937, 11681, to_date('11-08-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (40, 'Leon', 'Weber', 131, 20574, 13668, to_date('19-05-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (41, 'Grant', 'May', 75, 71668, 11881, to_date('01-10-1990', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (42, 'Alan', 'Browne', 195, 19950, 12897, to_date('12-01-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (43, 'Bryan', 'Rippy', 275, 30948, 17356, to_date('09-11-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (44, 'Lili', 'Smurfit', 221, 15821, 17827, to_date('16-02-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (46, 'Dom', 'Damon', 266, 99474, 13436, to_date('17-07-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (47, 'Trey', 'Carrington', 345, 73075, 13733, to_date('10-10-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (48, 'Nathan', 'Carlton', 43, 13020, 19349, to_date('25-01-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (49, 'Bette', 'Vance', 45, 42723, 11699, to_date('07-02-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (50, 'Gladys', 'Ermey', 35, 10617, 13719, to_date('07-02-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (53, 'Debbie', 'O''Neill', 95, 96438, 17818, to_date('02-09-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (54, 'Lloyd', 'Capshaw', 141, 71714, 18897, to_date('28-01-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (55, 'Olympia', 'Hayes', 77, 47394, 10292, to_date('11-05-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (56, 'Isabella', 'Mortensen', 386, 74456, 12244, to_date('17-05-1990', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (57, 'Aaron', 'Sampson', 88, 40852, 8311, to_date('08-05-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (58, 'Curt', 'Gooding', 43, 20455, 13776, to_date('06-08-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (59, 'Emmylou', 'Quinn', 122, 24045, 9596, to_date('05-01-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (60, 'Alice', 'Brooke', 68, 23513, 12189, to_date('20-08-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (61, 'LeVar', 'Savage', 66, 48999, 15026, to_date('17-11-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (62, 'Madeline', 'Briscoe', 241, 77889, 12154, to_date('13-05-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (63, 'Omar', 'Rhodes', 85, 80172, 12146, to_date('01-03-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (64, 'Loretta', 'Hauser', 53, 27165, 11314, to_date('17-07-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (65, 'Emerson', 'Matarazzo', 290, 75685, 9075, to_date('27-04-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (66, 'Ricardo', 'Downey', 36, 38055, 13902, to_date('17-08-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (67, 'Goldie', 'Zevon', 145, 45451, 17008, to_date('23-07-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (68, 'Hope', 'Biggs', 63, 78659, 16670, to_date('23-09-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (69, 'Wes', 'Nelson', 165, 81961, 14486, to_date('24-09-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (70, 'Campbell', 'Gyllenhaal', 395, 73234, 13805, to_date('06-04-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (71, 'Albert', 'Vannelli', 176, 22022, 13643, to_date('16-06-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (72, 'Scarlett', 'Bogguss', 203, 87969, 10543, to_date('19-07-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (73, 'Annette', 'Lopez', 76, 40222, 15596, to_date('18-12-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (76, 'Vondie', 'Collette', 220, 42991, 9921, to_date('26-10-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (77, 'Dionne', 'Carrey', 168, 79930, 18206, to_date('07-08-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (78, 'Danny', 'Palin', 171, 79873, 17035, to_date('04-08-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (80, 'Cherry', 'Tilly', 294, 86355, 9695, to_date('26-09-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (81, 'Joe', 'Carrington', 30, 53958, 12473, to_date('26-12-1970', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (82, 'Rebeka', 'Karyo', 314, 73145, 8512, to_date('18-08-1974', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (83, 'Rebeka', 'Davis', 340, 23383, 9703, to_date('13-04-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (84, 'Freddie', 'Crimson', 152, 57875, 13628, to_date('25-11-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (85, 'Clay', 'Mahood', 125, 55568, 17566, to_date('04-06-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (86, 'Rosario', 'Ali', 101, 34938, 18369, to_date('01-10-1961', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (87, 'Don', 'Eat World', 31, 70840, 11247, to_date('06-09-1955', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (88, 'Faye', 'Isaak', 104, 32603, 9060, to_date('08-06-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (90, 'Vertical', 'Davies', 170, 84431, 15735, to_date('19-07-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (91, 'Whoopi', 'Damon', 152, 71021, 15604, to_date('11-01-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (92, 'Mary', 'Crudup', 8, 54533, 17376, to_date('13-04-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (93, 'Ozzy', 'Sobieski', 185, 42721, 18065, to_date('03-05-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (94, 'Geggy', 'Keaton', 109, 88696, 12422, to_date('04-05-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (95, 'Armand', 'Langella', 283, 53852, 16592, to_date('14-02-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (96, 'Kristin', 'Ingram', 157, 55908, 16206, to_date('01-08-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (97, 'Jeffrey', 'Shawn', 340, 28221, 15179, to_date('27-06-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (98, 'Liquid', 'Gilley', 6, 57321, 14003, to_date('27-02-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (99, 'Mel', 'Lynne', 177, 45224, 18090, to_date('06-12-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (100, 'Geggy', 'Gano', 94, 52166, 9399, to_date('14-03-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (101, 'Azucar', 'Tierney', 20, 79540, 16076, to_date('11-04-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (102, 'Betty', 'Barnett', 330, 92672, 10651, to_date('17-10-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (103, 'Warren', 'Faithfull', 41, 24274, 17555, to_date('02-05-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (104, 'Brenda', 'Morrison', 147, 72506, 16727, to_date('10-05-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (105, 'Barry', 'Lucas', 97, 38333, 19939, to_date('04-10-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (106, 'Lenny', 'Day-Lewis', 125, 75767, 19724, to_date('14-01-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (107, 'Ben', 'Rucker', 142, 21299, 11303, to_date('26-12-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (108, 'Max', 'McNarland', 98, 96077, 19342, to_date('02-06-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (109, 'Lois', 'Tanon', 253, 11607, 11593, to_date('17-08-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (111, 'Curtis', 'Stevens', 139, 86287, 9526, to_date('22-04-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (112, 'Rick', 'Logue', 164, 83798, 16995, to_date('14-10-1974', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (113, 'Madeline', 'Reno', 76, 73062, 14416, to_date('31-03-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (114, 'Meryl', 'Gryner', 283, 57170, 10267, to_date('19-07-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (116, 'Bette', 'Rhys-Davies', 317, 15798, 16993, to_date('25-11-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (118, 'Victor', 'Allen', 384, 12439, 10155, to_date('02-12-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (119, 'Bo', 'Langella', 286, 74157, 11955, to_date('03-04-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (120, 'Lennie', 'Feuerstein', 318, 24479, 14910, to_date('26-05-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (121, 'Gena', 'Leigh', 43, 51246, 17443, to_date('12-10-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (122, 'Willie', 'De Almeida', 111, 50504, 14721, to_date('01-06-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (123, 'Balthazar', 'Leary', 57, 81048, 17651, to_date('09-03-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (124, 'Buddy', 'Banderas', 83, 83214, 15048, to_date('23-05-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (125, 'Jennifer', 'McIntosh', 90, 39730, 17717, to_date('14-01-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (126, 'Rachael', 'Dillane', 188, 10706, 11289, to_date('27-03-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (127, 'Emily', 'Sartain', 101, 75364, 9098, to_date('31-03-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (128, 'Wendy', 'Krabbe', 367, 60657, 18650, to_date('31-10-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (129, 'Toshiro', 'Tomlin', 275, 16971, 11346, to_date('15-09-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (130, 'Minnie', 'Abraham', 345, 84437, 12635, to_date('01-06-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (131, 'Tom', 'Flanery', 196, 65462, 8486, to_date('13-11-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (132, 'Melba', 'Bailey', 183, 50689, 15855, to_date('24-01-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (133, 'Jean', 'Sisto', 106, 62235, 17166, to_date('08-09-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (134, 'Drew', 'Wahlberg', 197, 90396, 17819, to_date('11-12-1961', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (135, 'Randall', 'Belle', 129, 53726, 10772, to_date('24-10-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (137, 'Louise', 'Holliday', 188, 32690, 14699, to_date('29-06-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (138, 'Emm', 'Jordan', 44, 15464, 12775, to_date('10-12-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (140, 'Marianne', 'Kahn', 90, 79192, 18161, to_date('23-02-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (141, 'Amanda', 'Payton', 194, 69137, 17303, to_date('03-03-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (142, 'Cathy', 'Shannon', 395, 21211, 10646, to_date('02-01-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (143, 'Terry', 'Lipnicki', 72, 12525, 17102, to_date('01-08-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (144, 'Bo', 'Griffin', 350, 69772, 12194, to_date('28-12-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (145, 'Will', 'Connery', 157, 72349, 11069, to_date('09-05-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (146, 'Kazem', 'Ramis', 222, 96023, 11871, to_date('30-08-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (148, 'Leon', 'Wood', 383, 46417, 11869, to_date('14-07-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (149, 'Samuel', 'Hannah', 294, 40052, 11474, to_date('11-06-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (151, 'Lili', 'Ricci', 211, 67627, 19271, to_date('27-11-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (152, 'Joe', 'Meniketti', 251, 75132, 10491, to_date('02-03-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (153, 'Jean-Claude', 'Gatlin', 144, 94516, 9773, to_date('22-11-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (154, 'Mike', 'Coleman', 270, 12627, 13371, to_date('22-02-1970', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (155, 'Albert', 'Boothe', 369, 22221, 18466, to_date('16-05-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (156, 'Christian', 'Benet', 376, 24916, 8782, to_date('02-06-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (157, 'Cesar', 'Ermey', 245, 20780, 13151, to_date('25-08-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (158, 'Chrissie', 'Rodgers', 345, 53187, 16268, to_date('16-07-1979', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (159, 'Avril', 'Tomlin', 35, 70616, 12269, to_date('23-06-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (160, 'Ani', 'Aaron', 28, 27086, 9092, to_date('24-04-1970', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (162, 'Dick', 'Botti', 379, 83984, 10183, to_date('19-06-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (163, 'Anita', 'Frakes', 258, 79886, 18679, to_date('20-05-1990', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (165, 'Sam', 'Dillon', 11, 16423, 8673, to_date('01-10-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (166, 'Ossie', 'Joli', 386, 56299, 16568, to_date('01-05-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (167, 'Gilbert', 'Baranski', 58, 41911, 19650, to_date('19-12-1957', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (168, 'Ernie', 'Hewitt', 42, 50698, 12813, to_date('27-12-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (169, 'Amy', 'DiBiasio', 100, 12482, 16672, to_date('05-01-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (170, 'Larry', 'Morales', 369, 29127, 15433, to_date('06-11-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (171, 'Cheech', 'Bugnon', 25, 81295, 14367, to_date('12-09-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (172, 'Debra', 'Fogerty', 130, 98946, 17454, to_date('18-09-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (174, 'Maxine', 'Condition', 48, 40684, 15684, to_date('10-05-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (175, 'Wesley', 'Judd', 54, 63894, 10270, to_date('19-08-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (176, 'Paul', 'Yankovic', 48, 41199, 17244, to_date('18-08-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (177, 'Geoffrey', 'Barnett', 350, 46635, 10977, to_date('18-04-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (178, 'Cheryl', 'Manning', 110, 75534, 9211, to_date('13-04-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (179, 'Allan', 'Pride', 4, 65983, 11825, to_date('30-06-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (180, 'Stellan', 'Levert', 9, 36970, 19081, to_date('19-08-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (181, 'Bo', 'Thewlis', 9, 38160, 11472, to_date('15-04-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (183, 'Emm', 'Woods', 75, 84035, 19049, to_date('15-12-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (184, 'Lauren', 'Atkins', 23, 52110, 15503, to_date('21-02-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (185, 'Caroline', 'Woodward', 29, 36253, 17337, to_date('28-11-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (186, 'Lin', 'Bruce', 350, 87256, 17322, to_date('26-02-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (187, 'Lionel', 'Newman', 121, 65136, 11781, to_date('19-12-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (188, 'Olympia', 'Walker', 272, 87501, 17153, to_date('30-04-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (189, 'King', 'Hatfield', 12, 79121, 18535, to_date('05-05-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (190, 'Anthony', 'Morrison', 146, 87907, 13868, to_date('31-03-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (191, 'Ewan', 'Frost', 277, 78017, 15712, to_date('08-04-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (192, 'Anjelica', 'Place', 189, 53369, 16986, to_date('20-07-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (193, 'Matt', 'Steenburgen', 5, 59872, 17047, to_date('16-09-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (195, 'Alfie', 'Sorvino', 120, 84716, 10147, to_date('24-12-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (196, 'Maury', 'Berenger', 274, 99229, 18234, to_date('07-11-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (197, 'Fred', 'Colin Young', 221, 40982, 8516, to_date('05-10-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (198, 'Rosanne', 'DeGraw', 189, 92772, 15162, to_date('27-01-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (199, 'Tea', 'Fonda', 349, 32862, 13543, to_date('14-05-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (200, 'Franco', 'Weller', 237, 49452, 18116, to_date('14-08-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (201, 'Anthony', 'Gatlin', 83, 79399, 9649, to_date('04-09-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (203, 'Tracy', 'Cervine', 189, 88585, 10769, to_date('04-09-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (204, 'Andre', 'Whitmore', 253, 14452, 19294, to_date('01-05-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (206, 'Mac', 'Diaz', 314, 19217, 9225, to_date('18-04-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (207, 'Terry', 'Evett', 131, 20053, 10137, to_date('23-02-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (208, 'Patrick', 'Eastwood', 157, 17505, 9092, to_date('21-06-1990', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (209, 'Mary-Louise', 'Diehl', 29, 13234, 13681, to_date('19-07-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (210, 'Mekhi', 'Boorem', 24, 84032, 13172, to_date('19-03-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (212, 'Jason', 'Davison', 154, 77193, 14452, to_date('18-07-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (213, 'Gladys', 'Ferrell', 161, 29515, 10389, to_date('30-11-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (214, 'Kurtwood', 'Overstreet', 286, 19529, 16022, to_date('05-08-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (215, 'Belinda', 'Gyllenhaal', 247, 88663, 12146, to_date('23-03-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (216, 'Lynette', 'Kier', 259, 25464, 16645, to_date('19-03-1961', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (217, 'Nickel', 'Uggams', 197, 79397, 19427, to_date('07-06-1997', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (218, 'Loretta', 'Garfunkel', 154, 53345, 11210, to_date('17-05-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (219, 'Paula', 'Collie', 43, 42889, 18328, to_date('10-11-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (220, 'Warren', 'Neville', 57, 51330, 13732, to_date('31-07-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (221, 'Larry', 'Neil', 53, 60506, 15037, to_date('09-10-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (222, 'Colm', 'Neil', 57, 99132, 17603, to_date('09-11-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (223, 'Caroline', 'Ruiz', 324, 68475, 12030, to_date('24-07-1970', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (224, 'Loren', 'McCabe', 395, 80179, 14777, to_date('27-07-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (226, 'Remy', 'Diddley', 152, 61188, 18578, to_date('26-08-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (227, 'Clarence', 'Idle', 39, 98674, 19374, to_date('04-09-1978', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (228, 'Bebe', 'Chambers', 197, 58719, 13807, to_date('14-06-1979', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (229, 'Breckin', 'Thorton', 125, 77289, 13613, to_date('06-07-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (230, 'Carla', 'Close', 197, 54709, 12862, to_date('16-10-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (231, 'Tori', 'Coleman', 19, 93112, 12808, to_date('01-02-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (232, 'Hugh', 'McDormand', 394, 65543, 15522, to_date('28-06-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (234, 'Saul', 'Pony', 153, 91670, 9118, to_date('27-11-1979', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (235, 'Fionnula', 'Kahn', 177, 45699, 12392, to_date('30-01-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (236, 'Sander', 'Law', 195, 67320, 16756, to_date('17-09-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (239, 'Karen', 'Swayze', 45, 43161, 16809, to_date('30-04-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (240, 'Etta', 'Fender', 74, 40614, 15689, to_date('18-10-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (241, 'Boyd', 'Tolkan', 271, 11959, 9725, to_date('01-02-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (242, 'Donald', 'Rowlands', 143, 52348, 13642, to_date('05-10-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (243, 'Jonatha', 'Skaggs', 231, 14203, 16147, to_date('03-01-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (245, 'Kirk', 'Zahn', 389, 56743, 12644, to_date('12-05-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (246, 'Ethan', 'Glenn', 274, 65564, 8684, to_date('10-06-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (247, 'Albertina', 'Giamatti', 396, 69294, 14418, to_date('15-01-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (248, 'Meredith', 'Bruce', 79, 87741, 15616, to_date('17-10-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (249, 'Nickel', 'Short', 49, 89387, 10336, to_date('27-07-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (250, 'Ronnie', 'Heron', 386, 72351, 18673, to_date('01-04-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (251, 'Rachael', 'Stiller', 167, 81075, 13834, to_date('07-06-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (252, 'Harold', 'Gleeson', 114, 79265, 11095, to_date('22-02-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (253, 'Hilton', 'Arthur', 333, 13187, 10824, to_date('11-02-1998', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (254, 'Mac', 'Thomson', 245, 93632, 19984, to_date('11-05-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (255, 'Vern', 'Ferrer', 167, 35397, 8830, to_date('21-10-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (256, 'Kenny', 'Skerritt', 296, 70691, 13916, to_date('23-11-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (258, 'Giancarlo', 'Ferrer', 247, 80506, 9197, to_date('28-05-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (259, 'Art', 'Spacek', 371, 72980, 13836, to_date('22-12-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (260, 'Heather', 'Costner', 16, 42170, 10401, to_date('19-10-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (261, 'Nicholas', 'Witherspoon', 10, 89220, 11881, to_date('17-04-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (263, 'Cate', 'Colton', 188, 41695, 16800, to_date('12-09-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (264, 'Debbie', 'Maxwell', 283, 22769, 14233, to_date('02-04-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (265, 'Penelope', 'Tennison', 162, 93864, 14792, to_date('07-05-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (267, 'Brian', 'Hewitt', 270, 89482, 14465, to_date('17-07-1964', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (268, 'Patricia', 'Deschanel', 189, 71662, 17915, to_date('26-01-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (269, 'Bonnie', 'Church', 269, 25307, 17729, to_date('25-04-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (270, 'Patricia', 'McDormand', 55, 38033, 12865, to_date('03-06-1974', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (271, 'Pelvic', 'Hagar', 42, 47875, 9389, to_date('15-11-1961', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (272, 'Sinead', 'Holeman', 95, 84948, 19984, to_date('19-05-1990', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (273, 'Cyndi', 'Hughes', 249, 15126, 16653, to_date('23-05-1970', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (275, 'Lily', 'Sample', 159, 36172, 16720, to_date('16-12-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (277, 'Peter', 'Oldman', 29, 94971, 13655, to_date('02-03-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (278, 'Nikki', 'Yorn', 290, 64089, 12472, to_date('16-08-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (279, 'Jimmy', 'McCracken', 291, 36212, 8718, to_date('19-03-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (280, 'Vince', 'Garfunkel', 307, 83991, 17116, to_date('12-10-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (281, 'Terence', 'Oszajca', 285, 44163, 11358, to_date('02-12-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (282, 'Marty', 'Calle', 249, 58228, 18346, to_date('13-09-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (284, 'Loren', 'Langella', 129, 86666, 12816, to_date('23-06-1997', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (285, 'Keanu', 'Robinson', 114, 97916, 17066, to_date('11-01-1979', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (286, 'Laura', 'Quinones', 174, 10673, 16522, to_date('30-03-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (288, 'Tim', 'Whitman', 37, 10578, 16853, to_date('21-07-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (289, 'Tim', 'Keaton', 25, 86189, 8656, to_date('22-07-1961', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (293, 'Steven', 'Damon', 266, 63153, 18239, to_date('21-11-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (294, 'Stockard', 'Garr', 90, 97044, 17627, to_date('17-02-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (295, 'Jody', 'Cattrall', 76, 80144, 15875, to_date('09-04-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (296, 'Morris', 'Judd', 179, 47429, 14446, to_date('22-01-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (297, 'Adrien', 'Duchovny', 60, 87291, 9542, to_date('24-07-1957', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (298, 'Halle', 'Tripplehorn', 306, 25038, 9874, to_date('31-08-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (300, 'Alana', 'Pullman', 171, 44089, 9842, to_date('13-02-1998', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (301, 'Cherry', 'Langella', 179, 52123, 17073, to_date('04-03-1964', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (302, 'Jeroen', 'Lowe', 62, 46851, 13987, to_date('05-08-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (303, 'Tom', 'Campbell', 65, 61354, 17985, to_date('23-12-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (305, 'Nastassja', 'Irving', 41, 17550, 19007, to_date('11-06-1957', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (306, 'Gaby', 'von Sydow', 211, 64254, 14656, to_date('09-06-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (307, 'Bernie', 'Karyo', 73, 32507, 17877, to_date('20-03-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (308, 'Stanley', 'Weber', 10, 20741, 8768, to_date('31-12-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (309, 'Ice', 'Daniels', 121, 51827, 11839, to_date('18-05-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (310, 'Kathleen', 'Carr', 177, 16246, 16144, to_date('08-01-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (311, 'Vonda', 'Bacon', 201, 22199, 16905, to_date('30-01-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (312, 'Bridget', 'Sellers', 264, 61762, 16844, to_date('26-07-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (313, 'Hector', 'Neil', 107, 34164, 10785, to_date('02-08-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (314, 'Marina', 'Love', 248, 37431, 15867, to_date('01-03-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (315, 'Lin', 'Torn', 48, 53631, 9652, to_date('29-08-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (318, 'Laura', 'Pryce', 211, 82022, 17730, to_date('06-07-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (320, 'Christmas', 'Parker', 267, 88015, 17036, to_date('27-01-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (321, 'Holly', 'Ball', 308, 14577, 12114, to_date('16-11-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (322, 'Sylvester', 'Palmieri', 297, 93472, 13214, to_date('08-07-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (323, 'Juliana', 'Lunch', 201, 90017, 11394, to_date('05-12-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (324, 'Steven', 'Jamal', 286, 57402, 14951, to_date('09-08-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (325, 'Millie', 'Myers', 179, 97963, 14603, to_date('06-08-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (326, 'Rascal', 'Mifune', 58, 89728, 14214, to_date('28-06-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (327, 'Cary', 'Cale', 202, 72492, 15387, to_date('20-05-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (328, 'Tommy', 'Arquette', 53, 18323, 19363, to_date('22-07-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (329, 'Adam', 'Perez', 30, 79601, 8469, to_date('01-05-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (330, 'Rosario', 'Herrmann', 367, 74105, 17621, to_date('28-10-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (331, 'Peabo', 'Sanders', 400, 16936, 15887, to_date('10-09-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (332, 'Denzel', 'Sarsgaard', 176, 23712, 18616, to_date('27-01-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (333, 'Kazem', 'Robards', 123, 44302, 17747, to_date('18-07-1998', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (334, 'Molly', 'Lopez', 147, 41798, 9658, to_date('30-04-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (335, 'Lorraine', 'Rhymes', 158, 43256, 15701, to_date('05-05-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (336, 'Domingo', 'McCracken', 142, 67489, 16462, to_date('03-12-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (337, 'Kirsten', 'Sinatra', 220, 36543, 16328, to_date('19-09-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (338, 'Marley', 'Morrison', 217, 82004, 9972, to_date('05-09-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (339, 'Mira', 'Dooley', 380, 10679, 12597, to_date('16-07-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (340, 'Avril', 'Coltrane', 234, 77005, 15022, to_date('09-07-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (341, 'Carla', 'Shaye', 202, 37437, 8614, to_date('13-07-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (342, 'Mark', 'Lipnicki', 274, 35679, 11463, to_date('31-12-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (343, 'Isabella', 'Strathairn', 96, 82540, 15832, to_date('15-06-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (344, 'Rosie', 'Kenoly', 173, 91103, 13498, to_date('23-01-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (345, 'Holland', 'Coward', 13, 82330, 11911, to_date('04-03-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (346, 'Mickey', 'Washington', 185, 58915, 19873, to_date('27-07-1971', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (347, 'Brendan', 'Vassar', 369, 81691, 12424, to_date('01-08-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (348, 'Judy', 'Clarkson', 71, 83815, 10630, to_date('23-10-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (349, 'Marc', 'Liotta', 129, 69025, 12581, to_date('01-10-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (350, 'Greg', 'Pollack', 23, 21948, 13119, to_date('29-08-1955', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (351, 'Connie', 'Sizemore', 325, 66536, 15177, to_date('22-03-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (352, 'Roscoe', 'Webb', 132, 63674, 10914, to_date('22-06-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (353, 'Christine', 'Evett', 153, 66630, 15936, to_date('06-11-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (354, 'Xander', 'Klugh', 9, 83782, 12385, to_date('27-06-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (355, 'Humberto', 'Molina', 113, 57691, 12451, to_date('06-02-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (357, 'Etta', 'Lucien', 337, 45029, 9893, to_date('17-03-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (358, 'Mint', 'Carradine', 394, 12445, 12955, to_date('20-04-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (359, 'Maggie', 'Humphrey', 383, 85271, 11692, to_date('06-02-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (361, 'Miguel', 'Rourke', 23, 14983, 10366, to_date('07-07-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (362, 'Vondie', 'Myers', 56, 40870, 14794, to_date('01-08-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (364, 'Debby', 'Levy', 337, 72143, 13307, to_date('22-08-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (365, 'Olympia', 'Shannon', 212, 38847, 8419, to_date('06-05-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (366, 'Russell', 'Loggins', 226, 18394, 8892, to_date('18-05-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (367, 'Judge', 'Chaykin', 65, 65739, 14643, to_date('27-02-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (368, 'Denise', 'McConaughey', 61, 67044, 13544, to_date('06-12-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (369, 'Tzi', 'Reeves', 263, 21922, 11162, to_date('12-03-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (370, 'Paula', 'Watley', 143, 97893, 15345, to_date('08-10-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (371, 'Emmylou', 'Secada', 385, 90659, 8861, to_date('10-03-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (372, 'Boz', 'Portman', 77, 69120, 17557, to_date('13-01-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (373, 'Rene', 'Travers', 310, 94428, 8398, to_date('02-09-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (374, 'Dylan', 'Cruz', 222, 78529, 17191, to_date('04-06-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (375, 'Sarah', 'Lynch', 45, 25017, 9354, to_date('30-08-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (376, 'Clint', 'Johnson', 355, 84564, 8778, to_date('30-08-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (377, 'Jude', 'Apple', 205, 54100, 9028, to_date('15-10-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (378, 'Sander', 'Turturro', 364, 14136, 17999, to_date('06-05-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (379, 'Trini', 'Kutcher', 18, 87568, 9078, to_date('22-09-1964', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (380, 'Rip', 'Savage', 268, 16786, 16872, to_date('27-03-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (381, 'Parker', 'Diggs', 189, 29409, 15191, to_date('22-05-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (382, 'Alfred', 'Ronstadt', 175, 17218, 19201, to_date('02-09-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (383, 'Albert', 'Lerner', 100, 53400, 17959, to_date('29-09-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (384, 'Peter', 'Anderson', 80, 80730, 9937, to_date('14-04-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (385, 'Bridgette', 'Keaton', 88, 23413, 18168, to_date('12-09-1997', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (386, 'Remy', 'Ripley', 318, 68582, 13181, to_date('22-08-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (388, 'Christine', 'Studi', 361, 52817, 18476, to_date('22-12-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (389, 'Ellen', 'Kilmer', 229, 48228, 16027, to_date('04-01-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (390, 'James', 'Badalucco', 191, 12589, 16110, to_date('06-09-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (391, 'Mac', 'Moreno', 141, 27517, 16146, to_date('01-01-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (392, 'Nicole', 'McGovern', 125, 56506, 11099, to_date('24-09-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (394, 'Leelee', 'Evett', 326, 98035, 8532, to_date('13-08-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (395, 'Ron', 'Avital', 31, 65713, 12879, to_date('14-03-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (396, 'Andrew', 'Crouse', 91, 93493, 13991, to_date('14-01-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (397, 'Marisa', 'Robards', 259, 95258, 16759, to_date('26-12-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (398, 'Lennie', 'Rawls', 317, 84655, 11700, to_date('24-12-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (399, 'Merle', 'Holliday', 32, 43461, 17917, to_date('14-02-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (400, 'Marley', 'Marx', 274, 30520, 18120, to_date('19-04-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (401, 'Jay', 'Marshall', 145, 36000, 9050, to_date('09-05-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (402, 'Desmond', 'O''Donnell', 266, 65249, 11660, to_date('03-07-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (403, 'Bridget', 'Bedelia', 296, 54918, 17650, to_date('04-12-1957', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (404, 'Sammy', 'Wiedlin', 299, 41823, 10196, to_date('20-11-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (405, 'Kris', 'Chan', 183, 17928, 18611, to_date('02-05-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (406, 'Stellan', 'Hutton', 164, 33439, 19090, to_date('02-09-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (407, 'Meg', 'Postlethwaite', 216, 39914, 16329, to_date('10-07-1998', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (408, 'Jeffery', 'Connick', 35, 67192, 19385, to_date('08-04-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (409, 'Jet', 'Blanchett', 183, 17413, 11429, to_date('11-01-1961', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (410, 'Leonardo', 'Diaz', 389, 87047, 12883, to_date('06-06-1997', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (411, 'Marc', 'Bell', 327, 39357, 14346, to_date('21-12-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (412, 'Connie', 'Coburn', 162, 85668, 11768, to_date('13-04-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (413, 'James', 'Reynolds', 202, 89848, 18927, to_date('07-04-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (414, 'Rebecca', 'Diggs', 133, 97099, 19487, to_date('17-01-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (415, 'Lois', 'Wilder', 344, 51270, 8249, to_date('16-12-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (416, 'Andrew', 'Garfunkel', 258, 34857, 16555, to_date('13-07-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (417, 'Franco', 'Bracco', 336, 48489, 19850, to_date('27-02-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (419, 'Hilton', 'Caviezel', 111, 27451, 12523, to_date('21-05-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (420, 'Harry', 'Garcia', 13, 95870, 16039, to_date('25-11-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (421, 'Heath', 'DeGraw', 242, 93935, 11922, to_date('18-10-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (423, 'Benjamin', 'Levy', 294, 10760, 19105, to_date('26-02-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (424, 'Rhona', 'Horizon', 367, 83893, 19318, to_date('18-03-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (426, 'Laurence', 'Faithfull', 231, 80807, 8972, to_date('08-02-1998', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (427, 'Louise', 'Williamson', 376, 53025, 14665, to_date('27-12-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (428, 'Will', 'Holbrook', 170, 14373, 19743, to_date('22-12-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (429, 'Eddie', 'Weller', 178, 25538, 13433, to_date('21-05-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (430, 'Ozzy', 'Molina', 134, 11099, 9093, to_date('18-11-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (431, 'Giovanni', 'Vince', 1, 93580, 19628, to_date('10-06-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (434, 'Tanya', 'Quinones', 165, 49904, 18804, to_date('13-03-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (435, 'Laurence', 'Capshaw', 19, 68426, 16942, to_date('03-01-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (436, 'Jim', 'Mandrell', 159, 62349, 13765, to_date('30-11-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (437, 'Patti', 'Hynde', 58, 75563, 13668, to_date('25-07-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (439, 'Glen', 'Gibson', 79, 70013, 10610, to_date('11-05-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (440, 'Cate', 'Flack', 132, 86537, 17016, to_date('13-04-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (441, 'Gates', 'Manning', 347, 62710, 19409, to_date('02-01-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (442, 'Hugh', 'Wheel', 363, 34106, 10161, to_date('02-04-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (444, 'Lydia', 'Vaughan', 337, 48324, 13894, to_date('30-11-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (445, 'Gordie', 'Lonsdale', 330, 73595, 13956, to_date('19-07-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (446, 'Cherry', 'Playboys', 263, 43360, 12489, to_date('12-10-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (447, 'Rickie', 'Pleasure', 49, 98554, 11656, to_date('21-04-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (448, 'Alice', 'Morton', 113, 24229, 12215, to_date('25-09-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (449, 'Cary', 'Torres', 25, 57925, 13026, to_date('14-06-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (451, 'Gavin', 'Swank', 12, 89479, 15498, to_date('08-01-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (455, 'Dermot', 'Cole', 160, 79036, 13923, to_date('18-02-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (458, 'Crispin', 'Secada', 125, 26891, 17250, to_date('28-09-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (459, 'Eddie', 'Skaggs', 217, 70580, 15285, to_date('23-02-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (460, 'Meredith', 'Williamson', 212, 53895, 8635, to_date('01-09-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (462, 'Kasey', 'Stormare', 293, 40743, 19084, to_date('28-04-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (463, 'Burton', 'Garber', 17, 85756, 16880, to_date('21-10-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (464, 'Percy', 'Cleary', 71, 39431, 8553, to_date('19-09-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (465, 'Orlando', 'Pride', 228, 62012, 15164, to_date('13-02-1993', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (466, 'Rhett', 'Holiday', 320, 50187, 11663, to_date('28-08-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (467, 'Frances', 'Humphrey', 361, 48654, 11720, to_date('12-03-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (468, 'Emm', 'Griggs', 217, 40436, 16088, to_date('14-06-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (469, 'Anthony', 'Weiss', 274, 17459, 18989, to_date('26-11-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (470, 'Cevin', 'Suchet', 289, 66511, 17444, to_date('02-08-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (471, 'Roy', 'McGriff', 4, 80598, 17055, to_date('30-12-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (472, 'April', 'Redgrave', 71, 32647, 12370, to_date('08-08-1964', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (473, 'Isaiah', 'Van Der Beek', 398, 32929, 12257, to_date('25-04-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (475, 'Maria', 'Folds', 354, 35553, 16643, to_date('28-10-1957', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (477, 'Karen', 'Ford', 36, 96401, 17447, to_date('24-11-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (478, 'Terri', 'Yulin', 231, 20267, 11720, to_date('14-05-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (479, 'Robert', 'King', 312, 76160, 8781, to_date('25-09-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (480, 'Fred', 'Supernaw', 393, 79518, 17368, to_date('04-12-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (482, 'Ellen', 'Hanley', 204, 18226, 8177, to_date('12-04-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (483, 'Steven', 'Tomlin', 22, 40400, 16074, to_date('30-10-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (484, 'Nelly', 'King', 95, 35103, 12391, to_date('06-09-1979', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (485, 'Davy', 'Murphy', 283, 10886, 11667, to_date('25-12-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (486, 'Rich', 'Duschel', 348, 39005, 11681, to_date('12-12-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (488, 'Cate', 'Briscoe', 324, 89250, 16452, to_date('15-03-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (489, 'Swoosie', 'Spall', 330, 28518, 8513, to_date('02-12-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (490, 'Walter', 'Farris', 60, 86491, 13501, to_date('11-09-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (491, 'Joan', 'Posener', 135, 52723, 18969, to_date('22-10-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (492, 'Ron', 'Watley', 349, 93670, 9744, to_date('30-10-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (494, 'Earl', 'Kattan', 312, 79105, 14683, to_date('19-01-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (495, 'Norm', 'Keitel', 224, 92145, 9780, to_date('29-05-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (496, 'Mitchell', 'Playboys', 350, 56214, 11308, to_date('25-10-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (497, 'Penelope', 'Brando', 79, 41075, 13475, to_date('11-03-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (498, 'Collective', 'Crewson', 107, 86929, 16126, to_date('09-03-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (499, 'Frances', 'Molina', 229, 25573, 9964, to_date('02-10-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (500, 'Vincent', 'Lewin', 333, 88319, 19989, to_date('02-05-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (501, 'Giancarlo', 'Cassel', 68, 66245, 14991, to_date('23-05-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (502, 'Tom', 'Taha', 55, 34458, 12423, to_date('01-07-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (504, 'Debi', 'Oldman', 173, 88071, 19148, to_date('18-08-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (506, 'Charlie', 'Branch', 272, 38982, 13449, to_date('02-05-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (507, 'Coley', 'Cooper', 35, 38651, 10133, to_date('10-09-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (508, 'Jodie', 'Portman', 370, 58902, 9129, to_date('15-04-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (509, 'Ani', 'Blanchett', 83, 26519, 13567, to_date('27-06-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (510, 'Bo', 'Coward', 203, 34588, 9690, to_date('19-10-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (600, 'Kalvin', 'Kleine', 1, 55121, 1358, to_date('04-01-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (601, 'Rickie', 'Stembridge', 2, 12927, 1504, to_date('23-09-1974', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (602, 'Delora', 'De Paoli', 3, 38602, 1764, to_date('22-02-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (603, 'Malvina', 'Bouts', 4, 35225, 1759, to_date('12-05-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (604, 'Tracie', 'Hopkyns', 5, 39920, 1227, to_date('04-05-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (605, 'Maitilde', 'Renoden', 6, 75971, 917, to_date('24-12-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (606, 'Ainsley', 'Merrydew', 7, 30226, 1880, to_date('04-06-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (607, 'Darrell', 'Lawles', 8, 27046, 870, to_date('09-12-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (608, 'Steward', 'Rubra', 9, 65288, 1959, to_date('25-08-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (609, 'Patrica', 'Morshead', 10, 48871, 1860, to_date('13-12-1961', 'dd-mm-yyyy'));
commit;
prompt 448 records loaded
prompt Loading WORKSHOPS...
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (1, 'Zumba', 167, 2, 12);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (2, 'Cooking', 237, 1, 34);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (3, 'Drawing', 351, 1, 10);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (4, 'Baking', 369, 1, 29);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (5, 'Ballet', 370, 4, 27);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (6, 'Judo', 188, 2, 19);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (7, 'Photography', 280, 1, 20);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (8, 'Piano', 304, 3, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (9, 'Violin', 151, 4, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (10, 'Sewing', 377, 4, 22);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (11, 'Guitar', 200, 2, 3);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (12, 'Swimming', 100, 3, 15);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (13, 'Gardening', 250, 1, 10);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity)
values (14, 'Singing', 150, 5, 2);
commit;
prompt 14 records loaded
prompt Loading SCHEDULER...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 5, 1, 1, 1, 2, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 2, 2, 2, 9, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 7, 3, 3, 3, 2, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 1, 4, 4, 4, 7, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 5, 5, 5, 7, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 6, 6, 6, 3, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 2, 7, 7, 7, 3, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 5, 8, 8, 8, 3, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 9, 9, 9, 8, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 2, 10, 10, 10, 10, 8);
commit;
prompt 10 records loaded
prompt Loading TEACH...
insert into TEACH (workshop_id, teacher_id)
values (1, 1);
insert into TEACH (workshop_id, teacher_id)
values (2, 2);
insert into TEACH (workshop_id, teacher_id)
values (3, 3);
insert into TEACH (workshop_id, teacher_id)
values (4, 4);
insert into TEACH (workshop_id, teacher_id)
values (5, 5);
insert into TEACH (workshop_id, teacher_id)
values (6, 6);
insert into TEACH (workshop_id, teacher_id)
values (7, 7);
insert into TEACH (workshop_id, teacher_id)
values (8, 8);
insert into TEACH (workshop_id, teacher_id)
values (9, 9);
insert into TEACH (workshop_id, teacher_id)
values (10, 10);
insert into TEACH (workshop_id, teacher_id)
values (11, 600);
insert into TEACH (workshop_id, teacher_id)
values (12, 601);
insert into TEACH (workshop_id, teacher_id)
values (12, 609);
insert into TEACH (workshop_id, teacher_id)
values (13, 609);
insert into TEACH (workshop_id, teacher_id)
values (14, 602);
commit;
prompt 15 records loaded
prompt Enabling foreign key constraints for CLIENTS...
alter table CLIENTS enable constraint SYS_C007462;
prompt Enabling foreign key constraints for GROUPS_...
alter table GROUPS_ enable constraint SYS_C007467;
prompt Enabling foreign key constraints for PARTICIPATE...
alter table PARTICIPATE enable constraint SYS_C007483;
alter table PARTICIPATE enable constraint SYS_C007484;
prompt Enabling foreign key constraints for TEACHERS...
alter table TEACHERS enable constraint SYS_C007465;
prompt Enabling foreign key constraints for SCHEDULER...
alter table SCHEDULER enable constraint SYS_C007475;
alter table SCHEDULER enable constraint SYS_C007476;
alter table SCHEDULER enable constraint SYS_C007477;
alter table SCHEDULER enable constraint SYS_C007478;
prompt Enabling foreign key constraints for TEACH...
alter table TEACH enable constraint SYS_C007480;
alter table TEACH enable constraint SYS_C007481;
prompt Enabling triggers for AGE_GROUP...
alter table AGE_GROUP enable all triggers;
prompt Enabling triggers for CITY...
alter table CITY enable all triggers;
prompt Enabling triggers for CLIENTS...
alter table CLIENTS enable all triggers;
prompt Enabling triggers for GROUPS_...
alter table GROUPS_ enable all triggers;
prompt Enabling triggers for PARTICIPATE...
alter table PARTICIPATE enable all triggers;
prompt Enabling triggers for ROOMS...
alter table ROOMS enable all triggers;
prompt Enabling triggers for TEACHERS...
alter table TEACHERS enable all triggers;
prompt Enabling triggers for WORKSHOPS...
alter table WORKSHOPS enable all triggers;
prompt Enabling triggers for SCHEDULER...
alter table SCHEDULER enable all triggers;
prompt Enabling triggers for TEACH...
alter table TEACH enable all triggers;
set feedback on
set define on
prompt Done.
