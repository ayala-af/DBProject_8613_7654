prompt PL/SQL Developer import file
prompt Created on Thursday, July 4, 2024 by Naama
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AGE_GROUP
  add primary key (AGE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CITY...
create table CITY
(
  city_num  NUMBER(5) not null,
  city_name VARCHAR2(15)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CITY
  add primary key (CITY_NUM)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CITY
  add unique (CITY_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CLIENTS...
create table CLIENTS
(
  client_id      NUMBER(5) not null,
  client_fname   VARCHAR2(15),
  client_lname   VARCHAR2(15),
  client_addr    NUMBER(5),
  client_tel     NUMBER(5) not null,
  client_payment NUMBER(5),
  birthday       DATE
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLIENTS
  add primary key (CLIENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GROUPS_
  add primary key (GROUP_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GROUPS_
  add foreign key (AGE_ID)
  references AGE_GROUP (AGE_ID);

prompt Creating PARTICIPATE...
create table PARTICIPATE
(
  group_id  NUMBER(5) not null,
  client_id NUMBER(5) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PARTICIPATE
  add primary key (GROUP_ID, CLIENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ROOMS
  add primary key (ROOM_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ROOMS
  add constraint BOOLEAN_ISSTUDIO
  check (isStudio IN ('T', 'F'));
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
  teacher_salary    NUMBER(5) default 0,
  teacher_join_date DATE
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TEACHERS
  add primary key (TEACHER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table WORKSHOPS
  add primary key (WORKSHOP_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCHEDULER
  add unique (SC_DAY, SC_TIME, ROOM_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCHEDULER
  add unique (SC_DAY, SC_TIME, TEACHER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TEACH
  add primary key (WORKSHOP_ID, TEACHER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
alter table CLIENTS disable constraint SYS_C007620;
prompt Disabling foreign key constraints for GROUPS_...
alter table GROUPS_ disable constraint SYS_C007623;
prompt Disabling foreign key constraints for PARTICIPATE...
alter table PARTICIPATE disable constraint SYS_C007627;
alter table PARTICIPATE disable constraint SYS_C007628;
prompt Disabling foreign key constraints for TEACHERS...
alter table TEACHERS disable constraint SYS_C007635;
prompt Disabling foreign key constraints for SCHEDULER...
alter table SCHEDULER disable constraint SYS_C007641;
alter table SCHEDULER disable constraint SYS_C007642;
alter table SCHEDULER disable constraint SYS_C007643;
alter table SCHEDULER disable constraint SYS_C007644;
prompt Disabling foreign key constraints for TEACH...
alter table TEACH disable constraint SYS_C007650;
alter table TEACH disable constraint SYS_C007651;
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
insert into CITY (city_num, city_name)
values (108, 'Peine');
commit;
prompt 100 records committed...
insert into CITY (city_num, city_name)
values (109, 'Pomona');
insert into CITY (city_num, city_name)
values (110, 'Brookfield');
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
insert into CITY (city_num, city_name)
values (222, 'Cobham');
insert into CITY (city_num, city_name)
values (223, 'Juneau');
insert into CITY (city_num, city_name)
values (224, 'Harsum');
insert into CITY (city_num, city_name)
values (226, 'Schenectady');
commit;
prompt 200 records committed...
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
commit;
prompt 300 records committed...
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
commit;
prompt 400 records committed...
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
prompt 405 records loaded
prompt Loading CLIENTS...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1, 'Andre', 'Burton', 1, 91284, 0, to_date('10-02-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (2, 'Glen', 'Meyer', 2, 69755, 0, to_date('23-02-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (3, 'Davis', 'Posener', 3, 16955, 0, to_date('11-01-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (4, 'Fairuza', 'Gibbons', 4, 69060, 0, to_date('16-02-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (5, 'Jackie', 'Vance', 5, 87283, 0, to_date('31-08-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (6, 'Chad', 'Sawa', 6, 36592, 0, to_date('11-12-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (7, 'Natasha', 'Cassidy', 7, 61826, 0, to_date('30-09-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (8, 'Kyra', 'Worrell', 8, 10109, 0, to_date('13-11-1989', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (9, 'Raul', 'Mazzello', 9, 23367, 151, to_date('27-02-1988', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (10, 'Wade', 'Clinton', 10, 88313, 521, to_date('24-05-1992', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (11, 'Seann', 'Pleasure', 383, 23724, 0, to_date('18-03-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (13, 'Tzi', 'Dickinson', 178, 14932, 0, to_date('14-04-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (14, 'Dick', 'Andrews', 325, 78976, 0, to_date('02-08-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (15, 'Mae', 'Mohr', 295, 19379, 0, to_date('16-09-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (16, 'Vin', 'Lipnicki', 146, 95435, 0, to_date('20-03-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (17, 'Dennis', 'Chambers', 371, 13246, 0, to_date('18-09-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (18, 'Amanda', 'Galecki', 253, 73631, 0, to_date('17-04-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (19, 'Nik', 'Peet', 26, 55925, 0, to_date('22-02-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (20, 'Warren', 'Rodgers', 272, 97220, 0, to_date('19-06-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (21, 'Jonny Lee', 'Peet', 296, 21980, 0, to_date('29-05-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (22, 'Allan', 'Heron', 32, 38091, 0, to_date('02-07-1988', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (23, 'Anjelica', 'Flatts', 372, 77805, 0, to_date('29-11-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (24, 'Jose', 'Fiennes', 39, 56454, 0, to_date('29-10-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (25, 'Kazem', 'Kudrow', 397, 53761, 0, to_date('01-10-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (26, 'Christian', 'Craig', 182, 92722, 0, to_date('01-11-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (27, 'Ray', 'O''Keefe', 379, 25072, 0, to_date('10-10-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (28, 'Mitchell', 'Phifer', 368, 90739, 0, to_date('20-09-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (29, 'Kelly', 'Cheadle', 170, 27265, 0, to_date('02-05-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (31, 'Christine', 'Pacino', 377, 94427, 0, to_date('19-04-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (32, 'Trick', 'Bonham', 37, 92020, 0, to_date('28-01-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (33, 'Jeroen', 'Krieger', 155, 31070, 0, to_date('07-03-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (34, 'Andie', 'Bloch', 162, 36013, 0, to_date('21-12-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (35, 'Charlie', 'Willis', 335, 60877, 0, to_date('20-05-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (36, 'Mia', 'Grant', 292, 56531, 0, to_date('04-06-2005', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (37, 'Emilio', 'Saucedo', 58, 98120, 0, to_date('13-01-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (38, 'Phil', 'Shorter', 306, 31971, 0, to_date('03-11-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (39, 'Peabo', 'Waits', 347, 90018, 0, to_date('24-10-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (40, 'Gene', 'Cobbs', 183, 60360, 0, to_date('17-07-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (41, 'Burt', 'Colon', 198, 30829, 0, to_date('27-09-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (43, 'Emma', 'Schwimmer', 32, 70950, 0, to_date('28-11-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (44, 'Cuba', 'Dean', 232, 60641, 0, to_date('04-09-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (45, 'William', 'Starr', 269, 86805, 0, to_date('09-08-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (46, 'Paula', 'Moreno', 232, 91908, 0, to_date('31-07-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (47, 'Jeremy', 'Shatner', 74, 79810, 0, to_date('18-03-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (48, 'Taye', 'Himmelman', 16, 62370, 0, to_date('20-04-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (49, 'Maury', 'Richards', 243, 95190, 0, to_date('06-12-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (50, 'Rutger', 'Gooding', 137, 37426, 0, to_date('06-05-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (52, 'Nicholas', 'Devine', 85, 20844, 0, to_date('22-06-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (53, 'Thin', 'Suvari', 183, 63641, 0, to_date('12-07-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (54, 'Liev', 'Def', 382, 20224, 0, to_date('06-09-1989', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (55, 'Sonny', 'Schreiber', 131, 56626, 0, to_date('08-05-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (56, 'Robert', 'Aykroyd', 195, 19734, 0, to_date('24-09-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (58, 'Noah', 'Witt', 65, 47156, 0, to_date('28-09-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (59, 'Sophie', 'Rankin', 355, 52604, 0, to_date('25-07-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (62, 'Millie', 'Carradine', 260, 36093, 0, to_date('04-09-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (63, 'Nathan', 'Langella', 94, 64000, 0, to_date('18-07-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (66, 'Geoffrey', 'Puckett', 364, 30551, 0, to_date('12-09-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (67, 'Max', 'Buffalo', 293, 17035, 0, to_date('14-08-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (69, 'Fairuza', 'Malone', 166, 82076, 0, to_date('27-05-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (70, 'Johnny', 'Pride', 382, 59947, 0, to_date('14-09-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (72, 'Sophie', 'Venora', 379, 19970, 0, to_date('08-08-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (73, 'Frank', 'Hauer', 97, 90421, 0, to_date('07-04-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (74, 'Crispin', 'Stamp', 318, 95472, 0, to_date('15-06-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (75, 'Sona', 'Cole', 243, 87687, 0, to_date('24-01-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (76, 'Ty', 'Foley', 218, 62302, 0, to_date('09-11-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (77, 'Curt', 'Scott', 391, 32722, 0, to_date('26-03-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (78, 'Tracy', 'Cantrell', 307, 11604, 0, to_date('26-04-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (79, 'Kelli', 'Rispoli', 29, 46876, 0, to_date('17-04-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (81, 'Faye', 'Foster', 14, 93949, 0, to_date('11-02-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (82, 'Marlon', 'Rudd', 264, 93226, 0, to_date('03-08-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (83, 'Rosanne', 'Theron', 330, 68548, 0, to_date('10-10-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (84, 'Mandy', 'Puckett', 114, 13562, 0, to_date('15-06-1967', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (85, 'Harvey', 'Slater', 283, 25863, 0, to_date('23-10-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (86, 'Chrissie', 'Willard', 258, 18391, 0, to_date('01-05-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (87, 'Joey', 'Stevens', 204, 31138, 0, to_date('02-06-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (88, 'Joy', 'Orbit', 174, 69124, 0, to_date('24-05-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (91, 'Jarvis', 'Weiss', 71, 70257, 0, to_date('21-02-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (92, 'Corey', 'Cronin', 298, 70088, 0, to_date('30-08-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (93, 'Hex', 'Mattea', 367, 68976, 0, to_date('27-05-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (94, 'Solomon', 'Dunn', 344, 83271, 0, to_date('29-07-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (95, 'Rolando', 'Gere', 347, 29725, 0, to_date('05-05-1973', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (96, 'Aaron', 'Stanton', 143, 84975, 0, to_date('31-10-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (97, 'Hookah', 'Walken', 91, 44165, 0, to_date('20-10-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (98, 'Whoopi', 'Callow', 86, 68447, 0, to_date('03-11-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (99, 'Jessica', 'Badalucco', 201, 43229, 0, to_date('23-05-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (100, 'Jeffrey', 'Idol', 241, 30651, 0, to_date('26-12-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (101, 'Deborah', 'Cazale', 392, 16345, 0, to_date('21-07-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (103, 'Donald', 'Winstone', 36, 86612, 0, to_date('19-03-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (104, 'Junior', 'Ruiz', 147, 97903, 0, to_date('08-05-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (105, 'Ed', 'Redgrave', 206, 32704, 0, to_date('26-10-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (106, 'Randall', 'Epps', 120, 68888, 0, to_date('25-01-1989', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (107, 'Kathleen', 'Cale', 97, 30780, 0, to_date('27-11-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (108, 'Busta', 'Flanery', 95, 12624, 0, to_date('12-07-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (109, 'Horace', 'Crimson', 357, 92186, 0, to_date('02-06-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (110, 'Joy', 'Postlethwaite', 167, 36082, 0, to_date('11-04-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (111, 'Sammy', 'Marshall', 3, 15237, 0, to_date('20-06-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (112, 'Vin', 'Uggams', 190, 12632, 0, to_date('09-04-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (113, 'Nicole', 'Creek', 60, 71837, 0, to_date('17-04-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (114, 'Tobey', 'Gore', 112, 14362, 0, to_date('15-07-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (117, 'Vivica', 'DiBiasio', 333, 63773, 0, to_date('24-01-2014', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (119, 'Ceili', 'Coe', 361, 11624, 0, to_date('06-03-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (120, 'Raul', 'Mitchell', 397, 49674, 0, to_date('27-09-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (121, 'Walter', 'Crewson', 347, 42785, 0, to_date('15-08-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (122, 'Gran', 'Mann', 33, 65288, 0, to_date('27-08-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (123, 'Tea', 'Sainte-Marie', 58, 46126, 0, to_date('13-11-1995', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (124, 'Gord', 'Wilder', 114, 22064, 0, to_date('15-07-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (125, 'Mia', 'Tucci', 292, 34558, 0, to_date('15-10-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (126, 'Johnette', 'Coward', 207, 95179, 0, to_date('10-01-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (127, 'Clive', 'Jackson', 29, 97510, 0, to_date('02-05-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (128, 'Davis', 'Tarantino', 240, 53459, 0, to_date('11-07-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (129, 'Willie', 'Weiss', 372, 64517, 0, to_date('25-01-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (130, 'Chely', 'Caldwell', 256, 24280, 0, to_date('12-01-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (131, 'Hilary', 'Salt', 116, 23179, 0, to_date('17-08-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (133, 'Rowan', 'Garr', 326, 67303, 0, to_date('04-06-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (134, 'Machine', 'Khan', 125, 90922, 0, to_date('11-09-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (135, 'Marc', 'Wolf', 154, 13473, 0, to_date('06-03-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (136, 'Brent', 'Donovan', 157, 60458, 0, to_date('02-11-1967', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (137, 'Hex', 'Fraser', 274, 26868, 0, to_date('13-02-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (139, 'Emilio', 'Driver', 375, 59574, 0, to_date('30-11-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (140, 'Alana', 'Ruffalo', 196, 18219, 0, to_date('12-04-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (142, 'Don', 'Stoltz', 326, 25861, 0, to_date('06-03-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (145, 'Loreena', 'Badalucco', 57, 23668, 0, to_date('01-10-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (146, 'Leslie', 'Belles', 60, 46663, 0, to_date('10-12-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (147, 'Jonatha', 'Kleinenberg', 400, 50003, 0, to_date('17-07-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (148, 'Percy', 'Malone', 365, 47724, 0, to_date('28-02-1961', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (149, 'Bonnie', 'Yankovic', 173, 84997, 0, to_date('07-05-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (150, 'Loreena', 'MacDowell', 48, 89901, 0, to_date('31-05-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (151, 'Juice', 'Neil', 71, 30867, 0, to_date('17-12-1989', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (152, 'Debbie', 'Lynn', 188, 98933, 0, to_date('11-12-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (153, 'Seann', 'Burmester', 208, 65866, 0, to_date('05-10-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (154, 'Janice', 'Crosby', 224, 69397, 0, to_date('14-01-1967', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (156, 'Mary', 'Melvin', 310, 68555, 0, to_date('14-11-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (157, 'Wayman', 'Matarazzo', 17, 20127, 0, to_date('26-10-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (158, 'Udo', 'Lachey', 217, 33583, 0, to_date('15-11-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (159, 'Naomi', 'Fogerty', 134, 35765, 0, to_date('29-05-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (160, 'Madeline', 'De Niro', 262, 66681, 0, to_date('28-08-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (163, 'Kenny', 'Nunn', 196, 43107, 0, to_date('30-06-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (164, 'Graham', 'Lineback', 68, 65813, 0, to_date('06-06-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (165, 'Candice', 'Costner', 55, 63826, 0, to_date('12-03-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (166, 'Jean', 'Griggs', 274, 96207, 0, to_date('24-05-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (167, 'Tcheky', 'Wills', 48, 93920, 0, to_date('03-03-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (168, 'Ruth', 'Cagle', 384, 56434, 0, to_date('14-05-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (169, 'Gin', 'Idle', 152, 84601, 0, to_date('16-02-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (170, 'Maggie', 'Harrelson', 253, 89345, 0, to_date('08-02-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (172, 'Cyndi', 'Mandrell', 157, 28197, 0, to_date('11-12-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (173, 'Eugene', 'Viterelli', 375, 92263, 0, to_date('12-09-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (174, 'Hope', 'Faithfull', 202, 43957, 0, to_date('31-12-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (175, 'Merrilee', 'Kramer', 286, 86972, 0, to_date('25-05-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (176, 'Mel', 'Garza', 222, 46743, 0, to_date('30-08-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (177, 'Taylor', 'Pride', 179, 56757, 0, to_date('02-01-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (178, 'LeVar', 'Carnes', 187, 98460, 0, to_date('21-10-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (179, 'Joshua', 'Cube', 326, 39283, 0, to_date('11-02-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (180, 'Joy', 'Himmelman', 5, 66140, 0, to_date('06-06-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (181, 'Greg', 'Eastwood', 138, 19664, 0, to_date('20-12-2005', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (182, 'Bebe', 'Osbourne', 145, 98029, 0, to_date('02-09-2004', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (183, 'Giovanni', 'Kingsley', 103, 54151, 0, to_date('04-05-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (184, 'Madeleine', 'Graham', 168, 16950, 0, to_date('09-06-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (185, 'Harrison', 'Black', 291, 31799, 0, to_date('09-12-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (186, 'Harrison', 'Beckham', 390, 67974, 0, to_date('18-01-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (188, 'Collin', 'Baldwin', 371, 79924, 0, to_date('19-08-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (189, 'Garland', 'Eat World', 207, 51436, 0, to_date('15-05-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (190, 'Bridget', 'Allan', 38, 62751, 0, to_date('19-03-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (191, 'Judge', 'Parsons', 157, 85396, 0, to_date('11-09-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (192, 'Powers', 'Skaggs', 158, 65313, 0, to_date('23-09-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (193, 'Cuba', 'Hamilton', 385, 73149, 0, to_date('11-07-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (195, 'CeCe', 'Choice', 296, 31731, 0, to_date('30-05-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (196, 'Kurtwood', 'Kudrow', 173, 57812, 0, to_date('24-10-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (197, 'Glen', 'Yorn', 167, 37292, 0, to_date('22-04-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (198, 'Carlos', 'Portman', 30, 73713, 0, to_date('12-01-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (199, 'Mae', 'Dunst', 336, 34486, 0, to_date('22-11-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (200, 'Carlos', 'Hong', 98, 77129, 0, to_date('30-06-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (201, 'Arnold', 'Osborne', 191, 60094, 0, to_date('23-01-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (202, 'Lucinda', 'Olin', 190, 54296, 0, to_date('29-08-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (203, 'Alessandro', 'Pleasence', 232, 44153, 0, to_date('13-08-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (204, 'Julio', 'Pfeiffer', 113, 14171, 0, to_date('06-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (205, 'Stephen', 'Rickman', 152, 84379, 0, to_date('16-07-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (206, 'Fisher', 'Vai', 110, 85888, 0, to_date('14-12-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (207, 'Jack', 'Brody', 384, 42164, 0, to_date('03-06-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (208, 'Eric', 'Loggia', 291, 22864, 0, to_date('16-06-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (210, 'Denny', 'Benet', 270, 10582, 0, to_date('23-05-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (211, 'Bret', 'Oszajca', 289, 60058, 0, to_date('16-10-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (213, 'Mos', 'Kweller', 268, 90399, 0, to_date('27-06-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (214, 'Thomas', 'Farris', 131, 81761, 0, to_date('15-01-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (215, 'Roberta', 'Buffalo', 126, 69259, 0, to_date('21-02-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (216, 'Vendetta', 'Davison', 260, 76273, 0, to_date('24-11-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (217, 'Bebe', 'Roundtree', 397, 76024, 0, to_date('30-06-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (218, 'Garth', 'Palminteri', 37, 42476, 0, to_date('01-01-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (220, 'Judge', 'Keen', 281, 39031, 0, to_date('07-01-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (221, 'Simon', 'Zane', 24, 86735, 0, to_date('22-07-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (222, 'Todd', 'Sewell', 236, 99450, 0, to_date('28-05-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (223, 'Vondie', 'Mantegna', 91, 59812, 0, to_date('03-08-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (225, 'Earl', 'Beck', 268, 51058, 0, to_date('11-04-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (228, 'Jay', 'Oldman', 252, 69906, 0, to_date('01-12-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (230, 'Katie', 'Palin', 82, 80833, 0, to_date('07-01-1948', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (231, 'Jackie', 'Hewett', 137, 14206, 0, to_date('18-04-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (232, 'Marc', 'Jane', 272, 46343, 0, to_date('06-01-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (233, 'Morris', 'Slater', 40, 10036, 0, to_date('22-05-1995', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (235, 'Joe', 'Johansen', 275, 71128, 0, to_date('07-07-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (236, 'Victoria', 'Lindo', 299, 60251, 0, to_date('30-07-1961', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (237, 'Donald', 'Walken', 24, 23050, 0, to_date('02-06-1929', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (238, 'Marlon', 'Yankovic', 66, 79672, 0, to_date('10-07-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (239, 'Angela', 'Maguire', 78, 62282, 0, to_date('03-02-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (240, 'Nancy', 'Ifans', 90, 50094, 0, to_date('22-05-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (241, 'Ashton', 'Jones', 1, 98467, 0, to_date('15-04-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (242, 'Candice', 'McDonnell', 188, 96361, 0, to_date('11-03-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (243, 'Kelly', 'Rudd', 95, 74798, 0, to_date('14-05-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (245, 'Clarence', 'Gambon', 301, 92330, 0, to_date('19-09-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (247, 'Daniel', 'Dalton', 310, 86473, 0, to_date('10-06-1988', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (248, 'Leo', 'Lynne', 85, 31952, 0, to_date('31-03-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (249, 'Ozzy', 'Coughlan', 27, 86480, 0, to_date('07-01-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (250, 'Meg', 'Streep', 366, 86856, 0, to_date('22-06-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (251, 'Rowan', 'Emmett', 53, 41184, 0, to_date('06-02-1974', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (252, 'Curtis', 'Gallant', 125, 41237, 0, to_date('28-06-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (253, 'Benjamin', 'Wilson', 331, 16778, 0, to_date('05-10-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (255, 'Rita', 'Craig', 31, 64922, 0, to_date('22-09-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (256, 'Wayne', 'Beck', 257, 74003, 0, to_date('13-11-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (257, 'Mykelti', 'Neil', 203, 71949, 0, to_date('28-06-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (259, 'Garry', 'Holly', 84, 12456, 0, to_date('26-04-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (260, 'Lea', 'Lynch', 114, 68081, 0, to_date('07-04-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (261, 'Timothy', 'Tate', 391, 63061, 0, to_date('11-07-1926', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (262, 'Miki', 'Murphy', 23, 17459, 0, to_date('03-01-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (263, 'Ewan', 'Danes', 270, 54611, 0, to_date('29-07-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (264, 'Daryl', 'Quinlan', 379, 90374, 0, to_date('26-12-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (265, 'Meg', 'Bacon', 250, 13616, 0, to_date('26-10-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (266, 'Hal', 'Blackwell', 175, 37171, 0, to_date('18-01-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (267, 'Andie', 'DiFranco', 68, 56187, 0, to_date('04-01-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (268, 'Teena', 'McGowan', 248, 93049, 0, to_date('21-06-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (269, 'Joey', 'Smurfit', 306, 80278, 0, to_date('06-11-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (271, 'Richie', 'Dench', 113, 84486, 0, to_date('02-03-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (272, 'Leelee', 'Niven', 19, 35356, 0, to_date('27-07-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (274, 'Alessandro', 'Pierce', 320, 61625, 0, to_date('23-12-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (276, 'Loren', 'Albright', 3, 11065, 0, to_date('21-05-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (277, 'Debby', 'Peniston', 73, 23084, 0, to_date('18-09-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (278, 'Rolando', 'Gryner', 35, 93113, 0, to_date('02-07-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (279, 'Carol', 'Randal', 123, 48578, 0, to_date('26-07-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (280, 'Treat', 'Woodard', 166, 21535, 0, to_date('30-08-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (282, 'Terry', 'Pesci', 282, 47571, 0, to_date('08-04-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (284, 'Elizabeth', 'Fox', 88, 24405, 0, to_date('03-10-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (285, 'Mary', 'Perlman', 91, 24816, 0, to_date('06-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (286, 'Ty', 'Tisdale', 130, 65013, 0, to_date('18-12-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (287, 'Sigourney', 'Blaine', 170, 49134, 0, to_date('29-12-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (288, 'Juliette', 'Snipes', 55, 77909, 0, to_date('04-03-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (289, 'Ronny', 'Tinsley', 115, 51886, 0, to_date('29-07-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (290, 'Famke', 'Tyson', 122, 77819, 0, to_date('03-04-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (291, 'Philip', 'Kristofferson', 386, 64497, 0, to_date('25-05-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (292, 'Meryl', 'Tah', 69, 40822, 0, to_date('16-08-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (293, 'Ann', 'Shandling', 179, 20617, 0, to_date('04-10-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (295, 'Jody', 'Reeves', 55, 19736, 0, to_date('09-03-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (296, 'Bette', 'Bentley', 390, 88020, 0, to_date('14-09-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (297, 'Lou', 'Martinez', 272, 82524, 0, to_date('27-04-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (298, 'Heath', 'Finn', 29, 18004, 0, to_date('10-07-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (299, 'Boyd', 'Van Helden', 94, 91177, 0, to_date('30-10-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (300, 'Tcheky', 'Ramirez', 396, 61676, 0, to_date('07-02-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (302, 'Etta', 'Lang', 286, 17369, 0, to_date('26-08-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (303, 'Daryl', 'Reinhold', 131, 68432, 0, to_date('31-08-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (304, 'Shannon', 'Arkenstone', 173, 88075, 0, to_date('14-05-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (305, 'Warren', 'Kravitz', 132, 65482, 0, to_date('16-05-1973', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (306, 'Wally', 'Newman', 345, 84704, 0, to_date('26-09-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (307, 'Neve', 'Schreiber', 162, 48562, 0, to_date('16-08-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (308, 'Gin', 'Freeman', 28, 30054, 0, to_date('28-03-1926', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (309, 'John', 'Richardson', 324, 82787, 0, to_date('15-10-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (310, 'Kay', 'Buscemi', 135, 55516, 0, to_date('01-06-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (311, 'Humberto', 'Springfield', 334, 10856, 0, to_date('01-02-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (312, 'Susan', 'Keen', 326, 25071, 0, to_date('28-07-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (315, 'Maggie', 'Collie', 50, 72250, 0, to_date('26-09-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (316, 'Swoosie', 'Haggard', 55, 38894, 0, to_date('11-10-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (317, 'Jose', 'Swayze', 366, 46600, 0, to_date('09-12-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (318, 'Jake', 'McGriff', 258, 29912, 0, to_date('12-04-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (319, 'Gavin', 'Ward', 4, 73355, 0, to_date('14-07-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (320, 'Michelle', 'Fox', 115, 54922, 0, to_date('12-11-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (321, 'Eileen', 'Spector', 29, 19434, 0, to_date('09-03-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (322, 'Crystal', 'Pepper', 78, 57462, 0, to_date('17-12-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (323, 'Howard', 'Schock', 335, 25119, 0, to_date('13-09-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (324, 'Orlando', 'Pigott-Smith', 128, 89117, 0, to_date('04-01-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (325, 'Max', 'Harper', 102, 35624, 0, to_date('26-07-1995', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (326, 'Sander', 'Hannah', 33, 21303, 0, to_date('29-11-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (327, 'Harriet', 'Frakes', 110, 66114, 0, to_date('27-10-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (328, 'Marley', 'Kimball', 379, 30582, 0, to_date('22-09-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (329, 'Jimmie', 'Arkin', 56, 70949, 0, to_date('12-02-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (331, 'Eddie', 'McGoohan', 135, 20443, 0, to_date('16-12-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (332, 'Ralph', 'Allison', 78, 27744, 0, to_date('25-07-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (333, 'Vickie', 'Keith', 247, 90910, 0, to_date('25-07-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (334, 'Clint', 'McKennitt', 282, 19817, 0, to_date('27-05-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (336, 'Rosie', 'Ness', 351, 70174, 0, to_date('23-05-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (338, 'Famke', 'Tilly', 40, 96430, 0, to_date('25-09-1953', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (339, 'Beverley', 'Roth', 137, 45025, 0, to_date('25-02-2017', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (340, 'Fiona', 'Phillippe', 348, 26026, 0, to_date('24-03-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (341, 'Remy', 'Walsh', 290, 44067, 0, to_date('01-07-1967', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (343, 'Caroline', 'Ammons', 214, 51091, 0, to_date('31-10-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (344, 'Jennifer', 'Cartlidge', 86, 45108, 0, to_date('27-08-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (345, 'Christine', 'Speaks', 161, 32130, 0, to_date('19-01-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (346, 'Bonnie', 'Osbourne', 187, 26321, 0, to_date('16-05-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (347, 'Joaquin', 'Forrest', 23, 32315, 0, to_date('17-06-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (348, 'Katie', 'Perez', 11, 67568, 0, to_date('05-10-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (349, 'Rolando', 'Linney', 320, 40384, 0, to_date('29-11-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (350, 'Cate', 'Holeman', 27, 74413, 0, to_date('03-05-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (351, 'Lindsey', 'Serbedzija', 326, 40994, 0, to_date('21-09-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (352, 'Faye', 'Parish', 84, 58213, 0, to_date('08-09-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (353, 'Stephen', 'Ribisi', 71, 25657, 0, to_date('21-03-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (354, 'Rosanne', 'Campbell', 182, 67104, 0, to_date('15-02-1961', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (356, 'Andie', 'Diesel', 399, 66452, 0, to_date('13-09-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (357, 'Dave', 'Bush', 47, 71958, 0, to_date('19-08-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (358, 'Ethan', 'Cummings', 185, 90804, 0, to_date('23-05-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (359, 'Paula', 'Kirshner', 356, 12777, 0, to_date('10-06-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (360, 'Julie', 'Douglas', 116, 21858, 0, to_date('06-11-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (361, 'Holland', 'Danger', 52, 35581, 0, to_date('31-08-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (362, 'Beverley', 'Warwick', 129, 79488, 0, to_date('23-12-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (363, 'Jackson', 'McCann', 71, 70832, 0, to_date('15-08-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (365, 'Meg', 'Choice', 232, 50819, 0, to_date('06-02-1976', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (366, 'Lara', 'Keen', 191, 91188, 0, to_date('01-03-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (367, 'Guy', 'Beck', 398, 52688, 0, to_date('18-03-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (368, 'Thora', 'Stiles', 49, 46077, 0, to_date('04-07-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (369, 'Julianna', 'Tyler', 372, 96318, 0, to_date('26-06-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (370, 'Kim', 'Darren', 85, 50132, 0, to_date('22-06-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (371, 'Josh', 'Leary', 182, 20337, 0, to_date('02-04-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (372, 'Gavin', 'Lithgow', 123, 43719, 0, to_date('01-10-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (374, 'Jack', 'Caine', 37, 34493, 0, to_date('17-01-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (375, 'Maury', 'Sweeney', 330, 89566, 0, to_date('15-11-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (376, 'Shelby', 'Hiatt', 269, 16697, 0, to_date('01-11-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (377, 'Luke', 'Malkovich', 88, 46905, 0, to_date('10-05-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (378, 'Jessica', 'Colon', 84, 29768, 0, to_date('24-07-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (379, 'Connie', 'Salt', 119, 55363, 0, to_date('09-03-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (380, 'Rhett', 'Postlethwaite', 40, 25787, 167, to_date('27-02-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (382, 'Gran', 'Peet', 104, 47784, 0, to_date('25-09-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (383, 'Dwight', 'Van Der Beek', 30, 57960, 0, to_date('18-03-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (384, 'Kirk', 'Holmes', 110, 73459, 0, to_date('16-08-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (385, 'Raul', 'Capshaw', 66, 54119, 0, to_date('01-11-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (386, 'Giovanni', 'Birch', 162, 71323, 0, to_date('19-05-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (388, 'Azucar', 'Alston', 293, 28812, 0, to_date('18-03-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (389, 'Lance', 'Scorsese', 2, 25997, 0, to_date('23-11-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (390, 'Gaby', 'Caine', 389, 94383, 0, to_date('10-01-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (391, 'Kyle', 'Baranski', 10, 61259, 0, to_date('29-03-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (393, 'Rosanna', 'Def', 11, 55609, 0, to_date('06-09-2005', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (394, 'Juliana', 'Wilkinson', 382, 78048, 0, to_date('05-02-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (395, 'Milla', 'Klugh', 286, 41687, 0, to_date('21-04-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (396, 'Lili', 'Krabbe', 282, 41147, 0, to_date('17-07-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (397, 'Trey', 'Klugh', 78, 52292, 0, to_date('30-08-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (398, 'Edie', 'MacLachlan', 128, 92000, 0, to_date('27-08-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (399, 'Ice', 'Gandolfini', 35, 84813, 0, to_date('14-07-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (400, 'Sigourney', 'Fichtner', 65, 12708, 0, to_date('31-10-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (401, 'Frederic', 'Holbrook', 285, 13018, 0, to_date('24-02-1926', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (402, 'Joan', 'Matthau', 58, 11640, 0, to_date('16-09-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (403, 'Garland', 'Cheadle', 203, 49469, 0, to_date('19-12-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (404, 'Lennie', 'Hughes', 214, 60369, 0, to_date('12-06-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (405, 'Jeanne', 'Meniketti', 23, 44364, 0, to_date('27-04-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (406, 'Reese', 'Collins', 220, 30851, 0, to_date('30-01-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (407, 'Keith', 'Himmelman', 152, 69063, 0, to_date('17-07-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (408, 'Nicole', 'Warburton', 198, 77384, 0, to_date('15-04-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (409, 'Natascha', 'Karyo', 141, 75108, 0, to_date('01-05-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (411, 'Laurence', 'Gaines', 172, 41988, 0, to_date('06-07-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (412, 'Nanci', 'Channing', 327, 31412, 0, to_date('09-09-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (414, 'Marley', 'Allison', 55, 91791, 0, to_date('25-04-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (416, 'Murray', 'Donovan', 40, 18831, 0, to_date('04-12-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (417, 'Emily', 'Pony', 340, 20884, 0, to_date('08-06-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (418, 'Cuba', 'Nicholson', 247, 57202, 0, to_date('06-08-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (419, 'Jane', 'Everett', 131, 63174, 0, to_date('25-11-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (420, 'Lisa', 'Rippy', 120, 54685, 0, to_date('26-04-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (421, 'Marisa', 'Lillard', 56, 86618, 0, to_date('15-07-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (422, 'Edward', 'Rhames', 337, 44431, 0, to_date('22-09-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (423, 'Veruca', 'Blair', 392, 75593, 0, to_date('01-09-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (424, 'Cameron', 'Foley', 29, 48245, 0, to_date('12-11-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (425, 'Irene', 'Hart', 182, 52723, 0, to_date('18-02-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (426, 'Russell', 'Waits', 274, 97928, 0, to_date('27-04-2017', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (427, 'Heath', 'Cassidy', 60, 24856, 0, to_date('27-09-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (431, 'Neil', 'Hutch', 33, 52315, 0, to_date('30-10-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (432, 'Max', 'Rossellini', 95, 79490, 0, to_date('23-09-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (433, 'Ivan', 'Spine', 127, 59491, 0, to_date('05-11-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (434, 'Celia', 'Daniels', 37, 69285, 0, to_date('12-06-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (435, 'Fairuza', 'Buffalo', 207, 49892, 0, to_date('03-08-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (436, 'Gordie', 'Esposito', 379, 75712, 0, to_date('19-03-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (437, 'Rene', 'Cocker', 365, 11135, 0, to_date('19-10-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (438, 'Tyrone', 'Stevenson', 179, 55813, 0, to_date('25-03-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (439, 'Lydia', 'Robinson', 49, 44867, 0, to_date('28-05-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (440, 'Patrick', 'O''Neal', 93, 27220, 0, to_date('11-06-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (441, 'Pelvic', 'Andrews', 19, 49679, 0, to_date('25-01-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (442, 'Praga', 'Kilmer', 283, 17080, 0, to_date('20-04-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (443, 'King', 'Stormare', 112, 95287, 0, to_date('19-04-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (444, 'Hector', 'Tippe', 356, 44804, 0, to_date('19-04-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (446, 'Miriam', 'Cube', 345, 10703, 0, to_date('08-03-2004', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (447, 'Rhett', 'Bullock', 62, 56002, 0, to_date('13-11-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (448, 'Grace', 'Chestnut', 221, 15005, 0, to_date('26-01-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (449, 'Alex', 'MacDonald', 118, 44519, 0, to_date('03-09-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (450, 'Anjelica', 'Dayne', 365, 34319, 0, to_date('01-12-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (451, 'Walter', 'Summer', 35, 25324, 0, to_date('17-04-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (452, 'Lindsey', 'Leachman', 288, 65057, 0, to_date('13-01-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (453, 'Nik', 'Loring', 395, 15197, 0, to_date('30-12-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (454, 'Nigel', 'Aniston', 218, 65841, 0, to_date('25-08-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (455, 'Josh', 'Strathairn', 122, 32312, 0, to_date('05-06-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (456, 'Javon', 'Hingle', 248, 43455, 0, to_date('11-08-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (457, 'Azucar', 'Dukakis', 118, 61111, 0, to_date('28-03-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (458, 'Maceo', 'Feliciano', 260, 19333, 0, to_date('01-11-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (462, 'Mary-Louise', 'Kahn', 250, 66515, 0, to_date('24-12-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (465, 'Adam', 'Hauser', 172, 95553, 0, to_date('07-05-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (466, 'Sissy', 'Mraz', 200, 63895, 0, to_date('09-12-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (468, 'Grace', 'de Lancie', 78, 21984, 0, to_date('14-03-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (470, 'Carlene', 'Deejay', 356, 65520, 0, to_date('12-10-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (471, 'Wally', 'Herrmann', 91, 94760, 0, to_date('19-04-1995', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (472, 'Yolanda', 'Porter', 279, 48753, 0, to_date('23-12-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (473, 'Famke', 'Tucker', 324, 16058, 0, to_date('28-11-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (474, 'Mykelti', 'Cantrell', 292, 31354, 0, to_date('28-03-1954', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (475, 'Grant', 'Oates', 372, 70855, 0, to_date('27-08-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (476, 'Gabrielle', 'Crouch', 114, 48826, 0, to_date('16-03-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (477, 'Reese', 'Wilder', 78, 48047, 0, to_date('10-04-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (479, 'Cole', 'Twilley', 277, 91395, 0, to_date('25-07-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (481, 'Roy', 'Studi', 326, 86086, 0, to_date('14-06-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (482, 'Rob', 'Hobson', 144, 34756, 0, to_date('16-09-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (483, 'Amy', 'Byrd', 369, 57158, 0, to_date('04-10-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (484, 'Fionnula', 'Lachey', 109, 93413, 0, to_date('20-08-1988', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (485, 'Garry', 'Hector', 109, 45611, 0, to_date('14-12-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (486, 'Jonny Lee', 'Barkin', 325, 36006, 0, to_date('16-03-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (487, 'Rita', 'Allan', 318, 20450, 0, to_date('19-06-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (488, 'Dan', 'Lillard', 305, 97574, 0, to_date('01-03-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (489, 'Vern', 'Palmieri', 267, 47464, 0, to_date('18-06-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (490, 'King', 'Perrineau', 94, 14967, 0, to_date('01-02-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (491, 'Timothy', 'Fraser', 312, 58017, 0, to_date('14-01-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (492, 'Toni', 'Duvall', 10, 41088, 0, to_date('25-08-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (493, 'Burton', 'Murdock', 207, 23617, 0, to_date('05-04-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (494, 'Faye', 'Jessee', 368, 53754, 0, to_date('05-07-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (495, 'Howie', 'Stiller', 188, 14579, 0, to_date('18-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (496, 'Pete', 'Loggins', 291, 73706, 0, to_date('08-12-1992', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (497, 'Leslie', 'Hector', 397, 93516, 0, to_date('09-09-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (498, 'Danny', 'Makowicz', 28, 38802, 0, to_date('08-09-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (499, 'Lynette', 'Shepard', 289, 16990, 0, to_date('29-12-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (500, 'Jeffrey', 'Mulroney', 72, 33921, 0, to_date('18-10-1976', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (501, 'Val', 'Sizemore', 188, 91058, 0, to_date('11-09-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (502, 'Phil', 'Lindo', 91, 38615, 0, to_date('05-04-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (503, 'Whoopi', 'Wright', 46, 49026, 0, to_date('14-04-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (504, 'Rachid', 'Lightfoot', 376, 77032, 0, to_date('25-10-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (505, 'Cathy', 'Calle', 155, 42183, 0, to_date('11-06-1978', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (506, 'Sara', 'Richter', 212, 57149, 0, to_date('24-03-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (507, 'Lenny', 'Chambers', 283, 26789, 0, to_date('06-12-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (508, 'Colin', 'Keitel', 84, 48838, 0, to_date('10-11-1934', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (509, 'Embeth', 'Geldof', 168, 63104, 0, to_date('20-12-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1400, 'Ethan', 'Garcia', 7, 94999, 0, to_date('26-04-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1401, 'Ethan', 'Anderson', 1, 27387, 0, to_date('30-05-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1402, 'Michael', 'Miller', 2, 36293, 0, to_date('21-10-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1403, 'Alexander', 'Gonzalez', 6, 32432, 0, to_date('21-09-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1404, 'Elijah', 'Williams', 2, 34216, 0, to_date('14-04-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1405, 'William', 'Martinez', 5, 23234, 0, to_date('23-02-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1406, 'Amelia', 'Rodriguez', 2, 95451, 0, to_date('16-01-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1407, 'Lucas', 'Taylor', 7, 23986, 0, to_date('22-09-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1408, 'Ava', 'Gonzalez', 6, 95771, 0, to_date('23-09-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1409, 'Alexander', 'Martin', 2, 57827, 0, to_date('30-10-2017', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1410, 'Elijah', 'Garcia', 4, 85379, 0, to_date('03-12-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1411, 'Evelyn', 'Taylor', 10, 70376, 0, to_date('16-04-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1412, 'Benjamin', 'Martinez', 2, 55099, 0, to_date('05-11-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1413, 'Amelia', 'Johnson', 3, 80868, 0, to_date('23-07-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1414, 'Alexander', 'Brown', 10, 64795, 0, to_date('02-04-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1415, 'James', 'Smith', 4, 39146, 0, to_date('06-02-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1416, 'Sophia', 'Hernandez', 1, 71947, 0, to_date('27-03-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1417, 'Lucas', 'Jones', 9, 89405, 0, to_date('23-01-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1418, 'Abigail', 'Martinez', 4, 63133, 0, to_date('30-12-1948', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1419, 'James', 'Wilson', 4, 53876, 0, to_date('16-06-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1420, 'Ava', 'Jackson', 4, 67600, 0, to_date('06-05-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1421, 'Mia', 'Miller', 7, 52493, 0, to_date('05-06-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1422, 'Isabella', 'Hernandez', 10, 56587, 0, to_date('14-03-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1423, 'Mia', 'Wilson', 9, 23214, 0, to_date('06-05-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1424, 'Olivia', 'Martinez', 7, 81361, 0, to_date('11-04-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1425, 'Emma', 'Hernandez', 1, 94975, 0, to_date('12-12-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1426, 'John', 'Martinez', 9, 65292, 0, to_date('13-12-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1427, 'James', 'Taylor', 5, 69736, 0, to_date('15-04-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1428, 'John', 'Hernandez', 5, 29268, 0, to_date('01-02-1974', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1429, 'Lucas', 'Anderson', 10, 97274, 0, to_date('19-04-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1430, 'Alexander', 'Moore', 3, 70929, 0, to_date('07-09-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1431, 'Evelyn', 'Martinez', 6, 84553, 0, to_date('25-12-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1432, 'Michael', 'Lopez', 10, 28652, 0, to_date('27-12-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1433, 'James', 'Rodriguez', 4, 86463, 0, to_date('01-05-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1434, 'Evelyn', 'Miller', 3, 21243, 0, to_date('25-03-1976', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1435, 'Amelia', 'Rodriguez', 9, 38002, 0, to_date('07-06-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1436, 'Emma', 'Rodriguez', 9, 98077, 0, to_date('16-02-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1437, 'Benjamin', 'Lopez', 4, 82813, 0, to_date('15-03-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1438, 'Michael', 'Rodriguez', 7, 11934, 0, to_date('02-03-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1439, 'Michael', 'Hernandez', 6, 78829, 0, to_date('08-08-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1440, 'Olivia', 'Anderson', 3, 73015, 0, to_date('21-09-1948', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1441, 'Lucas', 'Johnson', 8, 25215, 0, to_date('14-07-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1442, 'Mia', 'Brown', 4, 95279, 0, to_date('04-11-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1443, 'John', 'Martin', 9, 80911, 0, to_date('18-05-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1444, 'James', 'Hernandez', 2, 18108, 0, to_date('09-04-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1445, 'Ava', 'Smith', 6, 11588, 0, to_date('27-11-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1446, 'Mason', 'Smith', 2, 96164, 0, to_date('06-10-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1447, 'Elijah', 'Anderson', 8, 28809, 0, to_date('16-11-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1448, 'James', 'Jackson', 6, 92733, 0, to_date('30-07-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1449, 'Alexander', 'Gonzalez', 6, 51344, 0, to_date('04-01-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1450, 'Mason', 'Miller', 1, 47558, 0, to_date('18-04-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1451, 'Benjamin', 'Miller', 6, 20320, 0, to_date('25-11-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1452, 'William', 'Miller', 4, 42503, 0, to_date('01-11-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1453, 'John', 'Garcia', 3, 77132, 0, to_date('11-04-2004', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1454, 'Sophia', 'Moore', 6, 80153, 0, to_date('06-01-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1455, 'Olivia', 'Wilson', 9, 53443, 0, to_date('17-10-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1456, 'Elijah', 'Williams', 3, 65280, 0, to_date('17-04-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1457, 'Benjamin', 'Miller', 3, 73750, 0, to_date('09-11-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1458, 'Isabella', 'Martin', 10, 21115, 0, to_date('08-08-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1459, 'Mason', 'Gonzalez', 6, 73899, 0, to_date('13-03-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1460, 'Ethan', 'Moore', 6, 92686, 0, to_date('01-10-1990', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1461, 'Evelyn', 'Johnson', 4, 66192, 0, to_date('27-01-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1462, 'James', 'Smith', 4, 31297, 0, to_date('13-08-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1463, 'Emma', 'Johnson', 3, 11827, 0, to_date('27-01-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1464, 'Olivia', 'Rodriguez', 7, 69571, 0, to_date('06-02-1988', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1465, 'Benjamin', 'Smith', 9, 86395, 0, to_date('17-11-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1466, 'William', 'Jones', 2, 14226, 0, to_date('08-08-1956', 'dd-mm-yyyy'));
commit;
prompt 500 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1467, 'John', 'Taylor', 8, 95831, 0, to_date('23-05-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1468, 'Ethan', 'Johnson', 9, 34183, 0, to_date('28-04-1953', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1469, 'Michael', 'Hernandez', 10, 15124, 0, to_date('23-02-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1470, 'Benjamin', 'Miller', 10, 49111, 0, to_date('21-08-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1471, 'Abigail', 'Taylor', 6, 27735, 0, to_date('24-01-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1472, 'Olivia', 'Moore', 7, 93467, 0, to_date('14-10-2014', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1473, 'Amelia', 'Davis', 4, 53548, 0, to_date('14-01-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1474, 'Evelyn', 'Davis', 3, 35492, 0, to_date('18-12-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1475, 'Elijah', 'Jones', 2, 91616, 0, to_date('26-10-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1476, 'Ava', 'Rodriguez', 3, 71285, 0, to_date('11-04-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1477, 'Abigail', 'Johnson', 10, 89826, 0, to_date('18-04-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1478, 'Elijah', 'Brown', 10, 52759, 0, to_date('05-09-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1479, 'Michael', 'Rodriguez', 7, 14722, 0, to_date('21-12-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1480, 'James', 'Taylor', 1, 26266, 0, to_date('11-11-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1481, 'Lucas', 'Jackson', 6, 85688, 0, to_date('30-05-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1482, 'Sophia', 'Miller', 1, 61271, 0, to_date('01-03-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1483, 'Olivia', 'Lopez', 9, 48553, 0, to_date('10-10-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1484, 'Mia', 'Davis', 1, 39795, 0, to_date('29-04-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1485, 'Lucas', 'Miller', 4, 37327, 0, to_date('13-06-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1486, 'William', 'Garcia', 9, 56604, 0, to_date('27-07-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1487, 'Evelyn', 'Williams', 7, 28554, 0, to_date('15-06-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1488, 'Elijah', 'Lopez', 8, 84532, 0, to_date('15-04-1938', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1489, 'Harper', 'Miller', 6, 33225, 0, to_date('13-12-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1490, 'Amelia', 'Martinez', 9, 38090, 0, to_date('15-05-1992', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1491, 'Lucas', 'Garcia', 1, 15059, 0, to_date('07-04-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1492, 'Abigail', 'Williams', 9, 13327, 0, to_date('15-12-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1493, 'Evelyn', 'Smith', 6, 85565, 0, to_date('28-03-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1494, 'Abigail', 'Johnson', 2, 58513, 0, to_date('11-11-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1495, 'Sophia', 'Brown', 6, 67038, 0, to_date('08-12-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1496, 'Evelyn', 'Williams', 10, 28735, 0, to_date('05-12-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1497, 'Mason', 'Williams', 5, 79728, 0, to_date('25-07-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1498, 'James', 'Hernandez', 5, 27593, 0, to_date('16-03-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1499, 'Alexander', 'Jackson', 7, 94223, 0, to_date('08-04-1926', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1100, 'Elijah', 'Martinez', 6, 87441, 0, to_date('04-08-1940', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1101, 'Isabella', 'Miller', 8, 89405, 0, to_date('19-01-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1102, 'Abigail', 'Wilson', 6, 33097, 0, to_date('26-07-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1103, 'John', 'Johnson', 7, 59002, 0, to_date('23-08-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1104, 'Lucas', 'Thomas', 3, 85122, 0, to_date('28-10-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1105, 'Michael', 'Johnson', 5, 95150, 0, to_date('03-08-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1106, 'Isabella', 'Davis', 7, 64095, 0, to_date('13-05-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1107, 'Olivia', 'Jackson', 9, 68907, 0, to_date('25-01-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1108, 'Isabella', 'Thomas', 8, 90409, 0, to_date('25-06-2005', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1109, 'Mia', 'Thomas', 9, 42856, 0, to_date('14-07-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1110, 'Mia', 'Jackson', 2, 55209, 0, to_date('02-04-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1111, 'Isabella', 'Brown', 1, 71705, 0, to_date('29-11-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1112, 'John', 'Smith', 3, 69505, 0, to_date('02-01-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1113, 'John', 'Williams', 9, 53260, 0, to_date('27-12-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1114, 'Lucas', 'Jones', 5, 35967, 0, to_date('07-07-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1115, 'William', 'Gonzalez', 8, 36759, 0, to_date('25-04-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1116, 'Isabella', 'Miller', 9, 98608, 0, to_date('25-11-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1117, 'Emma', 'Martinez', 5, 99909, 0, to_date('06-03-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1118, 'Evelyn', 'Taylor', 9, 45447, 0, to_date('03-10-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1119, 'Evelyn', 'Taylor', 10, 56223, 0, to_date('08-10-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1120, 'Benjamin', 'Davis', 8, 38120, 0, to_date('25-08-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1121, 'Sophia', 'Smith', 4, 16532, 0, to_date('07-05-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1122, 'Isabella', 'Rodriguez', 8, 45264, 0, to_date('29-07-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1123, 'Olivia', 'Taylor', 4, 61553, 0, to_date('01-11-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1124, 'Mia', 'Garcia', 1, 35033, 0, to_date('20-08-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1125, 'Evelyn', 'Garcia', 9, 10004, 0, to_date('02-08-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1126, 'Sophia', 'Anderson', 4, 52594, 0, to_date('04-06-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1127, 'Ethan', 'Moore', 8, 61999, 0, to_date('18-05-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1128, 'James', 'Johnson', 7, 91519, 0, to_date('29-04-1935', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1129, 'Elijah', 'Moore', 7, 29008, 0, to_date('16-07-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1130, 'Sophia', 'Smith', 6, 96294, 0, to_date('22-10-2005', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1131, 'Michael', 'Martin', 4, 71265, 0, to_date('29-12-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1132, 'Harper', 'Miller', 1, 73174, 0, to_date('02-01-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1133, 'James', 'Garcia', 3, 79068, 0, to_date('24-11-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1134, 'Harper', 'Rodriguez', 9, 51933, 0, to_date('14-06-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1135, 'Amelia', 'Johnson', 10, 59274, 0, to_date('07-05-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1136, 'Elijah', 'Thomas', 7, 88682, 0, to_date('05-08-1943', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1137, 'Sophia', 'Williams', 9, 84674, 0, to_date('06-05-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1138, 'Abigail', 'Garcia', 10, 69508, 0, to_date('15-05-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1139, 'Elijah', 'Wilson', 2, 37653, 0, to_date('15-07-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1140, 'Ava', 'Anderson', 3, 55122, 0, to_date('25-09-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1141, 'Michael', 'Brown', 7, 24355, 0, to_date('20-03-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1142, 'Abigail', 'Johnson', 1, 53350, 0, to_date('21-08-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1143, 'Lucas', 'Wilson', 9, 23036, 0, to_date('14-10-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1144, 'Olivia', 'Moore', 1, 62597, 0, to_date('01-12-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1145, 'Benjamin', 'Hernandez', 4, 23498, 0, to_date('28-08-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1146, 'Olivia', 'Jones', 9, 68588, 0, to_date('04-04-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1147, 'Abigail', 'Taylor', 4, 28612, 0, to_date('27-03-1992', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1148, 'Emma', 'Wilson', 7, 30784, 0, to_date('26-11-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1149, 'Elijah', 'Lopez', 3, 73748, 0, to_date('20-02-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1150, 'Lucas', 'Rodriguez', 6, 38421, 0, to_date('03-03-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1151, 'John', 'Williams', 9, 11231, 0, to_date('09-01-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1152, 'Mason', 'Lopez', 9, 77319, 0, to_date('02-11-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1153, 'James', 'Johnson', 4, 23841, 0, to_date('26-12-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1154, 'Olivia', 'Miller', 6, 84865, 0, to_date('23-04-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1155, 'Evelyn', 'Taylor', 10, 40706, 0, to_date('24-07-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1156, 'Michael', 'Thomas', 9, 39566, 0, to_date('24-03-1961', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1157, 'Mia', 'Martinez', 5, 12407, 0, to_date('03-09-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1158, 'Abigail', 'Lopez', 5, 34613, 0, to_date('21-04-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1159, 'Olivia', 'Gonzalez', 10, 72518, 0, to_date('23-10-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1160, 'Sophia', 'Anderson', 10, 74677, 0, to_date('01-04-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1161, 'Alexander', 'Williams', 1, 30795, 0, to_date('13-03-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1162, 'John', 'Rodriguez', 5, 59577, 0, to_date('07-11-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1163, 'Benjamin', 'Williams', 1, 35753, 0, to_date('10-09-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1164, 'Abigail', 'Lopez', 2, 73591, 0, to_date('08-02-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1165, 'James', 'Jones', 4, 12376, 0, to_date('29-03-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1166, 'Harper', 'Johnson', 2, 53627, 0, to_date('27-07-1930', 'dd-mm-yyyy'));
commit;
prompt 600 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1167, 'Elijah', 'Johnson', 3, 31031, 0, to_date('05-08-2013', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1168, 'William', 'Miller', 6, 46297, 0, to_date('01-07-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1169, 'Harper', 'Brown', 6, 97419, 0, to_date('12-03-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1170, 'Elijah', 'Taylor', 10, 36943, 0, to_date('17-06-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1171, 'William', 'Miller', 4, 84793, 0, to_date('09-05-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1172, 'Benjamin', 'Wilson', 3, 91204, 0, to_date('27-08-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1173, 'Abigail', 'Miller', 6, 63002, 0, to_date('09-05-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1174, 'Ava', 'Anderson', 4, 96875, 0, to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1175, 'Olivia', 'Jackson', 1, 96301, 0, to_date('26-06-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1176, 'Alexander', 'Brown', 3, 94111, 0, to_date('25-10-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1177, 'Harper', 'Johnson', 7, 52619, 0, to_date('30-01-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1178, 'Mason', 'Jackson', 4, 41559, 0, to_date('17-10-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1179, 'Amelia', 'Jones', 3, 48919, 0, to_date('29-10-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1180, 'Mason', 'Jackson', 4, 40120, 0, to_date('03-03-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1181, 'Lucas', 'Miller', 3, 26973, 0, to_date('03-04-2017', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1182, 'Abigail', 'Brown', 2, 33035, 0, to_date('13-05-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1183, 'Harper', 'Johnson', 6, 50628, 0, to_date('28-06-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1184, 'Mia', 'Davis', 9, 91456, 0, to_date('02-04-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1185, 'Olivia', 'Moore', 9, 66501, 0, to_date('28-12-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1186, 'Mia', 'Taylor', 3, 46731, 0, to_date('27-03-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1187, 'Ava', 'Miller', 6, 79308, 0, to_date('11-04-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1188, 'Sophia', 'Lopez', 9, 37531, 0, to_date('27-04-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1189, 'Ethan', 'Thomas', 3, 52102, 0, to_date('08-09-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1190, 'James', 'Wilson', 1, 13382, 0, to_date('24-08-1973', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1191, 'Abigail', 'Wilson', 3, 11042, 0, to_date('23-10-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1192, 'Sophia', 'Martin', 8, 81083, 0, to_date('01-08-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1193, 'Michael', 'Martin', 9, 31520, 0, to_date('11-10-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1194, 'John', 'Johnson', 2, 30803, 0, to_date('29-10-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1195, 'Ava', 'Garcia', 2, 83217, 0, to_date('16-11-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1196, 'John', 'Jones', 5, 23009, 0, to_date('20-02-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1197, 'Sophia', 'Hernandez', 2, 88887, 0, to_date('15-04-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1198, 'Sophia', 'Miller', 1, 24757, 0, to_date('20-11-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1199, 'Emma', 'Jackson', 4, 13978, 0, to_date('20-05-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1200, 'Evelyn', 'Moore', 1, 54934, 0, to_date('12-01-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1201, 'John', 'Miller', 2, 24686, 0, to_date('28-09-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1202, 'Emma', 'Smith', 5, 71666, 0, to_date('08-11-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1203, 'Mia', 'Lopez', 4, 60010, 0, to_date('15-09-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1204, 'Michael', 'Davis', 3, 82083, 0, to_date('17-11-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1205, 'Benjamin', 'Rodriguez', 8, 37745, 0, to_date('30-10-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1206, 'Evelyn', 'Miller', 3, 50003, 0, to_date('14-07-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1207, 'Ethan', 'Williams', 10, 46360, 0, to_date('07-01-1941', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1208, 'Elijah', 'Martinez', 4, 65952, 0, to_date('07-12-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1209, 'Lucas', 'Hernandez', 10, 79204, 0, to_date('07-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1210, 'Sophia', 'Martin', 3, 26509, 0, to_date('04-03-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1211, 'James', 'Jones', 6, 62471, 0, to_date('20-11-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1212, 'John', 'Jackson', 3, 74617, 0, to_date('25-03-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1213, 'Elijah', 'Smith', 4, 96682, 0, to_date('26-10-1950', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1214, 'Evelyn', 'Rodriguez', 2, 96006, 0, to_date('13-12-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1215, 'Emma', 'Garcia', 10, 94833, 0, to_date('17-09-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1216, 'Lucas', 'Anderson', 9, 86835, 0, to_date('13-09-1976', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1217, 'Ethan', 'Taylor', 5, 73923, 0, to_date('09-12-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1218, 'Harper', 'Martin', 3, 95295, 0, to_date('28-09-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1219, 'Sophia', 'Taylor', 9, 52528, 0, to_date('04-07-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1220, 'Sophia', 'Brown', 8, 57352, 0, to_date('14-10-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1221, 'Evelyn', 'Davis', 1, 62718, 0, to_date('20-12-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1222, 'John', 'Davis', 9, 96856, 0, to_date('06-03-1989', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1223, 'Alexander', 'Smith', 9, 39859, 0, to_date('20-08-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1224, 'Harper', 'Brown', 5, 47275, 0, to_date('14-06-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1225, 'Michael', 'Gonzalez', 7, 38371, 0, to_date('02-08-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1226, 'James', 'Miller', 6, 57436, 0, to_date('15-05-1963', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1227, 'Amelia', 'Anderson', 10, 55542, 0, to_date('18-08-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1228, 'William', 'Jones', 2, 31772, 0, to_date('07-01-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1229, 'Michael', 'Jones', 2, 25585, 0, to_date('12-02-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1230, 'Elijah', 'Wilson', 6, 51375, 0, to_date('15-07-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1231, 'Olivia', 'Rodriguez', 10, 37954, 0, to_date('20-08-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1232, 'Abigail', 'Smith', 8, 14853, 0, to_date('01-04-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1233, 'Abigail', 'Rodriguez', 9, 48225, 0, to_date('27-05-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1234, 'James', 'Jackson', 9, 36642, 0, to_date('03-04-1953', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1235, 'Sophia', 'Jackson', 9, 21911, 0, to_date('19-06-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1236, 'Amelia', 'Davis', 5, 22720, 0, to_date('26-02-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1237, 'Mason', 'Brown', 1, 98590, 0, to_date('17-11-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1238, 'Mia', 'Davis', 6, 84926, 0, to_date('20-09-1930', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1239, 'Olivia', 'Garcia', 6, 97369, 0, to_date('01-08-1946', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1240, 'Lucas', 'Brown', 8, 37392, 0, to_date('13-01-2004', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1241, 'Benjamin', 'Miller', 8, 53373, 0, to_date('17-11-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1242, 'Alexander', 'Johnson', 3, 26879, 0, to_date('10-11-2000', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1243, 'Ethan', 'Johnson', 1, 92006, 0, to_date('26-06-1953', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1244, 'Abigail', 'Anderson', 5, 14793, 0, to_date('24-06-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1245, 'Harper', 'Jackson', 5, 90248, 0, to_date('06-07-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1246, 'Sophia', 'Miller', 6, 93673, 0, to_date('20-07-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1247, 'Sophia', 'Moore', 6, 55087, 0, to_date('26-06-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1248, 'Olivia', 'Garcia', 1, 98938, 0, to_date('08-10-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1249, 'Sophia', 'Lopez', 4, 76779, 0, to_date('18-10-1991', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1250, 'Emma', 'Wilson', 10, 61530, 0, to_date('10-09-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1251, 'Abigail', 'Rodriguez', 4, 78836, 0, to_date('25-10-1977', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1252, 'William', 'Brown', 6, 17186, 0, to_date('24-08-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1253, 'Evelyn', 'Taylor', 10, 63293, 0, to_date('25-03-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1254, 'William', 'Johnson', 8, 53395, 0, to_date('15-12-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1255, 'Amelia', 'Taylor', 1, 50654, 0, to_date('22-04-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1256, 'Sophia', 'Jones', 4, 54758, 0, to_date('28-03-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1257, 'Ava', 'Brown', 2, 66619, 0, to_date('04-04-1979', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1258, 'Benjamin', 'Williams', 4, 94986, 0, to_date('02-03-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1259, 'Harper', 'Brown', 3, 75919, 0, to_date('07-10-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1260, 'Lucas', 'Taylor', 7, 57172, 0, to_date('27-03-1931', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1261, 'Elijah', 'Brown', 10, 69687, 0, to_date('25-05-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1262, 'Lucas', 'Brown', 10, 32184, 0, to_date('24-03-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1263, 'Abigail', 'Brown', 2, 68188, 0, to_date('12-10-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1264, 'James', 'Taylor', 10, 65947, 0, to_date('22-09-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1265, 'Evelyn', 'Miller', 5, 74204, 0, to_date('05-12-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1266, 'Michael', 'Moore', 4, 68776, 0, to_date('18-08-1942', 'dd-mm-yyyy'));
commit;
prompt 700 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1267, 'Lucas', 'Taylor', 4, 36601, 0, to_date('28-09-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1268, 'Mia', 'Jackson', 2, 82605, 0, to_date('26-03-1969', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1269, 'Harper', 'Jackson', 10, 85607, 0, to_date('10-08-1999', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1270, 'Ava', 'Thomas', 7, 35084, 0, to_date('14-11-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1271, 'Elijah', 'Hernandez', 10, 10465, 0, to_date('10-02-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1272, 'Elijah', 'Martinez', 1, 72278, 0, to_date('25-01-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1273, 'William', 'Martin', 2, 99439, 0, to_date('11-11-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1274, 'Ava', 'Garcia', 5, 50005, 0, to_date('29-12-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1275, 'Olivia', 'Martin', 1, 95166, 0, to_date('19-03-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1276, 'Harper', 'Anderson', 6, 77230, 0, to_date('18-10-1957', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1277, 'Mason', 'Taylor', 6, 76588, 0, to_date('21-02-1973', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1278, 'Sophia', 'Smith', 2, 70846, 0, to_date('22-01-2015', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1279, 'Benjamin', 'Williams', 2, 36301, 0, to_date('04-11-2002', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1280, 'Mia', 'Miller', 2, 66815, 0, to_date('19-06-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1281, 'Benjamin', 'Brown', 2, 26036, 0, to_date('17-05-1936', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1282, 'Elijah', 'Taylor', 4, 30009, 0, to_date('07-01-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1283, 'Elijah', 'Smith', 8, 18877, 0, to_date('16-09-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1284, 'Abigail', 'Davis', 6, 76894, 0, to_date('07-09-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1285, 'Isabella', 'Wilson', 5, 50148, 0, to_date('01-05-1959', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1286, 'Mia', 'Martin', 9, 78098, 0, to_date('10-01-2016', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1287, 'Sophia', 'Hernandez', 9, 29770, 0, to_date('11-09-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1288, 'Amelia', 'Smith', 4, 41292, 0, to_date('14-02-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1289, 'Mason', 'Garcia', 2, 95022, 0, to_date('04-05-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1290, 'Amelia', 'Martin', 3, 61660, 0, to_date('05-11-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1291, 'Alexander', 'Williams', 1, 93316, 0, to_date('27-09-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1292, 'Elijah', 'Martin', 10, 58261, 0, to_date('17-12-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1293, 'Lucas', 'Anderson', 9, 42008, 0, to_date('10-01-1964', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1294, 'Harper', 'Rodriguez', 5, 22004, 0, to_date('12-02-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1295, 'Harper', 'Thomas', 9, 43666, 0, to_date('29-03-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1296, 'Harper', 'Davis', 1, 68978, 0, to_date('26-07-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1297, 'James', 'Johnson', 4, 82060, 0, to_date('15-04-1956', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1298, 'Sophia', 'Wilson', 2, 41832, 0, to_date('17-04-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1299, 'Mason', 'Williams', 2, 15040, 0, to_date('05-03-1951', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1300, 'Alexander', 'Thomas', 5, 29233, 0, to_date('27-04-1982', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1301, 'William', 'Martinez', 1, 59849, 0, to_date('31-10-1966', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1302, 'Elijah', 'Jones', 8, 86425, 0, to_date('19-02-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1303, 'Abigail', 'Jones', 9, 79038, 0, to_date('22-04-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1304, 'Ava', 'Anderson', 9, 47972, 0, to_date('21-01-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1305, 'Emma', 'Wilson', 6, 66740, 0, to_date('13-10-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1306, 'Lucas', 'Davis', 1, 28770, 0, to_date('25-03-1974', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1307, 'Mason', 'Davis', 1, 45726, 0, to_date('03-01-2020', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1308, 'Mason', 'Gonzalez', 3, 89063, 0, to_date('01-02-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1309, 'William', 'Williams', 10, 75604, 0, to_date('15-08-1929', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1310, 'Harper', 'Wilson', 4, 22510, 0, to_date('09-03-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1311, 'Emma', 'Williams', 4, 92702, 0, to_date('28-07-1976', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1312, 'Emma', 'Davis', 5, 15889, 0, to_date('26-01-2004', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1313, 'Alexander', 'Anderson', 1, 85136, 0, to_date('23-01-1958', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1314, 'James', 'Martin', 7, 38009, 0, to_date('10-01-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1315, 'Michael', 'Martin', 9, 34992, 0, to_date('09-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1316, 'James', 'Wilson', 9, 98054, 0, to_date('06-03-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1317, 'Lucas', 'Smith', 10, 73854, 0, to_date('07-01-1943', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1318, 'Benjamin', 'Miller', 2, 13261, 0, to_date('11-06-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1319, 'Isabella', 'Wilson', 8, 35212, 0, to_date('22-08-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1320, 'William', 'Martin', 9, 64196, 0, to_date('13-04-2011', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1321, 'Emma', 'Lopez', 3, 93219, 0, to_date('10-06-1995', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1322, 'Elijah', 'Brown', 10, 37492, 0, to_date('18-10-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1323, 'Sophia', 'Lopez', 1, 43937, 0, to_date('09-04-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1324, 'Ava', 'Brown', 9, 45647, 0, to_date('21-08-1984', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1325, 'Harper', 'Smith', 3, 94043, 0, to_date('20-02-1962', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1326, 'Lucas', 'Miller', 7, 82100, 0, to_date('29-08-2017', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1327, 'Isabella', 'Brown', 9, 85836, 0, to_date('23-11-1953', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1328, 'Evelyn', 'Smith', 3, 93644, 0, to_date('23-08-1987', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1329, 'Ethan', 'Miller', 5, 26625, 0, to_date('01-11-1973', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1330, 'Evelyn', 'Miller', 5, 73435, 0, to_date('05-06-1965', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1331, 'Olivia', 'Taylor', 10, 93596, 0, to_date('10-03-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1332, 'Harper', 'Smith', 1, 43873, 0, to_date('16-05-1932', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1333, 'John', 'Johnson', 5, 60085, 0, to_date('15-06-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1334, 'Mia', 'Rodriguez', 9, 66446, 0, to_date('16-08-1985', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1335, 'Alexander', 'Brown', 9, 88740, 0, to_date('09-04-1939', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1336, 'Ethan', 'Lopez', 3, 48657, 0, to_date('08-07-1970', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1337, 'Harper', 'Taylor', 6, 31453, 0, to_date('19-11-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1338, 'Isabella', 'Brown', 4, 20696, 0, to_date('21-02-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1339, 'Evelyn', 'Miller', 1, 69219, 0, to_date('02-05-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1340, 'Evelyn', 'Anderson', 1, 77209, 0, to_date('25-02-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1341, 'Emma', 'Miller', 6, 25576, 0, to_date('17-04-2019', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1342, 'Mason', 'Gonzalez', 5, 24107, 0, to_date('08-11-1993', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1343, 'Amelia', 'Smith', 9, 62135, 0, to_date('22-02-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1344, 'Amelia', 'Smith', 7, 96660, 0, to_date('27-09-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1345, 'Lucas', 'Jackson', 5, 63139, 0, to_date('05-08-2010', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1346, 'Elijah', 'Miller', 4, 16770, 0, to_date('28-05-1998', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1347, 'Evelyn', 'Anderson', 2, 39086, 0, to_date('31-07-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1348, 'John', 'Williams', 5, 71043, 0, to_date('11-07-1942', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1349, 'Isabella', 'Martin', 8, 25234, 0, to_date('24-05-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1350, 'William', 'Miller', 7, 63983, 0, to_date('28-03-1926', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1351, 'Harper', 'Martinez', 10, 51375, 0, to_date('25-07-1943', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1352, 'Ava', 'Brown', 6, 28269, 0, to_date('15-08-2001', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1353, 'Evelyn', 'Miller', 6, 75246, 0, to_date('26-12-1967', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1354, 'Isabella', 'Moore', 3, 74469, 351, to_date('13-12-1924', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1355, 'Sophia', 'Williams', 5, 72814, 0, to_date('12-12-1960', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1356, 'Alexander', 'Jackson', 4, 94311, 0, to_date('11-04-1981', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1357, 'Alexander', 'Williams', 1, 46848, 0, to_date('11-02-1954', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1358, 'Ethan', 'Johnson', 6, 40678, 0, to_date('01-10-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1359, 'John', 'Martin', 1, 42726, 0, to_date('28-01-1961', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1360, 'Alexander', 'Williams', 10, 90478, 0, to_date('05-03-1983', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1361, 'Isabella', 'Martin', 4, 94820, 0, to_date('22-03-1944', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1362, 'Ethan', 'Davis', 8, 92556, 0, to_date('27-09-2008', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1363, 'William', 'Gonzalez', 2, 39369, 0, to_date('18-06-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1364, 'James', 'Wilson', 5, 73890, 0, to_date('04-12-1975', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1365, 'Sophia', 'Wilson', 10, 68676, 0, to_date('17-03-1933', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1366, 'Olivia', 'Rodriguez', 3, 22327, 0, to_date('29-12-1936', 'dd-mm-yyyy'));
commit;
prompt 800 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1367, 'Ethan', 'Williams', 5, 81660, 0, to_date('24-03-2007', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1368, 'Olivia', 'Martin', 7, 58602, 0, to_date('02-02-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1369, 'Benjamin', 'Brown', 1, 91136, 0, to_date('03-02-1927', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1370, 'Sophia', 'Martin', 2, 23834, 0, to_date('22-01-1997', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1371, 'James', 'Brown', 1, 59950, 0, to_date('26-05-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1372, 'Abigail', 'Miller', 9, 36903, 0, to_date('06-10-1992', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1373, 'John', 'Anderson', 7, 20548, 0, to_date('08-12-1925', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1374, 'Ethan', 'Jones', 9, 99160, 0, to_date('04-08-1937', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1375, 'James', 'Martinez', 9, 86491, 0, to_date('24-01-1955', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1376, 'John', 'Williams', 7, 64396, 0, to_date('18-06-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1377, 'Ava', 'Miller', 4, 54015, 0, to_date('18-06-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1378, 'Olivia', 'Martin', 1, 88601, 0, to_date('24-02-1947', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1379, 'Lucas', 'Smith', 7, 94383, 0, to_date('15-01-2018', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1380, 'Ethan', 'Anderson', 6, 92925, 0, to_date('08-02-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1381, 'Ava', 'Gonzalez', 2, 81899, 0, to_date('12-09-2009', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1382, 'Abigail', 'Gonzalez', 8, 82384, 0, to_date('08-09-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1383, 'William', 'Brown', 10, 31880, 0, to_date('20-12-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1384, 'Evelyn', 'Moore', 6, 91318, 0, to_date('21-04-1980', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1385, 'Evelyn', 'Wilson', 3, 33125, 0, to_date('13-05-1945', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1386, 'Alexander', 'Wilson', 5, 23562, 0, to_date('05-12-1996', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1387, 'Mia', 'Gonzalez', 8, 47339, 0, to_date('16-05-1968', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1388, 'Harper', 'Garcia', 7, 95196, 0, to_date('28-12-1928', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1389, 'Harper', 'Miller', 10, 15001, 0, to_date('10-08-2006', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1390, 'Michael', 'Johnson', 1, 28054, 0, to_date('26-09-2012', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1391, 'John', 'Smith', 5, 69997, 0, to_date('21-11-1952', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1392, 'Evelyn', 'Anderson', 3, 28356, 0, to_date('02-05-1971', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1393, 'John', 'Taylor', 7, 25186, 0, to_date('16-01-1974', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1394, 'Emma', 'Rodriguez', 9, 80336, 0, to_date('23-08-1986', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1395, 'Alexander', 'Jones', 2, 21907, 0, to_date('10-07-1994', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1396, 'Ethan', 'Thomas', 10, 68355, 0, to_date('19-11-1949', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1397, 'James', 'Anderson', 5, 35742, 0, to_date('02-05-1972', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1398, 'Mason', 'Thomas', 10, 35503, 0, to_date('26-02-2003', 'dd-mm-yyyy'));
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday)
values (1399, 'Benjamin', 'Wilson', 10, 98272, 0, to_date('20-12-1953', 'dd-mm-yyyy'));
commit;
prompt 833 records loaded
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
values (5, 10);
insert into PARTICIPATE (group_id, client_id)
values (9, 9);
insert into PARTICIPATE (group_id, client_id)
values (9, 10);
insert into PARTICIPATE (group_id, client_id)
values (23, 372);
insert into PARTICIPATE (group_id, client_id)
values (28, 238);
insert into PARTICIPATE (group_id, client_id)
values (29, 262);
insert into PARTICIPATE (group_id, client_id)
values (36, 1337);
insert into PARTICIPATE (group_id, client_id)
values (36, 1405);
insert into PARTICIPATE (group_id, client_id)
values (42, 1497);
insert into PARTICIPATE (group_id, client_id)
values (73, 265);
insert into PARTICIPATE (group_id, client_id)
values (74, 407);
insert into PARTICIPATE (group_id, client_id)
values (75, 20);
insert into PARTICIPATE (group_id, client_id)
values (113, 1477);
insert into PARTICIPATE (group_id, client_id)
values (138, 79);
insert into PARTICIPATE (group_id, client_id)
values (181, 1448);
insert into PARTICIPATE (group_id, client_id)
values (184, 475);
insert into PARTICIPATE (group_id, client_id)
values (187, 1296);
insert into PARTICIPATE (group_id, client_id)
values (192, 317);
insert into PARTICIPATE (group_id, client_id)
values (196, 160);
insert into PARTICIPATE (group_id, client_id)
values (213, 380);
insert into PARTICIPATE (group_id, client_id)
values (223, 133);
insert into PARTICIPATE (group_id, client_id)
values (230, 1388);
insert into PARTICIPATE (group_id, client_id)
values (233, 53);
insert into PARTICIPATE (group_id, client_id)
values (234, 1354);
insert into PARTICIPATE (group_id, client_id)
values (241, 374);
insert into PARTICIPATE (group_id, client_id)
values (260, 440);
insert into PARTICIPATE (group_id, client_id)
values (265, 182);
insert into PARTICIPATE (group_id, client_id)
values (288, 220);
insert into PARTICIPATE (group_id, client_id)
values (289, 1493);
insert into PARTICIPATE (group_id, client_id)
values (304, 1111);
insert into PARTICIPATE (group_id, client_id)
values (313, 66);
insert into PARTICIPATE (group_id, client_id)
values (313, 1492);
insert into PARTICIPATE (group_id, client_id)
values (326, 383);
insert into PARTICIPATE (group_id, client_id)
values (330, 1379);
insert into PARTICIPATE (group_id, client_id)
values (351, 1302);
insert into PARTICIPATE (group_id, client_id)
values (371, 447);
insert into PARTICIPATE (group_id, client_id)
values (376, 1214);
insert into PARTICIPATE (group_id, client_id)
values (386, 1107);
insert into PARTICIPATE (group_id, client_id)
values (386, 1384);
insert into PARTICIPATE (group_id, client_id)
values (387, 1383);
insert into PARTICIPATE (group_id, client_id)
values (399, 1280);
insert into PARTICIPATE (group_id, client_id)
values (417, 223);
insert into PARTICIPATE (group_id, client_id)
values (456, 54);
insert into PARTICIPATE (group_id, client_id)
values (463, 1339);
insert into PARTICIPATE (group_id, client_id)
values (475, 72);
insert into PARTICIPATE (group_id, client_id)
values (478, 1488);
commit;
prompt 46 records loaded
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
values (1, 'Isabella', 'Jay', 1, 68611, 0, to_date('16-04-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (2, 'Shirley', 'Ermey', 2, 84533, 0, to_date('15-06-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (3, 'Whoopi', 'Dafoe', 3, 18453, 0, to_date('03-12-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (4, 'Chris', 'Hoskins', 4, 74083, 0, to_date('19-09-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (5, 'Kate', 'Feore', 5, 42328, 0, to_date('09-07-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (6, 'Nicole', 'Hackman', 6, 96996, 0, to_date('14-10-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (7, 'Mika', 'Aiken', 7, 57321, 370, to_date('01-08-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (8, 'Hilton', 'Salonga', 8, 70912, 0, to_date('24-05-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (9, 'Aaron', 'Todd', 9, 50162, 151, to_date('04-05-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (10, 'Eddie', 'Jackman', 10, 84571, 0, to_date('06-10-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (11, 'Tcheky', 'Sartain', 105, 37587, 0, to_date('26-12-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (12, 'Madeleine', 'Mandrell', 366, 42958, 0, to_date('21-08-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (13, 'Shirley', 'Mahood', 11, 18621, 0, to_date('04-12-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (14, 'Nancy', 'Cartlidge', 312, 51064, 0, to_date('09-02-1955', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (15, 'Manu', 'Bergen', 96, 89284, 0, to_date('15-08-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (16, 'Corey', 'Bruce', 12, 91867, 0, to_date('03-07-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (17, 'Delroy', 'Akins', 245, 89543, 0, to_date('12-08-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (18, 'Azucar', 'Getty', 70, 28757, 0, to_date('29-08-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (19, 'Kylie', 'Streep', 371, 90146, 0, to_date('23-02-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (20, 'Nanci', 'Schiff', 185, 23674, 0, to_date('10-12-1964', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (21, 'Dylan', 'Kirkwood', 151, 95046, 0, to_date('13-07-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (24, 'Saul', 'Penders', 42, 57489, 0, to_date('24-10-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (25, 'Jeffrey', 'Dorn', 134, 50348, 0, to_date('29-04-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (26, 'Machine', 'Blades', 226, 57119, 0, to_date('18-02-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (27, 'Oded', 'Snipes', 336, 84523, 0, to_date('02-10-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (29, 'Peabo', 'Kline', 170, 10314, 0, to_date('02-07-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (30, 'Liam', 'Beck', 20, 61518, 0, to_date('22-04-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (31, 'Sylvester', 'May', 314, 70916, 0, to_date('01-12-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (32, 'Fisher', 'Burton', 5, 11255, 0, to_date('06-03-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (33, 'Marianne', 'Swayze', 1, 18298, 0, to_date('22-12-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (34, 'Hookah', 'Caan', 5, 84558, 0, to_date('11-04-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (35, 'Kiefer', 'Tate', 142, 24922, 0, to_date('31-03-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (37, 'Nancy', 'Leto', 251, 15622, 0, to_date('04-10-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (38, 'Larenz', 'Rodgers', 101, 64689, 0, to_date('25-03-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (39, 'Cheryl', 'Houston', 215, 47937, 0, to_date('11-08-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (40, 'Leon', 'Weber', 131, 20574, 0, to_date('19-05-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (41, 'Grant', 'May', 75, 71668, 0, to_date('01-10-1990', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (42, 'Alan', 'Browne', 195, 19950, 0, to_date('12-01-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (43, 'Bryan', 'Rippy', 275, 30948, 0, to_date('09-11-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (44, 'Lili', 'Smurfit', 221, 15821, 0, to_date('16-02-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (46, 'Dom', 'Damon', 266, 99474, 0, to_date('17-07-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (47, 'Trey', 'Carrington', 345, 73075, 0, to_date('10-10-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (48, 'Nathan', 'Carlton', 43, 13020, 0, to_date('25-01-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (49, 'Bette', 'Vance', 45, 42723, 0, to_date('07-02-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (50, 'Gladys', 'Ermey', 35, 10617, 0, to_date('07-02-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (53, 'Debbie', 'O''Neill', 95, 96438, 0, to_date('02-09-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (54, 'Lloyd', 'Capshaw', 141, 71714, 0, to_date('28-01-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (55, 'Olympia', 'Hayes', 77, 47394, 0, to_date('11-05-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (56, 'Isabella', 'Mortensen', 386, 74456, 0, to_date('17-05-1990', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (57, 'Aaron', 'Sampson', 88, 40852, 0, to_date('08-05-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (58, 'Curt', 'Gooding', 43, 20455, 0, to_date('06-08-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (59, 'Emmylou', 'Quinn', 122, 24045, 0, to_date('05-01-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (60, 'Alice', 'Brooke', 68, 23513, 0, to_date('20-08-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (61, 'LeVar', 'Savage', 66, 48999, 0, to_date('17-11-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (62, 'Madeline', 'Briscoe', 241, 77889, 0, to_date('13-05-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (63, 'Omar', 'Rhodes', 85, 80172, 0, to_date('01-03-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (64, 'Loretta', 'Hauser', 53, 27165, 0, to_date('17-07-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (65, 'Emerson', 'Matarazzo', 290, 75685, 0, to_date('27-04-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (66, 'Ricardo', 'Downey', 36, 38055, 0, to_date('17-08-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (67, 'Goldie', 'Zevon', 145, 45451, 0, to_date('23-07-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (68, 'Hope', 'Biggs', 63, 78659, 0, to_date('23-09-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (69, 'Wes', 'Nelson', 165, 81961, 0, to_date('24-09-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (70, 'Campbell', 'Gyllenhaal', 395, 73234, 0, to_date('06-04-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (71, 'Albert', 'Vannelli', 176, 22022, 0, to_date('16-06-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (72, 'Scarlett', 'Bogguss', 203, 87969, 0, to_date('19-07-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (73, 'Annette', 'Lopez', 76, 40222, 0, to_date('18-12-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (76, 'Vondie', 'Collette', 220, 42991, 0, to_date('26-10-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (77, 'Dionne', 'Carrey', 168, 79930, 377, to_date('07-08-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (78, 'Danny', 'Palin', 171, 79873, 0, to_date('04-08-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (80, 'Cherry', 'Tilly', 294, 86355, 0, to_date('26-09-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (81, 'Joe', 'Carrington', 30, 53958, 0, to_date('26-12-1970', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (82, 'Rebeka', 'Karyo', 314, 73145, 0, to_date('18-08-1974', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (83, 'Rebeka', 'Davis', 340, 23383, 0, to_date('13-04-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (84, 'Freddie', 'Crimson', 152, 57875, 0, to_date('25-11-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (85, 'Clay', 'Mahood', 125, 55568, 0, to_date('04-06-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (86, 'Rosario', 'Ali', 101, 34938, 404, to_date('01-10-1961', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (87, 'Don', 'Eat World', 31, 70840, 0, to_date('06-09-1955', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (88, 'Faye', 'Isaak', 104, 32603, 0, to_date('08-06-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (90, 'Vertical', 'Davies', 170, 84431, 0, to_date('19-07-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (91, 'Whoopi', 'Damon', 152, 71021, 0, to_date('11-01-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (92, 'Mary', 'Crudup', 8, 54533, 0, to_date('13-04-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (93, 'Ozzy', 'Sobieski', 185, 42721, 0, to_date('03-05-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (94, 'Geggy', 'Keaton', 109, 88696, 0, to_date('04-05-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (95, 'Armand', 'Langella', 283, 53852, 0, to_date('14-02-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (96, 'Kristin', 'Ingram', 157, 55908, 0, to_date('01-08-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (97, 'Jeffrey', 'Shawn', 340, 28221, 0, to_date('27-06-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (98, 'Liquid', 'Gilley', 6, 57321, 0, to_date('27-02-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (99, 'Mel', 'Lynne', 177, 45224, 0, to_date('06-12-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (100, 'Geggy', 'Gano', 94, 52166, 0, to_date('14-03-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (101, 'Azucar', 'Tierney', 20, 79540, 0, to_date('11-04-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (102, 'Betty', 'Barnett', 330, 92672, 0, to_date('17-10-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (103, 'Warren', 'Faithfull', 41, 24274, 0, to_date('02-05-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (104, 'Brenda', 'Morrison', 147, 72506, 0, to_date('10-05-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (105, 'Barry', 'Lucas', 97, 38333, 0, to_date('04-10-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (106, 'Lenny', 'Day-Lewis', 125, 75767, 0, to_date('14-01-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (107, 'Ben', 'Rucker', 142, 21299, 0, to_date('26-12-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (108, 'Max', 'McNarland', 98, 96077, 0, to_date('02-06-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (109, 'Lois', 'Tanon', 253, 11607, 0, to_date('17-08-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (111, 'Curtis', 'Stevens', 139, 86287, 0, to_date('22-04-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (112, 'Rick', 'Logue', 164, 83798, 0, to_date('14-10-1974', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (113, 'Madeline', 'Reno', 76, 73062, 0, to_date('31-03-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (114, 'Meryl', 'Gryner', 283, 57170, 0, to_date('19-07-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (116, 'Bette', 'Rhys-Davies', 317, 15798, 0, to_date('25-11-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (118, 'Victor', 'Allen', 384, 12439, 0, to_date('02-12-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (119, 'Bo', 'Langella', 286, 74157, 0, to_date('03-04-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (120, 'Lennie', 'Feuerstein', 318, 24479, 0, to_date('26-05-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (121, 'Gena', 'Leigh', 43, 51246, 0, to_date('12-10-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (123, 'Balthazar', 'Leary', 57, 81048, 0, to_date('09-03-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (124, 'Buddy', 'Banderas', 83, 83214, 0, to_date('23-05-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (125, 'Jennifer', 'McIntosh', 90, 39730, 0, to_date('14-01-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (126, 'Rachael', 'Dillane', 188, 10706, 0, to_date('27-03-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (127, 'Emily', 'Sartain', 101, 75364, 0, to_date('31-03-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (128, 'Wendy', 'Krabbe', 367, 60657, 0, to_date('31-10-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (129, 'Toshiro', 'Tomlin', 275, 16971, 0, to_date('15-09-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (130, 'Minnie', 'Abraham', 345, 84437, 0, to_date('01-06-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (131, 'Tom', 'Flanery', 196, 65462, 0, to_date('13-11-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (132, 'Melba', 'Bailey', 183, 50689, 0, to_date('24-01-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (133, 'Jean', 'Sisto', 106, 62235, 0, to_date('08-09-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (135, 'Randall', 'Belle', 129, 53726, 0, to_date('24-10-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (137, 'Louise', 'Holliday', 188, 32690, 0, to_date('29-06-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (138, 'Emm', 'Jordan', 44, 15464, 100, to_date('10-12-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (140, 'Marianne', 'Kahn', 90, 79192, 200, to_date('23-02-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (141, 'Amanda', 'Payton', 194, 69137, 0, to_date('03-03-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (142, 'Cathy', 'Shannon', 395, 21211, 0, to_date('02-01-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (143, 'Terry', 'Lipnicki', 72, 12525, 0, to_date('01-08-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (144, 'Bo', 'Griffin', 350, 69772, 0, to_date('28-12-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (145, 'Will', 'Connery', 157, 72349, 0, to_date('09-05-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (146, 'Kazem', 'Ramis', 222, 96023, 0, to_date('30-08-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (148, 'Leon', 'Wood', 383, 46417, 0, to_date('14-07-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (149, 'Samuel', 'Hannah', 294, 40052, 0, to_date('11-06-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (151, 'Lili', 'Ricci', 211, 67627, 0, to_date('27-11-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (152, 'Joe', 'Meniketti', 251, 75132, 0, to_date('02-03-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (153, 'Jean-Claude', 'Gatlin', 144, 94516, 0, to_date('22-11-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (154, 'Mike', 'Coleman', 270, 12627, 0, to_date('22-02-1970', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (155, 'Albert', 'Boothe', 369, 22221, 0, to_date('16-05-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (156, 'Christian', 'Benet', 376, 24916, 0, to_date('02-06-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (157, 'Cesar', 'Ermey', 245, 20780, 0, to_date('25-08-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (158, 'Chrissie', 'Rodgers', 345, 53187, 200, to_date('16-07-1979', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (159, 'Avril', 'Tomlin', 35, 70616, 0, to_date('23-06-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (160, 'Ani', 'Aaron', 28, 27086, 0, to_date('24-04-1970', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (162, 'Dick', 'Botti', 379, 83984, 0, to_date('19-06-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (163, 'Anita', 'Frakes', 258, 79886, 0, to_date('20-05-1990', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (165, 'Sam', 'Dillon', 11, 16423, 0, to_date('01-10-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (166, 'Ossie', 'Joli', 386, 56299, 0, to_date('01-05-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (167, 'Gilbert', 'Baranski', 58, 41911, 0, to_date('19-12-1957', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (168, 'Ernie', 'Hewitt', 42, 50698, 0, to_date('27-12-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (169, 'Amy', 'DiBiasio', 100, 12482, 0, to_date('05-01-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (170, 'Larry', 'Morales', 369, 29127, 0, to_date('06-11-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (171, 'Cheech', 'Bugnon', 25, 81295, 0, to_date('12-09-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (172, 'Debra', 'Fogerty', 130, 98946, 0, to_date('18-09-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (174, 'Maxine', 'Condition', 48, 40684, 0, to_date('10-05-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (175, 'Wesley', 'Judd', 54, 63894, 0, to_date('19-08-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (176, 'Paul', 'Yankovic', 48, 41199, 0, to_date('18-08-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (177, 'Geoffrey', 'Barnett', 350, 46635, 0, to_date('18-04-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (178, 'Cheryl', 'Manning', 110, 75534, 0, to_date('13-04-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (179, 'Allan', 'Pride', 4, 65983, 0, to_date('30-06-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (180, 'Stellan', 'Levert', 9, 36970, 0, to_date('19-08-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (181, 'Bo', 'Thewlis', 9, 38160, 0, to_date('15-04-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (183, 'Emm', 'Woods', 75, 84035, 0, to_date('15-12-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (184, 'Lauren', 'Atkins', 23, 52110, 0, to_date('21-02-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (185, 'Caroline', 'Woodward', 29, 36253, 0, to_date('28-11-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (186, 'Lin', 'Bruce', 350, 87256, 377, to_date('26-02-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (187, 'Lionel', 'Newman', 121, 65136, 0, to_date('19-12-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (188, 'Olympia', 'Walker', 272, 87501, 0, to_date('30-04-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (189, 'King', 'Hatfield', 12, 79121, 0, to_date('05-05-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (190, 'Anthony', 'Morrison', 146, 87907, 0, to_date('31-03-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (191, 'Ewan', 'Frost', 277, 78017, 0, to_date('08-04-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (192, 'Anjelica', 'Place', 189, 53369, 0, to_date('20-07-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (193, 'Matt', 'Steenburgen', 5, 59872, 0, to_date('16-09-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (195, 'Alfie', 'Sorvino', 120, 84716, 167, to_date('24-12-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (196, 'Maury', 'Berenger', 274, 99229, 0, to_date('07-11-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (197, 'Fred', 'Colin Young', 221, 40982, 0, to_date('05-10-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (198, 'Rosanne', 'DeGraw', 189, 92772, 0, to_date('27-01-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (200, 'Franco', 'Weller', 237, 49452, 0, to_date('14-08-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (201, 'Anthony', 'Gatlin', 83, 79399, 0, to_date('04-09-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (203, 'Tracy', 'Cervine', 189, 88585, 351, to_date('04-09-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (204, 'Andre', 'Whitmore', 253, 14452, 0, to_date('01-05-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (206, 'Mac', 'Diaz', 314, 19217, 0, to_date('18-04-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (207, 'Terry', 'Evett', 131, 20053, 0, to_date('23-02-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (208, 'Patrick', 'Eastwood', 157, 17505, 0, to_date('21-06-1990', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (209, 'Mary-Louise', 'Diehl', 29, 13234, 0, to_date('19-07-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (210, 'Mekhi', 'Boorem', 24, 84032, 0, to_date('19-03-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (212, 'Jason', 'Davison', 154, 77193, 304, to_date('18-07-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (213, 'Gladys', 'Ferrell', 161, 29515, 0, to_date('30-11-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (214, 'Kurtwood', 'Overstreet', 286, 19529, 0, to_date('05-08-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (215, 'Belinda', 'Gyllenhaal', 247, 88663, 0, to_date('23-03-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (216, 'Lynette', 'Kier', 259, 25464, 0, to_date('19-03-1961', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (218, 'Loretta', 'Garfunkel', 154, 53345, 0, to_date('17-05-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (219, 'Paula', 'Collie', 43, 42889, 0, to_date('10-11-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (220, 'Warren', 'Neville', 57, 51330, 0, to_date('31-07-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (221, 'Larry', 'Neil', 53, 60506, 0, to_date('09-10-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (222, 'Colm', 'Neil', 57, 99132, 0, to_date('09-11-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (223, 'Caroline', 'Ruiz', 324, 68475, 0, to_date('24-07-1970', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (224, 'Loren', 'McCabe', 395, 80179, 0, to_date('27-07-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (226, 'Remy', 'Diddley', 152, 61188, 0, to_date('26-08-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (227, 'Clarence', 'Idle', 39, 98674, 0, to_date('04-09-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (229, 'Breckin', 'Thorton', 125, 77289, 0, to_date('06-07-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (231, 'Tori', 'Coleman', 19, 93112, 0, to_date('01-02-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (232, 'Hugh', 'McDormand', 394, 65543, 0, to_date('28-06-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (235, 'Fionnula', 'Kahn', 177, 45699, 0, to_date('30-01-1951', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (236, 'Sander', 'Law', 195, 67320, 0, to_date('17-09-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (239, 'Karen', 'Swayze', 45, 43161, 0, to_date('30-04-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (240, 'Etta', 'Fender', 74, 40614, 0, to_date('18-10-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (241, 'Boyd', 'Tolkan', 271, 11959, 0, to_date('01-02-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (242, 'Donald', 'Rowlands', 143, 52348, 0, to_date('05-10-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (243, 'Jonatha', 'Skaggs', 231, 14203, 0, to_date('03-01-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (245, 'Kirk', 'Zahn', 389, 56743, 0, to_date('12-05-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (246, 'Ethan', 'Glenn', 274, 65564, 0, to_date('10-06-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (247, 'Albertina', 'Giamatti', 396, 69294, 0, to_date('15-01-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (248, 'Meredith', 'Bruce', 79, 87741, 0, to_date('17-10-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (249, 'Nickel', 'Short', 49, 89387, 0, to_date('27-07-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (250, 'Ronnie', 'Heron', 386, 72351, 0, to_date('01-04-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (251, 'Rachael', 'Stiller', 167, 81075, 0, to_date('07-06-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (252, 'Harold', 'Gleeson', 114, 79265, 0, to_date('22-02-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (253, 'Hilton', 'Arthur', 333, 13187, 0, to_date('11-02-1998', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (254, 'Mac', 'Thomson', 245, 93632, 0, to_date('11-05-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (255, 'Vern', 'Ferrer', 167, 35397, 0, to_date('21-10-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (256, 'Kenny', 'Skerritt', 296, 70691, 0, to_date('23-11-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (258, 'Giancarlo', 'Ferrer', 247, 80506, 0, to_date('28-05-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (259, 'Art', 'Spacek', 371, 72980, 0, to_date('22-12-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (260, 'Heather', 'Costner', 16, 42170, 0, to_date('19-10-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (261, 'Nicholas', 'Witherspoon', 10, 89220, 0, to_date('17-04-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (263, 'Cate', 'Colton', 188, 41695, 0, to_date('12-09-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (264, 'Debbie', 'Maxwell', 283, 22769, 0, to_date('02-04-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (265, 'Penelope', 'Tennison', 162, 93864, 0, to_date('07-05-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (267, 'Brian', 'Hewitt', 270, 89482, 0, to_date('17-07-1964', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (268, 'Patricia', 'Deschanel', 189, 71662, 0, to_date('26-01-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (269, 'Bonnie', 'Church', 269, 25307, 0, to_date('25-04-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (270, 'Patricia', 'McDormand', 55, 38033, 0, to_date('03-06-1974', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (271, 'Pelvic', 'Hagar', 42, 47875, 0, to_date('15-11-1961', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (272, 'Sinead', 'Holeman', 95, 84948, 237, to_date('19-05-1990', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (273, 'Cyndi', 'Hughes', 249, 15126, 0, to_date('23-05-1970', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (275, 'Lily', 'Sample', 159, 36172, 0, to_date('16-12-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (277, 'Peter', 'Oldman', 29, 94971, 377, to_date('02-03-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (278, 'Nikki', 'Yorn', 290, 64089, 0, to_date('16-08-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (279, 'Jimmy', 'McCracken', 291, 36212, 0, to_date('19-03-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (280, 'Vince', 'Garfunkel', 307, 83991, 0, to_date('12-10-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (281, 'Terence', 'Oszajca', 285, 44163, 0, to_date('02-12-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (282, 'Marty', 'Calle', 249, 58228, 0, to_date('13-09-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (284, 'Loren', 'Langella', 129, 86666, 0, to_date('23-06-1997', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (285, 'Keanu', 'Robinson', 114, 97916, 0, to_date('11-01-1979', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (286, 'Laura', 'Quinones', 174, 10673, 0, to_date('30-03-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (288, 'Tim', 'Whitman', 37, 10578, 0, to_date('21-07-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (289, 'Tim', 'Keaton', 25, 86189, 0, to_date('22-07-1961', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (293, 'Steven', 'Damon', 266, 63153, 0, to_date('21-11-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (294, 'Stockard', 'Garr', 90, 97044, 0, to_date('17-02-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (295, 'Jody', 'Cattrall', 76, 80144, 0, to_date('09-04-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (296, 'Morris', 'Judd', 179, 47429, 0, to_date('22-01-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (297, 'Adrien', 'Duchovny', 60, 87291, 0, to_date('24-07-1957', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (298, 'Halle', 'Tripplehorn', 306, 25038, 0, to_date('31-08-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (300, 'Alana', 'Pullman', 171, 44089, 0, to_date('13-02-1998', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (301, 'Cherry', 'Langella', 179, 52123, 0, to_date('04-03-1964', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (302, 'Jeroen', 'Lowe', 62, 46851, 0, to_date('05-08-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (303, 'Tom', 'Campbell', 65, 61354, 0, to_date('23-12-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (305, 'Nastassja', 'Irving', 41, 17550, 0, to_date('11-06-1957', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (306, 'Gaby', 'von Sydow', 211, 64254, 0, to_date('09-06-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (307, 'Bernie', 'Karyo', 73, 32507, 0, to_date('20-03-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (308, 'Stanley', 'Weber', 10, 20741, 0, to_date('31-12-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (309, 'Ice', 'Daniels', 121, 51827, 0, to_date('18-05-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (310, 'Kathleen', 'Carr', 177, 16246, 370, to_date('08-01-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (311, 'Vonda', 'Bacon', 201, 22199, 0, to_date('30-01-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (312, 'Bridget', 'Sellers', 264, 61762, 0, to_date('26-07-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (313, 'Hector', 'Neil', 107, 34164, 0, to_date('02-08-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (314, 'Marina', 'Love', 248, 37431, 0, to_date('01-03-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (315, 'Lin', 'Torn', 48, 53631, 0, to_date('29-08-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (318, 'Laura', 'Pryce', 211, 82022, 0, to_date('06-07-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (320, 'Christmas', 'Parker', 267, 88015, 0, to_date('27-01-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (321, 'Holly', 'Ball', 308, 14577, 0, to_date('16-11-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (322, 'Sylvester', 'Palmieri', 297, 93472, 0, to_date('08-07-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (323, 'Juliana', 'Lunch', 201, 90017, 0, to_date('05-12-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (324, 'Steven', 'Jamal', 286, 57402, 0, to_date('09-08-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (325, 'Millie', 'Myers', 179, 97963, 517, to_date('06-08-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (326, 'Rascal', 'Mifune', 58, 89728, 0, to_date('28-06-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (327, 'Cary', 'Cale', 202, 72492, 0, to_date('20-05-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (328, 'Tommy', 'Arquette', 53, 18323, 0, to_date('22-07-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (329, 'Adam', 'Perez', 30, 79601, 0, to_date('01-05-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (330, 'Rosario', 'Herrmann', 367, 74105, 0, to_date('28-10-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (331, 'Peabo', 'Sanders', 400, 16936, 0, to_date('10-09-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (332, 'Denzel', 'Sarsgaard', 176, 23712, 0, to_date('27-01-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (333, 'Kazem', 'Robards', 123, 44302, 0, to_date('18-07-1998', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (334, 'Molly', 'Lopez', 147, 41798, 0, to_date('30-04-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (335, 'Lorraine', 'Rhymes', 158, 43256, 0, to_date('05-05-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (336, 'Domingo', 'McCracken', 142, 67489, 0, to_date('03-12-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (337, 'Kirsten', 'Sinatra', 220, 36543, 0, to_date('19-09-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (338, 'Marley', 'Morrison', 217, 82004, 0, to_date('05-09-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (339, 'Mira', 'Dooley', 380, 10679, 0, to_date('16-07-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (340, 'Avril', 'Coltrane', 234, 77005, 0, to_date('09-07-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (341, 'Carla', 'Shaye', 202, 37437, 0, to_date('13-07-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (342, 'Mark', 'Lipnicki', 274, 35679, 0, to_date('31-12-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (343, 'Isabella', 'Strathairn', 96, 82540, 0, to_date('15-06-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (344, 'Rosie', 'Kenoly', 173, 91103, 0, to_date('23-01-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (345, 'Holland', 'Coward', 13, 82330, 0, to_date('04-03-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (346, 'Mickey', 'Washington', 185, 58915, 0, to_date('27-07-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (347, 'Brendan', 'Vassar', 369, 81691, 0, to_date('01-08-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (348, 'Judy', 'Clarkson', 71, 83815, 0, to_date('23-10-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (349, 'Marc', 'Liotta', 129, 69025, 0, to_date('01-10-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (350, 'Greg', 'Pollack', 23, 21948, 0, to_date('29-08-1955', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (351, 'Connie', 'Sizemore', 325, 66536, 0, to_date('22-03-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (352, 'Roscoe', 'Webb', 132, 63674, 0, to_date('22-06-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (354, 'Xander', 'Klugh', 9, 83782, 0, to_date('27-06-1971', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (355, 'Humberto', 'Molina', 113, 57691, 0, to_date('06-02-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (357, 'Etta', 'Lucien', 337, 45029, 0, to_date('17-03-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (358, 'Mint', 'Carradine', 394, 12445, 0, to_date('20-04-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (359, 'Maggie', 'Humphrey', 383, 85271, 0, to_date('06-02-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (361, 'Miguel', 'Rourke', 23, 14983, 150, to_date('07-07-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (362, 'Vondie', 'Myers', 56, 40870, 0, to_date('01-08-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (364, 'Debby', 'Levy', 337, 72143, 0, to_date('22-08-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (365, 'Olympia', 'Shannon', 212, 38847, 0, to_date('06-05-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (366, 'Russell', 'Loggins', 226, 18394, 0, to_date('18-05-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (367, 'Judge', 'Chaykin', 65, 65739, 0, to_date('27-02-1963', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (368, 'Denise', 'McConaughey', 61, 67044, 0, to_date('06-12-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (370, 'Paula', 'Watley', 143, 97893, 0, to_date('08-10-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (371, 'Emmylou', 'Secada', 385, 90659, 0, to_date('10-03-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (372, 'Boz', 'Portman', 77, 69120, 0, to_date('13-01-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (373, 'Rene', 'Travers', 310, 94428, 0, to_date('02-09-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (374, 'Dylan', 'Cruz', 222, 78529, 0, to_date('04-06-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (375, 'Sarah', 'Lynch', 45, 25017, 0, to_date('30-08-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (376, 'Clint', 'Johnson', 355, 84564, 0, to_date('30-08-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (377, 'Jude', 'Apple', 205, 54100, 0, to_date('15-10-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (378, 'Sander', 'Turturro', 364, 14136, 237, to_date('06-05-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (379, 'Trini', 'Kutcher', 18, 87568, 0, to_date('22-09-1964', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (380, 'Rip', 'Savage', 268, 16786, 0, to_date('27-03-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (381, 'Parker', 'Diggs', 189, 29409, 0, to_date('22-05-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (382, 'Alfred', 'Ronstadt', 175, 17218, 0, to_date('02-09-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (383, 'Albert', 'Lerner', 100, 53400, 0, to_date('29-09-1977', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (384, 'Peter', 'Anderson', 80, 80730, 0, to_date('14-04-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (385, 'Bridgette', 'Keaton', 88, 23413, 0, to_date('12-09-1997', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (386, 'Remy', 'Ripley', 318, 68582, 0, to_date('22-08-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (388, 'Christine', 'Studi', 361, 52817, 0, to_date('22-12-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (389, 'Ellen', 'Kilmer', 229, 48228, 0, to_date('04-01-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (390, 'James', 'Badalucco', 191, 12589, 0, to_date('06-09-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (391, 'Mac', 'Moreno', 141, 27517, 0, to_date('01-01-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (392, 'Nicole', 'McGovern', 125, 56506, 0, to_date('24-09-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (394, 'Leelee', 'Evett', 326, 98035, 0, to_date('13-08-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (395, 'Ron', 'Avital', 31, 65713, 0, to_date('14-03-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (396, 'Andrew', 'Crouse', 91, 93493, 0, to_date('14-01-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (397, 'Marisa', 'Robards', 259, 95258, 0, to_date('26-12-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (398, 'Lennie', 'Rawls', 317, 84655, 0, to_date('24-12-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (399, 'Merle', 'Holliday', 32, 43461, 0, to_date('14-02-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (400, 'Marley', 'Marx', 274, 30520, 0, to_date('19-04-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (401, 'Jay', 'Marshall', 145, 36000, 0, to_date('09-05-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (402, 'Desmond', 'O''Donnell', 266, 65249, 0, to_date('03-07-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (403, 'Bridget', 'Bedelia', 296, 54918, 0, to_date('04-12-1957', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (404, 'Sammy', 'Wiedlin', 299, 41823, 0, to_date('20-11-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (405, 'Kris', 'Chan', 183, 17928, 0, to_date('02-05-1989', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (406, 'Stellan', 'Hutton', 164, 33439, 0, to_date('02-09-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (407, 'Meg', 'Postlethwaite', 216, 39914, 0, to_date('10-07-1998', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (408, 'Jeffery', 'Connick', 35, 67192, 0, to_date('08-04-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (409, 'Jet', 'Blanchett', 183, 17413, 0, to_date('11-01-1961', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (410, 'Leonardo', 'Diaz', 389, 87047, 100, to_date('06-06-1997', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (411, 'Marc', 'Bell', 327, 39357, 0, to_date('21-12-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (412, 'Connie', 'Coburn', 162, 85668, 0, to_date('13-04-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (413, 'James', 'Reynolds', 202, 89848, 0, to_date('07-04-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (414, 'Rebecca', 'Diggs', 133, 97099, 0, to_date('17-01-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (415, 'Lois', 'Wilder', 344, 51270, 0, to_date('16-12-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (416, 'Andrew', 'Garfunkel', 258, 34857, 0, to_date('13-07-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (417, 'Franco', 'Bracco', 336, 48489, 0, to_date('27-02-1992', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (420, 'Harry', 'Garcia', 13, 95870, 0, to_date('25-11-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (421, 'Heath', 'DeGraw', 242, 93935, 0, to_date('18-10-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (423, 'Benjamin', 'Levy', 294, 10760, 0, to_date('26-02-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (424, 'Rhona', 'Horizon', 367, 83893, 0, to_date('18-03-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (426, 'Laurence', 'Faithfull', 231, 80807, 0, to_date('08-02-1998', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (427, 'Louise', 'Williamson', 376, 53025, 0, to_date('27-12-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (428, 'Will', 'Holbrook', 170, 14373, 0, to_date('22-12-1988', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (429, 'Eddie', 'Weller', 178, 25538, 0, to_date('21-05-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (430, 'Ozzy', 'Molina', 134, 11099, 0, to_date('18-11-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (431, 'Giovanni', 'Vince', 1, 93580, 237, to_date('10-06-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (434, 'Tanya', 'Quinones', 165, 49904, 0, to_date('13-03-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (435, 'Laurence', 'Capshaw', 19, 68426, 0, to_date('03-01-1976', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (436, 'Jim', 'Mandrell', 159, 62349, 0, to_date('30-11-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (437, 'Patti', 'Hynde', 58, 75563, 0, to_date('25-07-1980', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (439, 'Glen', 'Gibson', 79, 70013, 0, to_date('11-05-1952', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (440, 'Cate', 'Flack', 132, 86537, 0, to_date('13-04-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (441, 'Gates', 'Manning', 347, 62710, 0, to_date('02-01-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (442, 'Hugh', 'Wheel', 363, 34106, 0, to_date('02-04-1973', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (444, 'Lydia', 'Vaughan', 337, 48324, 0, to_date('30-11-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (445, 'Gordie', 'Lonsdale', 330, 73595, 0, to_date('19-07-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (447, 'Rickie', 'Pleasure', 49, 98554, 0, to_date('21-04-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (448, 'Alice', 'Morton', 113, 24229, 0, to_date('25-09-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (449, 'Cary', 'Torres', 25, 57925, 0, to_date('14-06-1999', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (451, 'Gavin', 'Swank', 12, 89479, 0, to_date('08-01-1991', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (455, 'Dermot', 'Cole', 160, 79036, 0, to_date('18-02-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (458, 'Crispin', 'Secada', 125, 26891, 0, to_date('28-09-1995', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (459, 'Eddie', 'Skaggs', 217, 70580, 0, to_date('23-02-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (460, 'Meredith', 'Williamson', 212, 53895, 0, to_date('01-09-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (462, 'Kasey', 'Stormare', 293, 40743, 0, to_date('28-04-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (463, 'Burton', 'Garber', 17, 85756, 0, to_date('21-10-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (464, 'Percy', 'Cleary', 71, 39431, 0, to_date('19-09-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (465, 'Orlando', 'Pride', 228, 62012, 0, to_date('13-02-1993', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (466, 'Rhett', 'Holiday', 320, 50187, 0, to_date('28-08-1971', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (467, 'Frances', 'Humphrey', 361, 48654, 0, to_date('12-03-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (468, 'Emm', 'Griggs', 217, 40436, 150, to_date('14-06-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (469, 'Anthony', 'Weiss', 274, 17459, 0, to_date('26-11-1956', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (470, 'Cevin', 'Suchet', 289, 66511, 0, to_date('02-08-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (471, 'Roy', 'McGriff', 4, 80598, 0, to_date('30-12-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (472, 'April', 'Redgrave', 71, 32647, 0, to_date('08-08-1964', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (473, 'Isaiah', 'Van Der Beek', 398, 32929, 0, to_date('25-04-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (475, 'Maria', 'Folds', 354, 35553, 0, to_date('28-10-1957', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (477, 'Karen', 'Ford', 36, 96401, 0, to_date('24-11-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (478, 'Terri', 'Yulin', 231, 20267, 0, to_date('14-05-1986', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (479, 'Robert', 'King', 312, 76160, 0, to_date('25-09-1959', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (480, 'Fred', 'Supernaw', 393, 79518, 0, to_date('04-12-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (482, 'Ellen', 'Hanley', 204, 18226, 0, to_date('12-04-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (483, 'Steven', 'Tomlin', 22, 40400, 0, to_date('30-10-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (484, 'Nelly', 'King', 95, 35103, 0, to_date('06-09-1979', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (485, 'Davy', 'Murphy', 283, 10886, 0, to_date('25-12-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (486, 'Rich', 'Duschel', 348, 39005, 0, to_date('12-12-1987', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (488, 'Cate', 'Briscoe', 324, 89250, 0, to_date('15-03-1969', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (489, 'Swoosie', 'Spall', 330, 28518, 0, to_date('02-12-1966', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (490, 'Walter', 'Farris', 60, 86491, 0, to_date('11-09-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (491, 'Joan', 'Posener', 135, 52723, 0, to_date('22-10-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (494, 'Earl', 'Kattan', 312, 79105, 0, to_date('19-01-1982', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (495, 'Norm', 'Keitel', 224, 92145, 0, to_date('29-05-1984', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (496, 'Mitchell', 'Playboys', 350, 56214, 0, to_date('25-10-1967', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (497, 'Penelope', 'Brando', 79, 41075, 0, to_date('11-03-1986', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (498, 'Collective', 'Crewson', 107, 86929, 0, to_date('09-03-1951', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (499, 'Frances', 'Molina', 229, 25573, 0, to_date('02-10-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (500, 'Vincent', 'Lewin', 333, 88319, 0, to_date('02-05-1965', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (501, 'Giancarlo', 'Cassel', 68, 66245, 0, to_date('23-05-1960', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (502, 'Tom', 'Taha', 55, 34458, 0, to_date('01-07-1996', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (504, 'Debi', 'Oldman', 173, 88071, 0, to_date('18-08-1968', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (506, 'Charlie', 'Branch', 272, 38982, 0, to_date('02-05-1950', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (507, 'Coley', 'Cooper', 35, 38651, 0, to_date('10-09-1978', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (508, 'Jodie', 'Portman', 370, 58902, 0, to_date('15-04-1994', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (509, 'Ani', 'Blanchett', 83, 26519, 0, to_date('27-06-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (510, 'Bo', 'Coward', 203, 34588, 0, to_date('19-10-1981', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (600, 'Kalvin', 'Kleine', 1, 55121, 0, to_date('04-01-1962', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (601, 'Rickie', 'Stembridge', 2, 12927, 100, to_date('23-09-1974', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (602, 'Delora', 'De Paoli', 3, 38602, 0, to_date('22-02-1953', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (603, 'Malvina', 'Bouts', 4, 35225, 0, to_date('12-05-1983', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (604, 'Tracie', 'Hopkyns', 5, 39920, 0, to_date('04-05-1954', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (605, 'Maitilde', 'Renoden', 6, 75971, 0, to_date('24-12-1972', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (606, 'Ainsley', 'Merrydew', 7, 30226, 0, to_date('04-06-1958', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (607, 'Darrell', 'Lawles', 8, 27046, 0, to_date('09-12-1985', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (608, 'Steward', 'Rubra', 9, 65288, 0, to_date('25-08-1975', 'dd-mm-yyyy'));
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date)
values (609, 'Patrica', 'Morshead', 10, 48871, 0, to_date('13-12-1961', 'dd-mm-yyyy'));
commit;
prompt 436 records loaded
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
values (17, 4, 5, 5, 5, 7, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 9, 9, 9, 8, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 1, 14, 469, 1, 380, 195);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 86, 405, 10, 33, 77);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 3, 190, 156, 5, 445, 310);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 7, 204, 60, 8, 278, 212);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 2, 214, 224, 14, 442, 468);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 4, 226, 17, 10, 78, 277);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 269, 206, 2, 35, 431);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 279, 213, 1, 268, 86);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 7, 321, 498, 2, 306, 272);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 7, 332, 379, 10, 467, 186);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 7, 395, 236, 14, 273, 361);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1695, 284, 10, 472, 609);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 1696, 88, 11, 139, 315);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1697, 23, 3, 345, 219);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1698, 157, 5, 365, 483);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 1699, 212, 7, 45, 423);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1700, 394, 6, 219, 508);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1701, 338, 6, 87, 364);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 1702, 494, 1, 268, 412);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1703, 230, 1, 322, 214);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 1704, 85, 14, 224, 329);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1705, 258, 1, 15, 141);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1706, 98, 13, 123, 185);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1707, 144, 1, 478, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1708, 272, 14, 154, 416);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 1709, 416, 4, 83, 171);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 1710, 341, 13, 57, 380);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1711, 26, 13, 474, 87);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 1712, 196, 5, 243, 92);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 1, 1713, 436, 7, 175, 119);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1714, 360, 5, 191, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1715, 152, 6, 473, 184);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 6, 1716, 63, 1, 463, 98);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 4, 1022, 150, 2, 384, 86);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1717, 289, 12, 181, 496);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 5, 1718, 335, 6, 30, 248);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 1719, 418, 8, 338, 464);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 1, 1720, 157, 6, 108, 372);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 5, 1721, 26, 2, 286, 471);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1722, 323, 9, 320, 197);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 4, 1723, 80, 4, 323, 193);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 1724, 320, 11, 178, 208);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 6, 1725, 288, 4, 276, 95);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1726, 121, 7, 101, 263);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 6, 1727, 286, 1, 265, 510);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 3, 1728, 450, 10, 447, 507);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1729, 104, 1, 403, 11);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1730, 163, 6, 158, 378);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 1731, 385, 12, 339, 332);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1732, 45, 4, 381, 69);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 5, 1733, 462, 14, 242, 284);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 1734, 444, 14, 137, 434);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1735, 16, 4, 311, 484);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1736, 261, 11, 350, 308);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 4, 1737, 169, 10, 133, 495);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 4, 1738, 481, 9, 21, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 1739, 484, 12, 358, 602);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1740, 18, 9, 60, 275);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 1741, 486, 7, 96, 449);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 6, 1742, 301, 6, 369, 43);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1743, 409, 4, 390, 447);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1744, 128, 10, 335, 112);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1745, 48, 7, 321, 84);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 4, 1052, 169, 2, 386, 378);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 5, 1746, 461, 3, 289, 400);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 6, 1747, 164, 10, 415, 97);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1748, 453, 2, 89, 124);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 1749, 66, 10, 150, 494);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1750, 102, 4, 283, 270);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 3, 1751, 87, 5, 439, 58);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 1752, 103, 11, 209, 305);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 1753, 305, 7, 154, 471);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 1754, 28, 2, 291, 149);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1755, 484, 10, 387, 281);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 1, 1756, 154, 14, 79, 279);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 1757, 348, 12, 159, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 4, 1758, 324, 10, 49, 71);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 1759, 399, 1, 63, 395);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 1760, 406, 11, 507, 242);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1761, 142, 1, 374, 334);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 1, 1762, 499, 10, 251, 298);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 1764, 171, 14, 316, 149);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 1765, 320, 10, 494, 272);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 1, 1766, 164, 4, 427, 379);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1767, 327, 5, 228, 114);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 4, 1768, 84, 14, 353, 451);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 6, 1769, 310, 1, 382, 373);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 6, 1770, 242, 7, 167, 218);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 1, 1771, 89, 8, 283, 240);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 1772, 457, 11, 140, 61);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 6, 1773, 222, 7, 262, 174);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 2, 1774, 203, 3, 122, 482);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 5, 1775, 393, 7, 357, 416);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1776, 160, 4, 424, 12);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 6, 1777, 14, 11, 437, 449);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1778, 336, 3, 231, 298);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 4, 1779, 19, 1, 114, 14);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1780, 27, 11, 397, 196);
commit;
prompt 100 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1781, 449, 13, 20, 337);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 4, 1782, 53, 14, 278, 128);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 3, 1783, 64, 4, 21, 130);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 2, 1784, 300, 1, 309, 235);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 1, 1785, 319, 4, 284, 407);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 1786, 221, 4, 221, 336);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1787, 192, 14, 503, 431);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 1788, 106, 6, 284, 153);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1789, 462, 8, 399, 170);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1791, 160, 13, 119, 171);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1792, 459, 8, 447, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 1793, 55, 1, 334, 374);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1099, 234, 3, 280, 203);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1794, 357, 3, 425, 155);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 1, 1795, 131, 1, 395, 609);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 6, 1796, 296, 13, 312, 502);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 5, 1797, 188, 5, 226, 320);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 1798, 264, 14, 320, 236);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 5, 1799, 260, 5, 487, 196);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1800, 44, 7, 506, 82);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 1801, 224, 9, 292, 601);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1802, 381, 4, 15, 135);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 1, 1803, 70, 5, 45, 242);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1804, 222, 11, 175, 215);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 3, 1805, 431, 4, 254, 285);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1806, 436, 2, 58, 275);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1807, 104, 14, 56, 462);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 4, 1808, 67, 11, 306, 298);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 2, 1809, 408, 1, 339, 275);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 6, 1810, 264, 4, 13, 195);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 6, 1811, 361, 11, 160, 329);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1812, 197, 3, 178, 397);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1813, 277, 14, 258, 344);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1814, 359, 7, 280, 142);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 6, 1815, 7, 1, 72, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1816, 302, 12, 233, 336);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1817, 173, 5, 269, 302);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 6, 1818, 462, 9, 136, 364);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 1, 1819, 380, 11, 17, 440);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 1820, 371, 1, 125, 83);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 1821, 500, 1, 220, 241);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1822, 169, 10, 140, 384);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1823, 260, 8, 177, 92);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 1, 1824, 443, 4, 123, 186);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1825, 478, 6, 162, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 5, 1826, 80, 5, 228, 260);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1827, 434, 1, 172, 17);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1828, 395, 14, 245, 475);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1829, 467, 14, 482, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 1, 1830, 475, 6, 147, 123);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 4, 1831, 35, 5, 98, 359);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1832, 258, 7, 189, 196);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 4, 1833, 76, 1, 27, 176);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 2, 1834, 21, 6, 164, 210);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 6, 1835, 164, 7, 71, 99);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1836, 67, 2, 71, 271);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 5, 1837, 47, 4, 380, 267);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1838, 15, 7, 30, 232);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 6, 1839, 295, 2, 313, 92);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 1, 1840, 244, 3, 412, 54);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 4, 1841, 426, 4, 478, 311);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 6, 1842, 149, 6, 267, 215);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 3, 1843, 457, 8, 246, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 6, 1844, 500, 12, 390, 407);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 6, 1845, 14, 7, 442, 428);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 6, 1153, 416, 11, 185, 158);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 6, 1846, 315, 8, 172, 231);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 1847, 201, 7, 174, 129);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 1848, 287, 13, 446, 367);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 1849, 96, 2, 339, 259);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 3, 1158, 358, 7, 221, 325);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1850, 438, 1, 191, 508);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 1851, 346, 3, 440, 209);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1852, 268, 1, 84, 430);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 1, 1853, 457, 6, 506, 44);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1854, 340, 10, 495, 407);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 1855, 12, 3, 107, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 1856, 318, 9, 34, 128);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 1857, 171, 9, 375, 398);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 6, 1858, 135, 11, 356, 606);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 1859, 422, 13, 269, 44);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 2, 1860, 68, 1, 115, 84);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 1861, 183, 12, 392, 108);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1862, 155, 3, 362, 300);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1863, 498, 14, 238, 359);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 1864, 465, 6, 443, 380);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 5, 1865, 158, 4, 392, 365);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1866, 411, 3, 322, 609);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 1, 1867, 234, 10, 408, 56);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1868, 376, 9, 372, 391);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 4, 1869, 125, 14, 58, 271);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 1870, 79, 7, 14, 248);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 6, 1871, 344, 11, 43, 38);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 6, 1872, 213, 10, 283, 63);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 1873, 391, 11, 416, 385);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1874, 21, 13, 221, 63);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1875, 201, 6, 198, 236);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 1876, 100, 3, 80, 54);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1877, 247, 5, 274, 124);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 3, 1878, 341, 6, 474, 448);
commit;
prompt 200 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 1879, 53, 10, 41, 101);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 1880, 59, 4, 11, 227);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 3, 1881, 442, 1, 340, 35);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 6, 1882, 460, 10, 156, 104);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 2, 1884, 239, 13, 258, 141);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 6, 1885, 452, 10, 227, 59);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1194, 403, 12, 79, 138);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1886, 237, 6, 390, 413);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1887, 357, 2, 419, 449);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 1888, 169, 6, 293, 435);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 3, 1889, 21, 9, 87, 59);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1890, 114, 7, 103, 428);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 2, 1891, 51, 3, 62, 21);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 5, 1892, 41, 6, 55, 5);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1893, 487, 6, 232, 488);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 5, 1894, 288, 1, 21, 83);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 1895, 122, 12, 173, 95);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1896, 33, 12, 391, 330);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 3, 1897, 387, 6, 278, 86);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 1898, 424, 8, 324, 201);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1899, 265, 12, 211, 472);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 1900, 153, 6, 220, 371);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 3, 1901, 348, 3, 362, 56);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 1902, 391, 13, 118, 338);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 2, 1903, 252, 13, 329, 85);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 4, 1904, 122, 12, 98, 187);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 6, 1905, 252, 12, 349, 484);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 1906, 36, 5, 253, 95);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 1907, 111, 6, 474, 242);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 5, 1908, 283, 4, 461, 315);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 4, 1909, 190, 8, 96, 126);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 2, 1910, 482, 9, 305, 460);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1911, 97, 14, 20, 130);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 2, 1912, 45, 3, 156, 480);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 4, 1913, 190, 14, 247, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1914, 463, 14, 441, 219);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 1915, 438, 14, 503, 384);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 6, 1916, 355, 4, 363, 367);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 2, 1917, 230, 6, 11, 366);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 5, 1918, 187, 14, 506, 235);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 5, 1919, 360, 1, 217, 488);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 3, 1920, 204, 11, 122, 256);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 1921, 36, 8, 69, 349);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 1922, 235, 9, 419, 179);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1923, 402, 11, 77, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 2, 1924, 163, 9, 321, 500);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1925, 154, 6, 408, 65);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 3, 1926, 481, 4, 345, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 1, 1449, 462, 8, 303, 270);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1450, 483, 4, 199, 324);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 1451, 344, 14, 125, 82);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 1452, 292, 4, 91, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 1453, 269, 9, 284, 510);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 1454, 263, 12, 77, 297);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 3, 1455, 113, 1, 375, 499);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 1456, 375, 4, 394, 489);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1457, 234, 5, 38, 449);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1458, 459, 8, 262, 281);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1459, 339, 1, 125, 223);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 2, 1460, 415, 5, 285, 118);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 1461, 393, 10, 62, 163);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1462, 7, 11, 435, 429);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 6, 1463, 440, 2, 389, 415);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 1464, 415, 14, 334, 124);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 1465, 300, 1, 181, 196);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1252, 366, 2, 191, 325);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1466, 321, 5, 42, 252);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1467, 241, 10, 110, 265);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1468, 451, 3, 169, 43);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 1469, 371, 6, 77, 140);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 6, 1470, 111, 8, 268, 344);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1471, 78, 2, 405, 441);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 6, 1472, 377, 2, 212, 368);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 6, 1473, 9, 10, 359, 441);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 2, 1474, 233, 8, 178, 405);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 2, 1475, 188, 2, 170, 498);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1476, 65, 13, 128, 376);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1477, 499, 12, 98, 255);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1478, 64, 9, 280, 271);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1479, 378, 13, 388, 486);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 1, 1480, 175, 12, 116, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 1481, 203, 6, 7, 101);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1482, 418, 9, 264, 286);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1483, 475, 3, 310, 265);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 2, 1484, 457, 14, 440, 93);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 1485, 18, 7, 37, 43);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1486, 488, 14, 80, 88);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1487, 54, 14, 297, 437);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 2, 1488, 85, 12, 231, 410);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 4, 1489, 125, 1, 67, 56);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 1, 1490, 316, 1, 287, 373);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1491, 458, 3, 102, 365);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 1492, 19, 10, 151, 240);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 1493, 20, 5, 116, 90);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 1281, 483, 11, 32, 140);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1494, 301, 7, 134, 388);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1495, 85, 5, 247, 496);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 3, 1496, 403, 1, 231, 358);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 4, 1497, 320, 12, 80, 278);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 1498, 236, 4, 17, 62);
commit;
prompt 300 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1499, 466, 5, 373, 171);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1500, 491, 1, 48, 312);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1501, 356, 1, 4, 242);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1502, 371, 8, 133, 412);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1503, 121, 13, 161, 340);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1504, 103, 2, 205, 201);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 1505, 46, 10, 391, 156);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 1, 1506, 17, 11, 446, 289);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1507, 199, 6, 305, 53);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 3, 1508, 117, 12, 11, 376);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 5, 1509, 44, 11, 503, 405);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 2, 1510, 171, 9, 431, 192);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 1511, 393, 5, 434, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 5, 1512, 489, 2, 51, 390);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1513, 179, 2, 263, 344);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 1302, 364, 12, 255, 410);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 1514, 181, 1, 119, 428);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 4, 1515, 143, 1, 145, 60);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 5, 1516, 304, 9, 443, 71);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 1517, 169, 8, 144, 351);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1518, 437, 11, 417, 41);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 6, 1519, 115, 1, 56, 236);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 1309, 110, 12, 503, 601);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1520, 357, 12, 402, 404);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 1521, 118, 10, 81, 427);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 1522, 92, 12, 138, 437);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1523, 469, 13, 344, 260);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1524, 272, 14, 140, 187);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 1, 1525, 295, 14, 441, 491);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 2, 1526, 321, 2, 462, 58);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1527, 394, 7, 339, 485);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 1528, 145, 10, 489, 397);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1529, 193, 2, 489, 296);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 1530, 107, 1, 501, 336);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 2, 1531, 443, 5, 184, 490);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1532, 218, 7, 273, 107);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 6, 1533, 369, 10, 443, 96);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1534, 54, 12, 292, 184);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 6, 1535, 132, 13, 490, 465);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 1, 1536, 93, 1, 83, 156);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 2, 1537, 70, 12, 510, 388);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 2, 1538, 240, 14, 510, 247);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 3, 1539, 332, 14, 492, 107);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 1, 1540, 466, 9, 213, 429);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 1541, 129, 1, 461, 231);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 4, 1542, 94, 1, 422, 240);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1543, 437, 11, 318, 343);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1544, 400, 11, 423, 191);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 6, 1545, 157, 6, 255, 483);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1546, 311, 14, 211, 442);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 5, 1547, 311, 4, 226, 426);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1548, 126, 2, 493, 406);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 1549, 5, 8, 190, 349);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1550, 289, 1, 20, 431);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 3, 1551, 24, 9, 391, 17);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1552, 377, 1, 42, 204);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 6, 1553, 13, 1, 62, 442);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1554, 107, 2, 296, 335);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 1555, 364, 14, 204, 259);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 4, 1556, 251, 13, 167, 63);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 5, 1557, 34, 9, 398, 174);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 5, 1558, 28, 5, 384, 404);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 5, 1559, 128, 1, 160, 424);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1560, 107, 8, 273, 154);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 6, 1561, 249, 6, 148, 61);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1562, 35, 11, 475, 43);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 5, 1563, 199, 1, 205, 401);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1564, 491, 13, 280, 212);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1565, 257, 10, 23, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1566, 401, 9, 254, 270);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 6, 1567, 403, 13, 156, 221);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 4, 1568, 96, 5, 63, 301);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1569, 442, 11, 253, 331);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 1570, 283, 13, 404, 464);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1571, 145, 7, 150, 300);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 6, 1572, 250, 10, 203, 430);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 1573, 132, 6, 416, 434);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 5, 1574, 355, 1, 304, 129);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1575, 332, 6, 109, 218);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 6, 1576, 436, 4, 463, 171);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 1577, 31, 3, 317, 123);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1578, 469, 14, 99, 141);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 1579, 67, 11, 256, 379);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1580, 345, 11, 92, 112);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1581, 436, 10, 396, 124);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 2, 1582, 347, 12, 504, 128);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 6, 1583, 135, 2, 129, 40);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 5, 1584, 457, 8, 450, 208);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 2, 1585, 233, 7, 121, 138);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 2, 1586, 304, 4, 348, 34);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 2, 1587, 265, 11, 182, 313);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 1588, 157, 7, 275, 69);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1589, 176, 10, 494, 187);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 4, 1590, 4, 14, 16, 465);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1591, 172, 13, 354, 495);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1592, 382, 7, 407, 183);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 1593, 445, 1, 473, 44);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 1594, 245, 8, 69, 370);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 4, 1595, 384, 12, 203, 306);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 5, 1596, 292, 5, 142, 484);
commit;
prompt 400 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1597, 490, 11, 50, 358);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1598, 278, 10, 163, 368);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1599, 349, 2, 89, 212);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 1600, 486, 10, 492, 302);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 1601, 149, 5, 304, 345);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1602, 152, 9, 289, 189);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 6, 1603, 320, 9, 351, 366);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 2, 1604, 235, 9, 88, 400);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 1605, 55, 13, 430, 297);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 1, 1606, 100, 1, 255, 264);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1607, 27, 12, 6, 149);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1608, 254, 1, 36, 166);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 5, 1609, 319, 10, 399, 73);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1610, 443, 14, 484, 607);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1611, 126, 9, 67, 90);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 1613, 495, 5, 92, 417);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1614, 39, 6, 36, 193);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 1, 1615, 428, 7, 266, 174);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1616, 32, 12, 507, 420);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1617, 330, 6, 495, 207);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1618, 253, 14, 11, 167);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1619, 416, 10, 397, 502);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 1620, 317, 14, 122, 40);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1621, 287, 12, 347, 131);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 4, 1622, 460, 1, 107, 405);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1623, 36, 3, 163, 441);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 5, 1624, 187, 11, 311, 132);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1625, 361, 13, 460, 323);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 2, 1626, 87, 14, 51, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1627, 275, 8, 72, 160);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 2, 1628, 230, 10, 62, 374);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 1, 1629, 164, 14, 426, 156);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 1630, 175, 13, 295, 318);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 1631, 13, 1, 327, 105);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 2, 1632, 262, 3, 311, 499);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 1633, 302, 9, 455, 409);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 1634, 479, 8, 455, 401);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1635, 164, 9, 259, 198);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 1636, 309, 4, 100, 495);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 3, 1637, 25, 11, 184, 255);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1638, 101, 11, 69, 105);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 1, 1639, 95, 10, 334, 232);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 5, 1640, 132, 13, 158, 146);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 2, 1641, 163, 4, 71, 201);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 1642, 146, 1, 159, 76);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 1643, 324, 3, 128, 391);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1644, 279, 6, 141, 63);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 1, 1645, 341, 13, 263, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1646, 420, 4, 485, 275);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 4, 1647, 5, 9, 393, 426);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1648, 163, 6, 238, 462);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1649, 475, 9, 19, 431);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 1650, 147, 3, 147, 467);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 4, 1651, 186, 5, 74, 605);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 1, 1652, 183, 13, 7, 444);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 1653, 56, 1, 209, 259);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 1, 1654, 231, 14, 8, 54);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1655, 356, 5, 485, 186);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 5, 1656, 364, 11, 44, 308);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 5, 1657, 201, 1, 250, 47);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1659, 272, 2, 345, 102);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1660, 37, 6, 368, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 4, 1661, 1, 7, 162, 77);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 1, 1662, 208, 6, 30, 71);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 2, 1663, 61, 4, 17, 227);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1664, 46, 1, 121, 306);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1665, 140, 1, 113, 118);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 1666, 20, 3, 299, 92);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1667, 109, 10, 181, 347);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 5, 1668, 486, 13, 92, 460);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1669, 296, 8, 505, 377);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1670, 255, 4, 180, 320);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 4, 1671, 232, 13, 16, 171);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 1, 1672, 476, 13, 441, 216);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 6, 1673, 333, 8, 46, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1674, 116, 9, 82, 77);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 3, 1675, 127, 2, 13, 162);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1676, 460, 1, 231, 21);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 5, 1677, 256, 6, 495, 467);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 6, 1678, 166, 4, 275, 127);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 1679, 96, 12, 229, 402);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1680, 38, 2, 308, 58);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 1682, 305, 3, 217, 245);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1683, 70, 11, 96, 170);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1684, 332, 1, 355, 335);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 1685, 298, 5, 462, 423);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 1686, 275, 5, 215, 365);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 1, 1687, 392, 11, 308, 284);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 1688, 382, 3, 301, 76);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 5, 1689, 298, 12, 112, 81);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 2, 1690, 192, 1, 296, 107);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1691, 402, 13, 152, 371);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1692, 72, 1, 498, 170);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1693, 348, 10, 435, 398);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1694, 118, 9, 405, 260);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 4, 1432, 338, 14, 229, 445);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1433, 427, 11, 141, 379);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 4, 1434, 388, 8, 189, 507);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 4, 1435, 369, 6, 395, 119);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1436, 367, 7, 305, 229);
commit;
prompt 500 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 2, 1437, 193, 7, 124, 163);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 4, 1438, 159, 7, 296, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 1439, 336, 12, 37, 448);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 1440, 293, 12, 14, 180);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1441, 221, 7, 496, 93);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 2, 1442, 131, 11, 307, 44);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1444, 296, 9, 205, 148);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 1, 1445, 243, 10, 458, 235);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 3, 1446, 375, 13, 47, 334);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 4, 1447, 195, 8, 237, 431);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1448, 53, 1, 497, 508);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1200, 474, 1, 223, 465);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1201, 126, 9, 74, 120);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 1202, 214, 11, 125, 280);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1203, 349, 12, 13, 172);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 2, 1204, 499, 12, 457, 315);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1205, 185, 13, 108, 176);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 1206, 417, 10, 288, 392);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1207, 229, 12, 198, 90);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1208, 307, 6, 258, 201);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 6, 1209, 429, 13, 39, 254);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 6, 1210, 180, 4, 118, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1211, 191, 6, 261, 441);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 1212, 195, 4, 308, 490);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 2, 1213, 210, 1, 453, 396);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 1214, 134, 13, 288, 206);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 1215, 349, 13, 282, 260);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 1216, 30, 13, 358, 309);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 6, 1217, 53, 6, 507, 414);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1218, 241, 1, 51, 124);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1219, 408, 9, 349, 489);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1220, 385, 4, 102, 129);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 5, 1221, 56, 1, 54, 323);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 1222, 173, 10, 298, 483);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 4, 1223, 329, 5, 281, 444);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 4, 1224, 308, 10, 471, 608);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1225, 76, 8, 265, 372);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 2, 1226, 228, 10, 269, 375);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 5, 1227, 280, 1, 395, 222);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 6, 1228, 126, 11, 99, 224);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 1229, 197, 13, 212, 312);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 1230, 266, 2, 167, 218);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1231, 367, 4, 267, 73);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1232, 276, 14, 255, 44);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 1233, 473, 10, 107, 252);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 3, 1234, 189, 13, 485, 371);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 1, 1235, 148, 14, 80, 502);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1236, 170, 13, 352, 167);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1237, 461, 12, 495, 218);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 4, 1238, 441, 2, 89, 195);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1239, 426, 11, 467, 413);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 1, 1240, 91, 6, 389, 177);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 2, 1241, 25, 3, 454, 350);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1242, 46, 2, 200, 203);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 6, 1243, 324, 6, 346, 207);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 4, 1244, 118, 14, 100, 412);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 1, 1245, 433, 11, 427, 203);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1246, 174, 4, 504, 366);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 1247, 142, 7, 404, 181);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 1248, 85, 2, 435, 167);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 6, 1250, 244, 13, 135, 478);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1251, 495, 12, 485, 296);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1252, 72, 8, 226, 437);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 4, 1253, 365, 6, 160, 496);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 1, 1254, 48, 13, 476, 397);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 6, 1255, 230, 12, 74, 601);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 4, 1256, 423, 12, 278, 364);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 6, 1257, 181, 5, 342, 201);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 6, 1258, 416, 12, 92, 213);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 1, 1259, 128, 14, 345, 335);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 6, 1260, 298, 10, 100, 311);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 6, 1261, 76, 13, 118, 96);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1262, 407, 5, 143, 269);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1263, 388, 3, 111, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 1264, 258, 1, 23, 171);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 6, 1265, 28, 9, 265, 305);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 5, 1266, 34, 13, 396, 73);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1267, 381, 2, 489, 442);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1268, 377, 10, 31, 212);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1269, 366, 6, 144, 277);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 1270, 16, 12, 115, 265);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 5, 1271, 206, 11, 407, 400);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 4, 1272, 389, 8, 413, 184);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1273, 330, 8, 244, 321);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 5, 1274, 67, 13, 260, 254);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 1, 1275, 4, 9, 311, 600);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 5, 1276, 364, 8, 153, 501);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1277, 415, 11, 162, 94);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1278, 211, 7, 357, 601);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1279, 72, 12, 282, 333);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1280, 416, 6, 187, 108);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1281, 488, 11, 180, 499);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 4, 1282, 135, 4, 248, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 5, 1283, 248, 12, 239, 468);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1284, 443, 8, 331, 109);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 5, 1285, 195, 12, 340, 391);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 4, 1286, 62, 10, 92, 465);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1287, 78, 7, 164, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1288, 396, 3, 57, 376);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1289, 144, 3, 40, 384);
commit;
prompt 600 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 2, 1290, 170, 7, 134, 343);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 4, 1291, 270, 3, 362, 97);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1292, 84, 12, 65, 323);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 4, 1293, 372, 4, 230, 413);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 1294, 26, 11, 259, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1295, 424, 3, 224, 486);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1296, 1, 6, 67, 76);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 6, 1297, 90, 6, 19, 178);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1298, 67, 11, 338, 286);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1299, 43, 2, 80, 359);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1300, 197, 14, 429, 13);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1301, 215, 13, 456, 200);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 4, 1302, 101, 4, 354, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 6, 1303, 328, 7, 25, 76);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 1304, 170, 8, 9, 130);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1305, 174, 5, 189, 490);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 5, 1306, 344, 7, 300, 153);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 6, 1307, 255, 7, 306, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 3, 1308, 293, 8, 414, 455);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1309, 1, 7, 324, 348);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1310, 487, 1, 374, 206);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1311, 429, 13, 209, 111);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 1, 1312, 273, 3, 340, 198);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 6, 1313, 205, 12, 149, 8);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 1, 1314, 295, 12, 427, 504);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1315, 223, 3, 48, 105);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1316, 137, 9, 396, 87);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1317, 423, 3, 19, 212);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 6, 1318, 239, 4, 217, 401);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1319, 196, 9, 109, 412);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 1, 1320, 258, 12, 57, 265);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 3, 1321, 358, 2, 203, 11);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 5, 1322, 151, 3, 461, 55);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 5, 1323, 293, 8, 149, 92);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1324, 402, 6, 3, 318);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 3, 1325, 492, 1, 260, 321);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 1326, 425, 6, 87, 378);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 3, 1327, 331, 13, 454, 131);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1328, 314, 4, 160, 143);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1329, 84, 4, 500, 459);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1330, 231, 1, 410, 464);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 1, 1331, 252, 3, 376, 189);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 1332, 331, 11, 59, 302);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 6, 1333, 448, 9, 411, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 1334, 280, 6, 408, 601);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1335, 178, 9, 475, 123);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 6, 1336, 26, 4, 507, 57);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 1337, 13, 3, 175, 282);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 5, 1338, 102, 4, 451, 54);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1339, 229, 6, 98, 146);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 6, 1340, 388, 12, 447, 140);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1341, 164, 9, 180, 340);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 1342, 366, 9, 193, 212);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 1343, 130, 13, 98, 119);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 1344, 27, 3, 220, 118);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 1, 1345, 362, 9, 55, 308);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 1346, 231, 10, 322, 133);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 1347, 103, 9, 477, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 1348, 417, 7, 16, 382);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1349, 52, 6, 281, 275);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1350, 224, 3, 7, 92);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1351, 31, 9, 108, 69);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 1352, 162, 6, 144, 392);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1353, 341, 3, 270, 385);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 3, 1354, 148, 13, 245, 338);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 5, 1355, 412, 3, 47, 499);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 1356, 299, 13, 54, 480);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1357, 470, 8, 45, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1358, 32, 8, 347, 368);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 1359, 86, 2, 265, 412);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 1360, 135, 13, 200, 383);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 1361, 58, 10, 416, 253);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 6, 1362, 96, 6, 328, 186);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1363, 255, 12, 474, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1364, 105, 6, 110, 380);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 1, 1365, 130, 3, 134, 308);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1366, 263, 3, 11, 413);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 3, 1367, 267, 6, 487, 323);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 4, 1368, 173, 14, 310, 120);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 6, 1369, 427, 11, 216, 302);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 1370, 191, 10, 460, 216);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1371, 201, 2, 92, 374);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 2, 1372, 255, 7, 454, 73);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1373, 498, 3, 142, 93);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1374, 340, 1, 86, 358);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 1, 1375, 216, 4, 495, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1376, 179, 7, 299, 191);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1377, 72, 3, 199, 329);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1378, 74, 4, 223, 405);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 6, 1379, 195, 5, 178, 91);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1380, 174, 14, 446, 106);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 5, 1381, 209, 12, 293, 502);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1382, 289, 1, 279, 44);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 1383, 157, 4, 486, 128);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 1384, 388, 11, 314, 210);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 5, 1385, 237, 1, 321, 354);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1386, 73, 10, 319, 224);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1387, 463, 7, 16, 53);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1388, 445, 1, 482, 78);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 5, 1389, 466, 6, 64, 384);
commit;
prompt 700 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 6, 1390, 401, 12, 356, 132);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 2, 1391, 295, 11, 270, 289);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 1392, 24, 1, 214, 406);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 1393, 188, 7, 131, 394);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1394, 356, 11, 444, 232);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 1395, 419, 10, 110, 73);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 2, 1396, 472, 4, 371, 209);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 5, 1397, 450, 9, 388, 332);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 2, 1398, 385, 2, 41, 53);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1399, 229, 2, 451, 43);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1400, 455, 14, 495, 107);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 2, 1401, 121, 3, 455, 216);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 2, 1402, 86, 6, 202, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1403, 72, 10, 311, 285);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 1, 1404, 129, 12, 254, 370);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 1, 1405, 226, 4, 241, 293);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 1406, 24, 8, 454, 83);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 1, 1407, 355, 9, 37, 156);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 1, 1408, 352, 3, 158, 367);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1409, 71, 13, 500, 174);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 1410, 80, 14, 36, 323);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1411, 431, 8, 480, 336);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 1412, 420, 3, 6, 67);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 1, 1413, 147, 1, 374, 417);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1414, 332, 13, 446, 384);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 3, 1415, 271, 7, 165, 310);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 3, 1416, 342, 13, 179, 345);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 2, 1417, 313, 2, 51, 441);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1418, 464, 13, 112, 462);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 1, 1419, 411, 2, 140, 246);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 2, 1420, 136, 11, 151, 85);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1421, 263, 6, 410, 345);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 1422, 211, 13, 68, 497);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 1423, 186, 4, 187, 398);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 1, 1424, 167, 7, 354, 489);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 1425, 272, 9, 138, 275);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 6, 1426, 329, 5, 219, 444);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1427, 241, 10, 167, 156);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 4, 1428, 8, 4, 245, 399);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 1, 1429, 225, 14, 24, 464);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 1, 1430, 105, 10, 484, 382);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 3, 1431, 325, 6, 374, 370);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 1927, 2, 13, 316, 112);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 5, 1928, 451, 10, 309, 390);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1929, 304, 13, 231, 65);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 6, 1930, 58, 5, 133, 127);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 6, 1931, 371, 14, 290, 280);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 1932, 30, 12, 416, 114);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 1933, 23, 2, 453, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1935, 147, 12, 341, 163);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1936, 242, 3, 161, 430);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1937, 81, 6, 94, 162);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 4, 1938, 473, 8, 358, 294);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1939, 329, 1, 134, 415);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1940, 463, 1, 324, 226);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1941, 182, 10, 376, 226);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 3, 1942, 410, 12, 440, 49);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1943, 492, 13, 80, 53);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 2, 1944, 299, 4, 201, 218);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1945, 443, 14, 161, 197);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 1946, 9, 6, 52, 467);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 1947, 286, 9, 235, 215);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 1948, 309, 1, 242, 306);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 6, 1949, 161, 4, 104, 130);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 1, 1950, 142, 1, 120, 338);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 3, 1951, 211, 12, 266, 366);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 1952, 259, 14, 400, 430);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 1953, 353, 10, 200, 132);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 6, 1954, 339, 9, 343, 63);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 1955, 180, 9, 454, 252);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1956, 410, 6, 277, 403);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 1957, 86, 14, 432, 14);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1958, 467, 13, 133, 157);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 2, 1959, 359, 6, 187, 54);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 1960, 335, 2, 86, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 1961, 76, 7, 420, 101);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 1962, 438, 12, 349, 229);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 1963, 287, 7, 54, 108);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1964, 265, 5, 354, 197);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 2, 1965, 83, 13, 130, 195);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 1, 1966, 445, 9, 217, 428);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 5, 1967, 282, 1, 395, 338);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1968, 471, 13, 395, 395);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1969, 76, 4, 103, 186);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1970, 237, 7, 147, 222);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 1971, 124, 14, 404, 261);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 6, 1972, 177, 1, 120, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1973, 185, 3, 181, 345);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 1974, 419, 13, 251, 186);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1975, 23, 5, 313, 338);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 1976, 499, 4, 98, 277);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 6, 1977, 431, 4, 314, 200);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 4, 1979, 360, 3, 42, 241);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1980, 419, 7, 377, 323);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 3, 1981, 239, 3, 368, 226);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 1982, 178, 3, 166, 293);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1983, 224, 10, 437, 484);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 1984, 292, 10, 93, 377);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 1, 1985, 232, 10, 486, 496);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1986, 395, 1, 60, 507);
commit;
prompt 800 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 1987, 216, 2, 444, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 6, 1988, 382, 11, 438, 269);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 1, 1989, 308, 4, 454, 50);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 6, 1990, 105, 11, 353, 298);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1991, 39, 12, 455, 186);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1992, 426, 9, 251, 345);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 1993, 494, 13, 116, 132);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1994, 311, 8, 170, 58);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 3, 1995, 375, 1, 59, 200);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 3, 1996, 237, 11, 71, 278);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 5, 1997, 84, 4, 342, 198);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1998, 339, 7, 41, 87);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 1999, 34, 6, 427, 263);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 2, 2000, 330, 1, 341, 339);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 1, 2001, 60, 12, 446, 392);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 2002, 358, 7, 380, 131);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 2003, 390, 2, 86, 421);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 6, 2004, 88, 11, 423, 603);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 2005, 289, 2, 235, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 1, 2006, 431, 3, 260, 408);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 2007, 96, 6, 431, 40);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 2008, 448, 3, 440, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 2, 2009, 8, 6, 41, 285);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 6, 2010, 99, 7, 35, 421);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 1, 2011, 84, 2, 35, 497);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 2012, 130, 14, 354, 396);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 2013, 83, 5, 285, 80);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 2014, 497, 9, 177, 310);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 2, 2015, 340, 1, 217, 302);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 2016, 389, 10, 336, 148);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 5, 2017, 57, 5, 43, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 2018, 494, 14, 394, 498);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 2019, 465, 11, 443, 255);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 2020, 303, 13, 422, 222);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 2021, 471, 12, 241, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 4, 2022, 376, 9, 58, 260);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 2023, 14, 12, 384, 420);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 5, 2024, 90, 11, 441, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 2025, 474, 7, 250, 226);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 2026, 51, 3, 451, 332);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 2027, 123, 7, 480, 398);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 4, 2028, 453, 3, 237, 125);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 2029, 208, 13, 121, 315);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 2, 2030, 289, 11, 153, 160);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 2031, 406, 12, 498, 264);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 2032, 467, 3, 176, 119);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 2, 2033, 479, 6, 301, 220);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 4, 2034, 490, 2, 414, 380);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 2035, 143, 10, 151, 135);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 2036, 483, 3, 407, 116);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 2037, 206, 8, 368, 430);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 4, 2038, 489, 1, 94, 379);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 6, 2039, 247, 5, 274, 416);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 2040, 74, 4, 418, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 4, 2041, 152, 4, 338, 313);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 6, 2042, 390, 9, 77, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 6, 2043, 8, 12, 450, 102);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 6, 2044, 10, 3, 399, 126);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 4, 2045, 439, 4, 482, 294);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 4, 2046, 425, 8, 322, 214);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 4, 2047, 124, 6, 244, 467);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 1, 2048, 258, 2, 349, 469);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 2049, 340, 11, 150, 43);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 1, 2050, 353, 8, 254, 203);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 6, 2051, 8, 6, 466, 48);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 5, 2052, 25, 5, 487, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 2053, 352, 6, 199, 464);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 2054, 390, 7, 470, 47);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 4, 2055, 380, 6, 387, 259);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 2, 2056, 317, 7, 418, 478);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 2057, 59, 8, 352, 60);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 2058, 158, 10, 134, 337);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 2, 2059, 142, 13, 88, 154);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 2, 2060, 46, 14, 122, 186);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 2061, 264, 14, 160, 411);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 2062, 183, 5, 279, 289);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 2063, 24, 9, 288, 267);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 2064, 153, 1, 205, 267);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 6, 2065, 408, 12, 503, 300);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 6, 2066, 413, 3, 244, 411);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 2067, 27, 2, 167, 325);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 6, 2068, 274, 6, 394, 482);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 1, 2069, 275, 11, 29, 374);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 2070, 266, 4, 19, 402);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 2071, 134, 12, 318, 270);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 5, 2072, 431, 2, 367, 373);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 5, 2073, 469, 11, 286, 286);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 2074, 218, 12, 316, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 4, 2075, 306, 2, 123, 416);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 2076, 253, 2, 356, 273);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 2077, 177, 8, 185, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 2078, 414, 6, 390, 501);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 2079, 266, 11, 260, 184);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 2080, 235, 5, 503, 81);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 2081, 214, 6, 177, 483);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2082, 316, 2, 211, 462);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 4, 2083, 51, 1, 145, 99);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 2084, 21, 12, 508, 81);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 2086, 378, 10, 388, 296);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 4, 2087, 359, 11, 495, 371);
commit;
prompt 900 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 2, 2088, 223, 14, 73, 72);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 2089, 415, 12, 77, 473);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 2090, 253, 6, 330, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 2091, 168, 10, 332, 97);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 2092, 270, 10, 144, 603);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 2093, 182, 11, 257, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 2094, 37, 7, 267, 219);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 2, 2095, 142, 5, 116, 331);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 5, 2096, 285, 8, 352, 377);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 2, 2097, 44, 1, 485, 326);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 2098, 32, 10, 501, 341);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 2099, 311, 2, 340, 465);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 2100, 500, 11, 322, 224);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 1, 2101, 460, 8, 324, 267);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 3, 2102, 55, 10, 427, 407);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 3, 2103, 40, 10, 147, 64);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 2104, 197, 8, 244, 391);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 2105, 186, 4, 115, 338);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 2106, 268, 1, 396, 180);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 2107, 277, 12, 56, 314);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 6, 2108, 179, 14, 195, 157);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 2109, 290, 4, 277, 158);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 2110, 41, 1, 294, 185);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 2111, 79, 4, 137, 374);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 2, 2112, 278, 13, 273, 497);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 2113, 442, 11, 131, 318);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 4, 2114, 349, 6, 449, 109);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 2115, 423, 1, 258, 229);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 6, 2116, 393, 7, 487, 394);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 2117, 493, 13, 333, 126);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 1, 2118, 199, 13, 269, 200);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 5, 2119, 295, 6, 356, 5);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 3, 2120, 49, 8, 446, 495);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 1, 2121, 332, 2, 227, 359);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 3, 2122, 87, 10, 235, 482);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 2123, 65, 7, 237, 470);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 2124, 8, 1, 336, 216);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 5, 2125, 19, 12, 341, 278);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 6, 2126, 488, 6, 98, 377);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 1, 2127, 137, 11, 424, 112);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 2128, 386, 13, 156, 188);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 2129, 209, 4, 317, 133);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 2130, 377, 14, 416, 386);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 3, 2131, 386, 7, 494, 174);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 2133, 348, 10, 447, 159);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 1, 2134, 279, 9, 309, 455);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 2135, 374, 14, 493, 414);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 2136, 175, 7, 129, 480);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 2137, 158, 4, 182, 204);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 2138, 353, 6, 87, 358);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 1, 2139, 346, 5, 359, 338);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 2140, 230, 2, 15, 294);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 2141, 398, 7, 238, 113);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 6, 2142, 8, 6, 78, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 2143, 6, 4, 383, 498);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 5, 2144, 473, 10, 283, 192);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 2145, 407, 10, 146, 231);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 2147, 81, 13, 184, 380);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 1, 2148, 364, 6, 45, 72);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 2149, 431, 8, 426, 601);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 2150, 336, 13, 187, 158);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 2151, 161, 14, 255, 90);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 4, 2152, 161, 14, 151, 379);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 1, 2153, 228, 11, 205, 313);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 6, 2154, 32, 6, 197, 365);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 2155, 318, 1, 487, 62);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 2, 2156, 265, 3, 350, 144);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 2157, 459, 1, 464, 465);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 2158, 302, 12, 386, 253);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 2159, 11, 12, 257, 471);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 2160, 101, 9, 306, 94);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 4, 2161, 352, 14, 196, 229);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 6, 2162, 102, 8, 364, 398);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 3, 2163, 272, 8, 68, 256);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 2164, 31, 10, 395, 431);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 2165, 154, 5, 230, 241);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 2166, 481, 7, 314, 188);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 3, 2167, 171, 1, 175, 602);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 2169, 364, 8, 463, 293);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 2, 2170, 408, 3, 309, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 2171, 61, 2, 250, 144);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 2172, 476, 5, 41, 254);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 4, 2173, 246, 10, 186, 504);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 2174, 141, 13, 420, 370);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 2175, 109, 7, 105, 145);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 2176, 28, 11, 266, 426);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 2, 2177, 120, 6, 482, 8);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 2178, 120, 1, 89, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 2179, 106, 7, 447, 100);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 2180, 286, 2, 459, 428);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 2181, 439, 12, 15, 497);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 5, 2182, 396, 11, 344, 149);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 2183, 53, 7, 95, 138);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 2184, 49, 1, 482, 99);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 2185, 145, 1, 48, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 2186, 87, 7, 176, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 6, 2187, 39, 10, 365, 417);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 2188, 174, 5, 475, 203);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 1, 2189, 308, 6, 300, 442);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 2190, 367, 10, 347, 4);
commit;
prompt 1000 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 6, 2191, 392, 13, 313, 270);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 2192, 204, 5, 87, 84);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 2193, 44, 13, 449, 178);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 2194, 488, 4, 341, 348);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 2195, 111, 10, 162, 61);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 2196, 36, 4, 35, 394);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 2, 2197, 215, 13, 140, 293);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 2198, 333, 13, 196, 467);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 2199, 88, 8, 180, 163);
commit;
prompt 1009 records loaded
prompt Loading TEACH...
insert into TEACH (workshop_id, teacher_id)
values (1, 1);
insert into TEACH (workshop_id, teacher_id)
values (1, 86);
insert into TEACH (workshop_id, teacher_id)
values (1, 109);
insert into TEACH (workshop_id, teacher_id)
values (1, 124);
insert into TEACH (workshop_id, teacher_id)
values (1, 177);
insert into TEACH (workshop_id, teacher_id)
values (1, 195);
insert into TEACH (workshop_id, teacher_id)
values (1, 196);
insert into TEACH (workshop_id, teacher_id)
values (1, 343);
insert into TEACH (workshop_id, teacher_id)
values (1, 357);
insert into TEACH (workshop_id, teacher_id)
values (1, 420);
insert into TEACH (workshop_id, teacher_id)
values (1, 447);
insert into TEACH (workshop_id, teacher_id)
values (1, 504);
insert into TEACH (workshop_id, teacher_id)
values (2, 2);
insert into TEACH (workshop_id, teacher_id)
values (2, 63);
insert into TEACH (workshop_id, teacher_id)
values (2, 86);
insert into TEACH (workshop_id, teacher_id)
values (2, 96);
insert into TEACH (workshop_id, teacher_id)
values (2, 118);
insert into TEACH (workshop_id, teacher_id)
values (2, 200);
insert into TEACH (workshop_id, teacher_id)
values (2, 212);
insert into TEACH (workshop_id, teacher_id)
values (2, 240);
insert into TEACH (workshop_id, teacher_id)
values (2, 241);
insert into TEACH (workshop_id, teacher_id)
values (2, 272);
insert into TEACH (workshop_id, teacher_id)
values (2, 312);
insert into TEACH (workshop_id, teacher_id)
values (2, 325);
insert into TEACH (workshop_id, teacher_id)
values (2, 378);
insert into TEACH (workshop_id, teacher_id)
values (2, 431);
insert into TEACH (workshop_id, teacher_id)
values (2, 498);
insert into TEACH (workshop_id, teacher_id)
values (2, 499);
insert into TEACH (workshop_id, teacher_id)
values (2, 601);
insert into TEACH (workshop_id, teacher_id)
values (2, 604);
insert into TEACH (workshop_id, teacher_id)
values (3, 3);
insert into TEACH (workshop_id, teacher_id)
values (3, 43);
insert into TEACH (workshop_id, teacher_id)
values (3, 73);
insert into TEACH (workshop_id, teacher_id)
values (3, 78);
insert into TEACH (workshop_id, teacher_id)
values (3, 121);
insert into TEACH (workshop_id, teacher_id)
values (3, 128);
insert into TEACH (workshop_id, teacher_id)
values (3, 165);
insert into TEACH (workshop_id, teacher_id)
values (3, 169);
insert into TEACH (workshop_id, teacher_id)
values (3, 180);
insert into TEACH (workshop_id, teacher_id)
values (3, 192);
insert into TEACH (workshop_id, teacher_id)
values (3, 203);
insert into TEACH (workshop_id, teacher_id)
values (3, 255);
insert into TEACH (workshop_id, teacher_id)
values (3, 298);
insert into TEACH (workshop_id, teacher_id)
values (3, 313);
insert into TEACH (workshop_id, teacher_id)
values (3, 320);
insert into TEACH (workshop_id, teacher_id)
values (3, 324);
insert into TEACH (workshop_id, teacher_id)
values (3, 337);
insert into TEACH (workshop_id, teacher_id)
values (3, 361);
insert into TEACH (workshop_id, teacher_id)
values (3, 362);
insert into TEACH (workshop_id, teacher_id)
values (3, 364);
insert into TEACH (workshop_id, teacher_id)
values (3, 365);
insert into TEACH (workshop_id, teacher_id)
values (3, 414);
insert into TEACH (workshop_id, teacher_id)
values (4, 4);
insert into TEACH (workshop_id, teacher_id)
values (4, 10);
insert into TEACH (workshop_id, teacher_id)
values (4, 46);
insert into TEACH (workshop_id, teacher_id)
values (4, 119);
insert into TEACH (workshop_id, teacher_id)
values (4, 240);
insert into TEACH (workshop_id, teacher_id)
values (4, 277);
insert into TEACH (workshop_id, teacher_id)
values (4, 280);
insert into TEACH (workshop_id, teacher_id)
values (4, 289);
insert into TEACH (workshop_id, teacher_id)
values (4, 323);
insert into TEACH (workshop_id, teacher_id)
values (4, 326);
insert into TEACH (workshop_id, teacher_id)
values (4, 332);
insert into TEACH (workshop_id, teacher_id)
values (4, 346);
insert into TEACH (workshop_id, teacher_id)
values (4, 361);
insert into TEACH (workshop_id, teacher_id)
values (4, 394);
insert into TEACH (workshop_id, teacher_id)
values (4, 409);
insert into TEACH (workshop_id, teacher_id)
values (4, 411);
insert into TEACH (workshop_id, teacher_id)
values (4, 413);
insert into TEACH (workshop_id, teacher_id)
values (4, 469);
insert into TEACH (workshop_id, teacher_id)
values (4, 477);
insert into TEACH (workshop_id, teacher_id)
values (5, 5);
insert into TEACH (workshop_id, teacher_id)
values (5, 7);
insert into TEACH (workshop_id, teacher_id)
values (5, 24);
insert into TEACH (workshop_id, teacher_id)
values (5, 140);
insert into TEACH (workshop_id, teacher_id)
values (5, 221);
insert into TEACH (workshop_id, teacher_id)
values (5, 229);
insert into TEACH (workshop_id, teacher_id)
values (5, 243);
insert into TEACH (workshop_id, teacher_id)
values (5, 248);
insert into TEACH (workshop_id, teacher_id)
values (5, 303);
insert into TEACH (workshop_id, teacher_id)
values (5, 306);
insert into TEACH (workshop_id, teacher_id)
values (5, 310);
insert into TEACH (workshop_id, teacher_id)
values (5, 315);
insert into TEACH (workshop_id, teacher_id)
values (5, 499);
insert into TEACH (workshop_id, teacher_id)
values (6, 6);
insert into TEACH (workshop_id, teacher_id)
values (6, 12);
insert into TEACH (workshop_id, teacher_id)
values (6, 18);
insert into TEACH (workshop_id, teacher_id)
values (6, 111);
insert into TEACH (workshop_id, teacher_id)
values (6, 215);
insert into TEACH (workshop_id, teacher_id)
values (6, 232);
insert into TEACH (workshop_id, teacher_id)
values (6, 279);
insert into TEACH (workshop_id, teacher_id)
values (6, 293);
insert into TEACH (workshop_id, teacher_id)
values (6, 301);
insert into TEACH (workshop_id, teacher_id)
values (6, 488);
insert into TEACH (workshop_id, teacher_id)
values (6, 603);
insert into TEACH (workshop_id, teacher_id)
values (7, 7);
insert into TEACH (workshop_id, teacher_id)
values (7, 11);
insert into TEACH (workshop_id, teacher_id)
values (7, 20);
insert into TEACH (workshop_id, teacher_id)
values (7, 32);
insert into TEACH (workshop_id, teacher_id)
values (7, 71);
commit;
prompt 100 records committed...
insert into TEACH (workshop_id, teacher_id)
values (7, 90);
insert into TEACH (workshop_id, teacher_id)
values (7, 109);
insert into TEACH (workshop_id, teacher_id)
values (7, 138);
insert into TEACH (workshop_id, teacher_id)
values (7, 143);
insert into TEACH (workshop_id, teacher_id)
values (7, 195);
insert into TEACH (workshop_id, teacher_id)
values (7, 296);
insert into TEACH (workshop_id, teacher_id)
values (7, 309);
insert into TEACH (workshop_id, teacher_id)
values (7, 325);
insert into TEACH (workshop_id, teacher_id)
values (8, 8);
insert into TEACH (workshop_id, teacher_id)
values (8, 60);
insert into TEACH (workshop_id, teacher_id)
values (8, 102);
insert into TEACH (workshop_id, teacher_id)
values (8, 105);
insert into TEACH (workshop_id, teacher_id)
values (8, 195);
insert into TEACH (workshop_id, teacher_id)
values (8, 198);
insert into TEACH (workshop_id, teacher_id)
values (8, 201);
insert into TEACH (workshop_id, teacher_id)
values (8, 212);
insert into TEACH (workshop_id, teacher_id)
values (8, 223);
insert into TEACH (workshop_id, teacher_id)
values (8, 303);
insert into TEACH (workshop_id, teacher_id)
values (8, 349);
insert into TEACH (workshop_id, teacher_id)
values (8, 351);
insert into TEACH (workshop_id, teacher_id)
values (8, 381);
insert into TEACH (workshop_id, teacher_id)
values (8, 417);
insert into TEACH (workshop_id, teacher_id)
values (8, 605);
insert into TEACH (workshop_id, teacher_id)
values (9, 9);
insert into TEACH (workshop_id, teacher_id)
values (9, 34);
insert into TEACH (workshop_id, teacher_id)
values (9, 44);
insert into TEACH (workshop_id, teacher_id)
values (9, 54);
insert into TEACH (workshop_id, teacher_id)
values (9, 56);
insert into TEACH (workshop_id, teacher_id)
values (9, 73);
insert into TEACH (workshop_id, teacher_id)
values (9, 76);
insert into TEACH (workshop_id, teacher_id)
values (9, 83);
insert into TEACH (workshop_id, teacher_id)
values (9, 90);
insert into TEACH (workshop_id, teacher_id)
values (9, 108);
insert into TEACH (workshop_id, teacher_id)
values (9, 111);
insert into TEACH (workshop_id, teacher_id)
values (9, 126);
insert into TEACH (workshop_id, teacher_id)
values (9, 152);
insert into TEACH (workshop_id, teacher_id)
values (9, 160);
insert into TEACH (workshop_id, teacher_id)
values (9, 168);
insert into TEACH (workshop_id, teacher_id)
values (9, 273);
insert into TEACH (workshop_id, teacher_id)
values (9, 379);
insert into TEACH (workshop_id, teacher_id)
values (9, 388);
insert into TEACH (workshop_id, teacher_id)
values (9, 392);
insert into TEACH (workshop_id, teacher_id)
values (9, 406);
insert into TEACH (workshop_id, teacher_id)
values (9, 490);
insert into TEACH (workshop_id, teacher_id)
values (9, 601);
insert into TEACH (workshop_id, teacher_id)
values (10, 10);
insert into TEACH (workshop_id, teacher_id)
values (10, 77);
insert into TEACH (workshop_id, teacher_id)
values (10, 118);
insert into TEACH (workshop_id, teacher_id)
values (10, 159);
insert into TEACH (workshop_id, teacher_id)
values (10, 171);
insert into TEACH (workshop_id, teacher_id)
values (10, 176);
insert into TEACH (workshop_id, teacher_id)
values (10, 186);
insert into TEACH (workshop_id, teacher_id)
values (10, 255);
insert into TEACH (workshop_id, teacher_id)
values (10, 277);
insert into TEACH (workshop_id, teacher_id)
values (10, 295);
insert into TEACH (workshop_id, teacher_id)
values (10, 308);
insert into TEACH (workshop_id, teacher_id)
values (10, 377);
insert into TEACH (workshop_id, teacher_id)
values (10, 394);
insert into TEACH (workshop_id, teacher_id)
values (10, 403);
insert into TEACH (workshop_id, teacher_id)
values (10, 408);
insert into TEACH (workshop_id, teacher_id)
values (10, 430);
insert into TEACH (workshop_id, teacher_id)
values (10, 475);
insert into TEACH (workshop_id, teacher_id)
values (10, 600);
insert into TEACH (workshop_id, teacher_id)
values (11, 140);
insert into TEACH (workshop_id, teacher_id)
values (11, 158);
insert into TEACH (workshop_id, teacher_id)
values (11, 165);
insert into TEACH (workshop_id, teacher_id)
values (11, 195);
insert into TEACH (workshop_id, teacher_id)
values (11, 214);
insert into TEACH (workshop_id, teacher_id)
values (11, 239);
insert into TEACH (workshop_id, teacher_id)
values (11, 242);
insert into TEACH (workshop_id, teacher_id)
values (11, 259);
insert into TEACH (workshop_id, teacher_id)
values (11, 296);
insert into TEACH (workshop_id, teacher_id)
values (11, 510);
insert into TEACH (workshop_id, teacher_id)
values (11, 600);
insert into TEACH (workshop_id, teacher_id)
values (12, 7);
insert into TEACH (workshop_id, teacher_id)
values (12, 50);
insert into TEACH (workshop_id, teacher_id)
values (12, 66);
insert into TEACH (workshop_id, teacher_id)
values (12, 71);
insert into TEACH (workshop_id, teacher_id)
values (12, 138);
insert into TEACH (workshop_id, teacher_id)
values (12, 314);
insert into TEACH (workshop_id, teacher_id)
values (12, 326);
insert into TEACH (workshop_id, teacher_id)
values (12, 372);
insert into TEACH (workshop_id, teacher_id)
values (12, 388);
insert into TEACH (workshop_id, teacher_id)
values (12, 390);
insert into TEACH (workshop_id, teacher_id)
values (12, 410);
insert into TEACH (workshop_id, teacher_id)
values (12, 431);
insert into TEACH (workshop_id, teacher_id)
values (12, 459);
insert into TEACH (workshop_id, teacher_id)
values (12, 601);
insert into TEACH (workshop_id, teacher_id)
values (12, 609);
insert into TEACH (workshop_id, teacher_id)
values (13, 123);
insert into TEACH (workshop_id, teacher_id)
values (13, 125);
insert into TEACH (workshop_id, teacher_id)
values (13, 169);
insert into TEACH (workshop_id, teacher_id)
values (13, 226);
insert into TEACH (workshop_id, teacher_id)
values (13, 239);
insert into TEACH (workshop_id, teacher_id)
values (13, 270);
insert into TEACH (workshop_id, teacher_id)
values (13, 271);
insert into TEACH (workshop_id, teacher_id)
values (13, 284);
insert into TEACH (workshop_id, teacher_id)
values (13, 294);
insert into TEACH (workshop_id, teacher_id)
values (13, 311);
insert into TEACH (workshop_id, teacher_id)
values (13, 326);
commit;
prompt 200 records committed...
insert into TEACH (workshop_id, teacher_id)
values (13, 436);
insert into TEACH (workshop_id, teacher_id)
values (13, 449);
insert into TEACH (workshop_id, teacher_id)
values (13, 471);
insert into TEACH (workshop_id, teacher_id)
values (13, 609);
insert into TEACH (workshop_id, teacher_id)
values (14, 32);
insert into TEACH (workshop_id, teacher_id)
values (14, 61);
insert into TEACH (workshop_id, teacher_id)
values (14, 65);
insert into TEACH (workshop_id, teacher_id)
values (14, 82);
insert into TEACH (workshop_id, teacher_id)
values (14, 113);
insert into TEACH (workshop_id, teacher_id)
values (14, 177);
insert into TEACH (workshop_id, teacher_id)
values (14, 222);
insert into TEACH (workshop_id, teacher_id)
values (14, 232);
insert into TEACH (workshop_id, teacher_id)
values (14, 261);
insert into TEACH (workshop_id, teacher_id)
values (14, 269);
insert into TEACH (workshop_id, teacher_id)
values (14, 345);
insert into TEACH (workshop_id, teacher_id)
values (14, 350);
insert into TEACH (workshop_id, teacher_id)
values (14, 351);
insert into TEACH (workshop_id, teacher_id)
values (14, 361);
insert into TEACH (workshop_id, teacher_id)
values (14, 376);
insert into TEACH (workshop_id, teacher_id)
values (14, 437);
insert into TEACH (workshop_id, teacher_id)
values (14, 444);
insert into TEACH (workshop_id, teacher_id)
values (14, 449);
insert into TEACH (workshop_id, teacher_id)
values (14, 462);
insert into TEACH (workshop_id, teacher_id)
values (14, 468);
insert into TEACH (workshop_id, teacher_id)
values (14, 483);
insert into TEACH (workshop_id, teacher_id)
values (14, 500);
insert into TEACH (workshop_id, teacher_id)
values (14, 602);
commit;
prompt 227 records loaded
prompt Enabling foreign key constraints for CLIENTS...
alter table CLIENTS enable constraint SYS_C007620;
prompt Enabling foreign key constraints for GROUPS_...
alter table GROUPS_ enable constraint SYS_C007623;
prompt Enabling foreign key constraints for PARTICIPATE...
alter table PARTICIPATE enable constraint SYS_C007627;
alter table PARTICIPATE enable constraint SYS_C007628;
prompt Enabling foreign key constraints for TEACHERS...
alter table TEACHERS enable constraint SYS_C007635;
prompt Enabling foreign key constraints for SCHEDULER...
alter table SCHEDULER enable constraint SYS_C007641;
alter table SCHEDULER enable constraint SYS_C007642;
alter table SCHEDULER enable constraint SYS_C007643;
alter table SCHEDULER enable constraint SYS_C007644;
prompt Enabling foreign key constraints for TEACH...
alter table TEACH enable constraint SYS_C007650;
alter table TEACH enable constraint SYS_C007651;
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
