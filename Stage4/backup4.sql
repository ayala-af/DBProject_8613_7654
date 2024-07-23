prompt PL/SQL Developer import file
prompt Created on Tuesday, July 23, 2024 by Naama
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

prompt Creating ROOMS...
create table ROOMS
(
  room_id                NUMBER(5) not null,
  room_floor             NUMBER(5),
  isstudio               CHAR(1),
  room_capacity          NUMBER(5),
  is_lab                 NUMBER(1),
  last_maintenance_check DATE
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

prompt Creating TEACHER...
create table TEACHER
(
  teacher_id        NUMBER(5) not null,
  teacher_fname     VARCHAR2(15),
  teacher_lname     VARCHAR2(15),
  teacher_tel       NUMBER(5),
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
alter table TEACHER
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

prompt Creating SCHTEACHER...
create table SCHTEACHER
(
  teacher_id    NUMBER(5) not null,
  hourly_salary NUMBER,
  bonus         NUMBER
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
alter table SCHTEACHER
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
alter table SCHTEACHER
  add foreign key (TEACHER_ID)
  references TEACHER (TEACHER_ID);

prompt Creating CLASS_...
create table CLASS_
(
  class_id   NUMBER(3) not null,
  grade      NUMBER(2) not null,
  teacher_id NUMBER(3) not null,
  room_id    NUMBER(3) not null
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
alter table CLASS_
  add primary key (CLASS_ID)
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
alter table CLASS_
  add constraint CHECK_CLASSROOM unique (ROOM_ID)
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
alter table CLASS_
  add foreign key (ROOM_ID)
  references ROOMS (ROOM_ID);
alter table CLASS_
  add foreign key (TEACHER_ID)
  references SCHTEACHER (TEACHER_ID);

prompt Creating CLIENTS...
create table CLIENTS
(
  client_id      NUMBER(5) not null,
  client_fname   VARCHAR2(15),
  client_lname   VARCHAR2(15),
  client_addr    NUMBER(5),
  client_tel     NUMBER(5) not null,
  client_payment NUMBER(5),
  birthday       DATE,
  fathername     VARCHAR2(15),
  mothername     VARCHAR2(15),
  class_id       NUMBER(3)
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
alter table CLIENTS
  add foreign key (CLASS_ID)
  references CLASS_ (CLASS_ID);

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

prompt Creating SUBJECT...
create table SUBJECT
(
  subject_id   NUMBER(3) not null,
  subject_name VARCHAR2(30) not null,
  mandatory    NUMBER(1) not null
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
alter table SUBJECT
  add primary key (SUBJECT_ID)
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
alter table SUBJECT
  add check (mandatory = 1 OR mandatory = 0);

prompt Creating LESSON...
create table LESSON
(
  lesson_id   NUMBER(3) not null,
  lesson_day  INTEGER not null,
  lesson_hour INTEGER not null,
  class_id    NUMBER(3),
  teacher_id  NUMBER(3),
  subject_id  NUMBER(3)
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
alter table LESSON
  add primary key (LESSON_ID)
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
alter table LESSON
  add unique (CLASS_ID, LESSON_DAY, LESSON_HOUR)
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
alter table LESSON
  add unique (TEACHER_ID, LESSON_DAY, LESSON_HOUR)
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
alter table LESSON
  add foreign key (CLASS_ID)
  references CLASS_ (CLASS_ID);
alter table LESSON
  add foreign key (SUBJECT_ID)
  references SUBJECT (SUBJECT_ID);
alter table LESSON
  add foreign key (TEACHER_ID)
  references SCHTEACHER (TEACHER_ID);
alter table LESSON
  add check (Lesson_Day BETWEEN 1 AND 6);

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

prompt Creating WTEACHER...
create table WTEACHER
(
  teacher_id     NUMBER(5) not null,
  teacher_salary NUMBER,
  teacher_addr   NUMBER(5)
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
alter table WTEACHER
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
alter table WTEACHER
  add foreign key (TEACHER_ADDR)
  references CITY (CITY_NUM);
alter table WTEACHER
  add foreign key (TEACHER_ID)
  references TEACHER (TEACHER_ID);

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
  references WTEACHER (TEACHER_ID);
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
  references WTEACHER (TEACHER_ID);

prompt Disabling triggers for AGE_GROUP...
alter table AGE_GROUP disable all triggers;
prompt Disabling triggers for CITY...
alter table CITY disable all triggers;
prompt Disabling triggers for ROOMS...
alter table ROOMS disable all triggers;
prompt Disabling triggers for TEACHER...
alter table TEACHER disable all triggers;
prompt Disabling triggers for SCHTEACHER...
alter table SCHTEACHER disable all triggers;
prompt Disabling triggers for CLASS_...
alter table CLASS_ disable all triggers;
prompt Disabling triggers for CLIENTS...
alter table CLIENTS disable all triggers;
prompt Disabling triggers for GROUPS_...
alter table GROUPS_ disable all triggers;
prompt Disabling triggers for SUBJECT...
alter table SUBJECT disable all triggers;
prompt Disabling triggers for LESSON...
alter table LESSON disable all triggers;
prompt Disabling triggers for PARTICIPATE...
alter table PARTICIPATE disable all triggers;
prompt Disabling triggers for WORKSHOPS...
alter table WORKSHOPS disable all triggers;
prompt Disabling triggers for WTEACHER...
alter table WTEACHER disable all triggers;
prompt Disabling triggers for SCHEDULER...
alter table SCHEDULER disable all triggers;
prompt Disabling triggers for TEACH...
alter table TEACH disable all triggers;
prompt Disabling foreign key constraints for SCHTEACHER...
alter table SCHTEACHER disable constraint SYS_C008549;
prompt Disabling foreign key constraints for CLASS_...
alter table CLASS_ disable constraint SYS_C008556;
alter table CLASS_ disable constraint SYS_C008557;
prompt Disabling foreign key constraints for CLIENTS...
alter table CLIENTS disable constraint SYS_C008561;
alter table CLIENTS disable constraint SYS_C008562;
prompt Disabling foreign key constraints for GROUPS_...
alter table GROUPS_ disable constraint SYS_C008565;
prompt Disabling foreign key constraints for LESSON...
alter table LESSON disable constraint SYS_C008577;
alter table LESSON disable constraint SYS_C008578;
alter table LESSON disable constraint SYS_C008579;
prompt Disabling foreign key constraints for PARTICIPATE...
alter table PARTICIPATE disable constraint SYS_C008584;
alter table PARTICIPATE disable constraint SYS_C008585;
prompt Disabling foreign key constraints for WTEACHER...
alter table WTEACHER disable constraint SYS_C008590;
alter table WTEACHER disable constraint SYS_C008591;
prompt Disabling foreign key constraints for SCHEDULER...
alter table SCHEDULER disable constraint SYS_C008595;
alter table SCHEDULER disable constraint SYS_C008596;
alter table SCHEDULER disable constraint SYS_C008597;
alter table SCHEDULER disable constraint SYS_C008598;
prompt Disabling foreign key constraints for TEACH...
alter table TEACH disable constraint SYS_C008604;
alter table TEACH disable constraint SYS_C008605;
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
prompt Loading ROOMS...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (1, 4, 'F', 28, 1, to_date('22-06-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (2, 1, 'F', 21, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (3, 1, 'F', 12, 0, to_date('07-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (4, 3, 'F', 4, 1, to_date('28-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (5, 1, 'F', 23, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (6, 4, 'F', 16, 1, to_date('20-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (7, 3, 'F', 33, 1, to_date('03-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (8, 0, 'F', 24, 1, to_date('08-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (9, 0, 'F', 5, 1, to_date('15-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (10, 0, 'F', 26, 0, to_date('30-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (11, 3, 'F', 18, 1, to_date('07-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (12, 2, 'F', 27, 1, to_date('13-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (13, 3, 'F', 34, 1, to_date('04-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (14, 4, 'F', 27, 1, to_date('10-09-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (15, 2, 'F', 21, 0, to_date('18-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (16, 2, 'F', 4, 1, to_date('14-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (17, 1, 'F', 27, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (18, 0, 'F', 10, 1, to_date('13-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (19, 4, 'F', 5, 1, to_date('16-03-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (20, 3, 'F', 29, 0, to_date('02-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (21, 0, 'F', 30, 1, to_date('12-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (22, 1, 'F', 24, 0, to_date('22-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (23, 4, 'F', 39, 0, to_date('21-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (24, 2, 'F', 9, 0, to_date('17-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (25, 3, 'F', 26, 1, to_date('23-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (26, 2, 'F', 8, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (27, 1, 'F', 19, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (28, 4, 'F', 26, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (29, 4, 'F', 34, 1, to_date('05-09-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (30, 2, 'F', 18, 1, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (31, 4, 'F', 7, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (32, 2, 'F', 29, 1, to_date('04-12-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (33, 3, 'F', 4, 1, to_date('23-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (34, 3, 'F', 29, 0, to_date('21-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (35, 1, 'F', 13, 1, to_date('12-05-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (36, 2, 'F', 11, 0, to_date('08-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (37, 4, 'F', 7, 1, to_date('17-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (38, 3, 'F', 36, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (39, 0, 'F', 23, 1, to_date('03-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (40, 1, 'F', 26, 0, to_date('02-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (41, 3, 'F', 23, 1, to_date('09-05-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (42, 0, 'F', 24, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (43, 1, 'F', 39, 1, to_date('24-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (44, 3, 'F', 15, 0, to_date('18-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (45, 2, 'F', 6, 0, to_date('18-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (46, 4, 'F', 20, 0, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (47, 0, 'F', 24, 0, to_date('10-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (48, 2, 'F', 30, 0, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (49, 2, 'F', 6, 1, to_date('20-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (50, 3, 'F', 19, 0, to_date('17-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (51, 3, 'F', 24, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (52, 3, 'F', 16, 0, to_date('27-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (53, 4, 'F', 14, 1, to_date('20-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (54, 0, 'F', 11, 0, to_date('14-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (55, 2, 'F', 7, 0, to_date('18-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (56, 2, 'F', 15, 1, to_date('06-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (57, 0, 'F', 17, 1, to_date('15-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (58, 3, 'F', 28, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (59, 2, 'F', 6, 0, to_date('16-03-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (60, 4, 'F', 10, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (61, 0, 'F', 16, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (62, 2, 'F', 18, 0, to_date('16-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (63, 1, 'F', 5, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (64, 3, 'F', 38, 0, to_date('17-03-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (65, 1, 'F', 24, 0, to_date('18-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (66, 4, 'F', 9, 0, to_date('08-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (67, 2, 'F', 28, 1, to_date('07-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (68, 3, 'F', 28, 0, to_date('27-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (69, 4, 'F', 11, 1, to_date('14-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (70, 2, 'F', 14, 1, to_date('18-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (71, 1, 'F', 24, 1, to_date('11-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (72, 1, 'F', 4, 1, to_date('04-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (73, 1, 'F', 38, 1, to_date('24-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (74, 4, 'F', 14, 0, to_date('19-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (75, 1, 'F', 31, 0, to_date('19-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (76, 3, 'F', 21, 0, to_date('23-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (77, 1, 'F', 11, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (79, 0, 'F', 13, 1, to_date('25-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (82, 0, 'F', 33, 1, to_date('01-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (85, 0, 'F', 20, 0, to_date('16-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (89, 4, 'F', 16, 1, to_date('11-02-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (92, 4, 'F', 15, 1, to_date('31-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (95, 2, 'F', 14, 0, to_date('18-02-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (98, 0, 'F', 15, 0, to_date('24-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (101, 1, 'F', 18, 0, to_date('12-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (104, 2, 'F', 6, 0, to_date('30-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (107, 3, 'F', 18, 0, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (109, 1, 'F', 12, 0, to_date('21-03-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (112, 2, 'F', 10, 0, to_date('09-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (115, 2, 'F', 25, 1, to_date('03-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (118, 1, 'F', 13, 1, to_date('05-09-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (121, 1, 'F', 23, 1, to_date('05-10-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (123, 4, 'F', 7, 0, to_date('29-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (126, 1, 'F', 25, 1, to_date('08-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (129, 3, 'F', 16, 1, to_date('21-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (132, 3, 'F', 7, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (135, 4, 'F', 20, 0, to_date('05-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (138, 2, 'F', 39, 1, to_date('17-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (141, 0, 'F', 19, 1, to_date('20-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (144, 2, 'F', 21, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (147, 4, 'F', 19, 1, to_date('16-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (150, 2, 'F', 37, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (152, 4, 'F', 33, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (155, 4, 'F', 14, 0, to_date('11-01-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (157, 2, 'F', 25, 0, to_date('16-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (160, 1, 'F', 36, 0, to_date('20-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (163, 2, 'F', 26, 0, to_date('01-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (166, 2, 'F', 32, 0, to_date('08-06-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (168, 1, 'F', 27, 1, to_date('23-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (171, 3, 'F', 11, 0, to_date('24-05-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (174, 3, 'F', 11, 0, to_date('03-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (176, 2, 'F', 26, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (179, 4, 'F', 25, 1, to_date('26-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (182, 3, 'F', 35, 0, to_date('07-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (185, 3, 'F', 30, 0, to_date('20-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (188, 0, 'F', 24, 1, to_date('14-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (191, 4, 'F', 34, 0, to_date('19-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (193, 3, 'F', 8, 0, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (196, 4, 'F', 25, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (199, 0, 'F', 14, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (202, 4, 'F', 17, 1, to_date('05-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (205, 2, 'F', 17, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (207, 1, 'F', 30, 0, to_date('27-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (210, 2, 'F', 27, 0, to_date('25-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (213, 0, 'F', 30, 0, to_date('04-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (216, 0, 'F', 29, 0, to_date('09-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (218, 2, 'F', 6, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (221, 3, 'F', 36, 0, to_date('03-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (224, 1, 'F', 20, 0, to_date('11-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (227, 3, 'F', 26, 0, to_date('12-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (230, 3, 'F', 15, 0, to_date('13-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (232, 0, 'F', 36, 0, to_date('23-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (235, 0, 'F', 28, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (238, 3, 'F', 24, 0, to_date('11-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (240, 4, 'F', 5, 0, to_date('18-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (243, 3, 'F', 7, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (246, 3, 'F', 39, 1, to_date('23-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (249, 1, 'F', 24, 1, to_date('28-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (252, 1, 'F', 12, 1, to_date('22-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (254, 3, 'F', 9, 0, to_date('03-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (257, 0, 'F', 4, 0, to_date('21-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (260, 0, 'F', 22, 1, to_date('10-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (263, 2, 'F', 22, 0, to_date('25-02-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (266, 1, 'F', 27, 1, to_date('05-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (268, 3, 'F', 18, 0, to_date('22-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (271, 2, 'F', 19, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (274, 2, 'F', 13, 1, to_date('13-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (277, 1, 'F', 20, 0, to_date('12-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (280, 4, 'F', 6, 0, to_date('02-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (283, 1, 'F', 4, 0, to_date('04-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (285, 2, 'F', 29, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (288, 4, 'F', 20, 0, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (291, 4, 'F', 6, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (294, 4, 'F', 11, 1, to_date('16-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (297, 3, 'F', 31, 1, to_date('22-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (300, 3, 'F', 22, 1, to_date('29-12-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (302, 0, 'F', 28, 0, to_date('09-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (305, 4, 'F', 26, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (308, 0, 'F', 16, 0, to_date('02-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (311, 4, 'F', 20, 1, to_date('13-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (313, 1, 'F', 25, 0, to_date('13-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (316, 0, 'F', 5, 0, to_date('13-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (319, 1, 'F', 12, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (322, 0, 'F', 5, 0, to_date('22-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (324, 0, 'F', 9, 1, to_date('17-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (327, 1, 'F', 8, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (330, 3, 'F', 5, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (332, 3, 'F', 36, 0, to_date('04-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (335, 0, 'F', 30, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (338, 3, 'F', 15, 1, to_date('16-06-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (341, 3, 'F', 5, 0, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (344, 3, 'F', 22, 0, to_date('04-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (347, 0, 'F', 31, 0, to_date('03-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (349, 1, 'F', 35, 1, to_date('22-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (352, 4, 'F', 30, 1, to_date('19-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (355, 2, 'F', 23, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (358, 4, 'F', 18, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (361, 3, 'F', 7, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (364, 0, 'F', 12, 0, to_date('27-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (366, 4, 'F', 40, 1, to_date('31-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (369, 3, 'F', 5, 0, to_date('19-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (372, 1, 'F', 33, 0, to_date('27-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (374, 1, 'F', 22, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (377, 1, 'F', 31, 0, to_date('11-04-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (380, 3, 'F', 32, 0, to_date('12-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (382, 4, 'F', 27, 0, to_date('05-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (385, 4, 'F', 34, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (388, 0, 'F', 36, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (391, 0, 'F', 9, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (394, 2, 'F', 32, 0, to_date('12-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (396, 1, 'F', 6, 1, to_date('24-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (399, 2, 'F', 18, 0, to_date('20-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (401, 0, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (402, 3, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (403, 0, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (404, 1, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (405, 4, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (406, 0, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (407, 0, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (408, 1, 'F', 26, null, null);
commit;
prompt 200 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (409, 2, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (410, 0, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (411, 3, 'F', 33, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (412, 1, 'F', 32, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (413, 1, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (414, 1, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (415, 0, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (416, 0, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (417, 2, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (418, 1, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (419, 0, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (420, 1, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (421, 4, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (422, 3, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (423, 1, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (424, 4, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (425, 3, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (426, 2, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (427, 2, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (428, 1, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (429, 0, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (430, 4, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (431, 1, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (432, 0, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (433, 3, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (434, 3, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (435, 4, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (436, 2, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (437, 4, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (438, 3, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (439, 1, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (440, 0, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (441, 2, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (442, 4, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (443, 4, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (444, 3, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (445, 1, 'F', 12, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (446, 4, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (447, 4, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (448, 2, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (449, 2, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (450, 2, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (451, 0, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (452, 2, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (453, 4, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (454, 4, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (455, 3, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (456, 0, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (457, 1, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (458, 3, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (459, 4, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (460, 0, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (461, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (462, 2, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (463, 4, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (464, 1, 'F', 9, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (465, 2, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (466, 2, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (467, 0, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (468, 3, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (469, 2, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (470, 4, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (471, 4, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (472, 0, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (473, 0, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (474, 2, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (475, 0, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (476, 3, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (477, 3, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (478, 3, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (479, 3, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (480, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (481, 3, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (482, 2, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (483, 1, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (484, 0, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (485, 3, 'F', 10, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (486, 1, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (487, 0, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (488, 4, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (489, 3, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (490, 3, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (491, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (492, 4, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (493, 3, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (494, 3, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (495, 4, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (496, 2, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (497, 2, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (498, 4, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (499, 2, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (500, 2, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (501, 0, 'F', 32, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (502, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (503, 4, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (504, 2, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (505, 3, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (506, 3, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (507, 4, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (508, 2, 'F', 18, null, null);
commit;
prompt 300 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (509, 0, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (510, 2, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (78, 3, 'F', 32, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (80, 3, 'F', 24, 0, to_date('16-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (81, 1, 'F', 16, 1, to_date('10-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (83, 1, 'F', 13, 0, to_date('23-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (84, 0, 'F', 27, 0, to_date('04-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (86, 0, 'F', 20, 1, to_date('26-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (87, 2, 'F', 20, 0, to_date('11-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (88, 2, 'F', 33, 1, to_date('05-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (90, 4, 'F', 26, 0, to_date('15-09-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (91, 1, 'F', 36, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (93, 0, 'F', 35, 1, to_date('02-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (94, 2, 'F', 17, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (96, 3, 'F', 4, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (97, 1, 'F', 22, 1, to_date('05-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (99, 2, 'F', 6, 1, to_date('30-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (100, 4, 'F', 21, 1, to_date('21-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (102, 1, 'F', 26, 0, to_date('18-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (103, 4, 'F', 6, 1, to_date('06-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (105, 0, 'F', 21, 0, to_date('27-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (106, 3, 'F', 34, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (108, 2, 'F', 26, 1, to_date('02-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (110, 0, 'F', 8, 1, to_date('08-03-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (111, 4, 'F', 29, 0, to_date('19-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (113, 3, 'F', 16, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (114, 4, 'F', 30, 0, to_date('13-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (116, 1, 'F', 16, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (117, 2, 'F', 5, 1, to_date('28-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (119, 2, 'F', 37, 0, to_date('29-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (120, 3, 'F', 25, 1, to_date('05-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (122, 3, 'F', 26, 1, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (124, 0, 'F', 9, 0, to_date('01-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (125, 1, 'F', 40, 1, to_date('02-05-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (127, 0, 'F', 22, 1, to_date('19-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (128, 4, 'F', 10, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (130, 1, 'F', 8, 1, to_date('01-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (131, 0, 'F', 26, 1, to_date('28-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (133, 2, 'F', 8, 0, to_date('15-04-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (134, 0, 'F', 21, 1, to_date('25-05-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (136, 1, 'F', 16, 0, to_date('28-02-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (137, 4, 'F', 33, 0, to_date('06-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (139, 0, 'F', 34, 1, to_date('09-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (140, 4, 'F', 21, 0, to_date('18-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (142, 3, 'F', 31, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (143, 1, 'F', 10, 0, to_date('26-09-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (145, 0, 'F', 12, 0, to_date('09-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (146, 4, 'F', 30, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (148, 4, 'F', 22, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (149, 1, 'F', 6, 1, to_date('06-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (151, 4, 'F', 27, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (153, 2, 'F', 38, 0, to_date('17-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (154, 3, 'F', 23, 0, to_date('16-02-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (156, 1, 'F', 4, 0, to_date('05-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (158, 0, 'F', 23, 1, to_date('25-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (159, 4, 'F', 23, 0, to_date('22-03-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (161, 1, 'F', 36, 1, to_date('19-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (162, 4, 'F', 33, 0, to_date('16-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (164, 3, 'F', 9, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (165, 1, 'F', 4, 1, to_date('05-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (167, 3, 'F', 22, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (169, 3, 'F', 25, 0, to_date('16-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (170, 1, 'F', 30, 1, to_date('04-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (172, 3, 'F', 5, 1, to_date('28-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (173, 4, 'F', 11, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (175, 4, 'F', 12, 1, to_date('04-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (177, 1, 'F', 18, 1, to_date('26-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (178, 0, 'F', 28, 0, to_date('03-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (180, 2, 'F', 20, 0, to_date('31-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (181, 4, 'F', 33, 1, to_date('01-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (183, 0, 'F', 39, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (184, 0, 'F', 38, 1, to_date('25-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (186, 1, 'F', 24, 1, to_date('21-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (187, 4, 'F', 11, 0, to_date('14-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (189, 4, 'F', 31, 1, to_date('21-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (190, 3, 'F', 17, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (192, 3, 'F', 40, 1, to_date('03-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (194, 1, 'F', 33, 1, to_date('21-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (195, 3, 'F', 20, 0, to_date('17-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (197, 3, 'F', 6, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (198, 0, 'F', 25, 1, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (200, 4, 'F', 5, 0, to_date('16-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (201, 0, 'F', 23, 0, to_date('04-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (203, 3, 'F', 38, 1, to_date('22-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (204, 4, 'F', 22, 1, to_date('28-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (206, 3, 'F', 23, 1, to_date('11-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (208, 2, 'F', 22, 0, to_date('24-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (209, 0, 'F', 22, 0, to_date('09-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (211, 4, 'F', 15, 1, to_date('26-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (212, 2, 'F', 28, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (214, 2, 'F', 36, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (215, 4, 'F', 24, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (217, 1, 'F', 17, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (219, 0, 'F', 37, 1, to_date('23-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (220, 0, 'F', 25, 0, to_date('25-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (222, 4, 'F', 31, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (223, 1, 'F', 25, 0, to_date('11-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (225, 1, 'F', 15, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (226, 3, 'F', 34, 1, to_date('15-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (228, 2, 'F', 24, 0, to_date('27-04-2021', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (229, 1, 'F', 18, 1, to_date('13-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (231, 3, 'F', 4, 1, to_date('01-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (233, 3, 'F', 32, 1, to_date('17-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (234, 0, 'F', 23, 1, to_date('19-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (236, 3, 'F', 17, 0, to_date('04-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (237, 2, 'F', 36, 0, to_date('26-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (239, 2, 'F', 28, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (241, 4, 'F', 20, 0, to_date('25-09-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (242, 3, 'F', 36, 0, to_date('21-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (244, 1, 'F', 40, 1, to_date('01-10-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (245, 4, 'F', 8, 1, to_date('24-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (247, 1, 'F', 14, 1, to_date('08-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (248, 2, 'F', 40, 0, to_date('11-01-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (250, 4, 'F', 22, 0, to_date('23-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (251, 3, 'F', 28, 1, to_date('01-08-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (253, 1, 'F', 25, 1, to_date('22-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (255, 4, 'F', 25, 1, to_date('22-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (256, 1, 'F', 22, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (258, 3, 'F', 35, 1, to_date('31-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (259, 0, 'F', 29, 0, to_date('08-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (261, 0, 'F', 20, 1, to_date('28-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (262, 2, 'F', 24, 1, to_date('06-02-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (264, 1, 'F', 30, 1, to_date('28-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (265, 0, 'F', 28, 1, to_date('04-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (267, 2, 'F', 16, 1, to_date('27-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (269, 2, 'F', 39, 1, to_date('09-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (270, 0, 'F', 11, 0, to_date('01-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (272, 1, 'F', 34, 0, to_date('28-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (273, 4, 'F', 16, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (275, 0, 'F', 28, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (276, 0, 'F', 20, 0, to_date('04-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (278, 4, 'F', 16, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (279, 2, 'F', 13, 0, to_date('05-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (281, 2, 'F', 13, 1, to_date('01-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (282, 1, 'F', 19, 1, to_date('19-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (284, 3, 'F', 35, 1, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (286, 2, 'F', 7, 0, to_date('12-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (287, 0, 'F', 30, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (289, 3, 'F', 39, 0, to_date('27-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (290, 0, 'F', 7, 0, to_date('21-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (292, 1, 'F', 5, 0, to_date('10-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (293, 4, 'F', 37, 0, to_date('13-03-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (295, 1, 'F', 23, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (296, 3, 'F', 17, 1, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (298, 2, 'F', 12, 0, to_date('12-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (299, 1, 'F', 6, 1, to_date('19-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (301, 1, 'F', 8, 0, to_date('30-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (303, 4, 'F', 23, 1, to_date('24-03-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (304, 2, 'F', 26, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (306, 3, 'F', 16, 1, to_date('13-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (307, 2, 'F', 40, 0, to_date('16-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (309, 0, 'F', 13, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (310, 1, 'F', 23, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (312, 1, 'F', 16, 0, to_date('16-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (314, 3, 'F', 15, 1, to_date('12-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (315, 1, 'F', 31, 1, to_date('22-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (317, 2, 'F', 15, 0, to_date('04-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (318, 2, 'F', 19, 0, to_date('21-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (320, 3, 'F', 30, 1, to_date('28-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (321, 4, 'F', 11, 1, to_date('14-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (323, 2, 'F', 18, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (325, 4, 'F', 28, 1, to_date('23-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (326, 1, 'F', 16, 1, to_date('20-12-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (328, 4, 'F', 32, 0, to_date('22-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (329, 3, 'F', 35, 0, to_date('01-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (331, 1, 'F', 14, 0, to_date('20-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (333, 0, 'F', 7, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (334, 1, 'F', 17, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (336, 2, 'F', 24, 0, to_date('27-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (337, 3, 'F', 36, 1, to_date('22-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (339, 0, 'F', 14, 1, to_date('15-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (340, 2, 'F', 10, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (342, 3, 'F', 12, 0, to_date('11-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (343, 1, 'F', 30, 0, to_date('03-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (345, 4, 'F', 14, 1, to_date('04-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (346, 2, 'F', 34, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (348, 3, 'F', 27, 0, to_date('11-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (350, 0, 'F', 9, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (351, 3, 'F', 24, 1, to_date('17-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (353, 4, 'F', 40, 0, to_date('12-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (354, 0, 'F', 17, 0, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (356, 4, 'F', 22, 1, to_date('23-03-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (357, 4, 'F', 20, 1, to_date('09-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (359, 2, 'F', 21, 1, to_date('09-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (360, 1, 'F', 30, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (362, 2, 'F', 9, 1, to_date('05-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (363, 0, 'F', 28, 1, to_date('22-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (365, 2, 'F', 35, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (367, 1, 'F', 15, 0, to_date('17-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (368, 3, 'F', 17, 1, to_date('30-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (370, 3, 'F', 21, 1, to_date('14-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (371, 3, 'F', 4, 1, to_date('02-12-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (373, 1, 'F', 27, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (375, 2, 'F', 30, 0, to_date('03-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (376, 2, 'F', 23, 1, to_date('24-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (378, 4, 'F', 25, 1, to_date('13-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (379, 3, 'F', 30, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (381, 3, 'F', 37, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (383, 2, 'F', 17, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (384, 0, 'F', 35, 1, to_date('15-03-2023', 'dd-mm-yyyy'));
commit;
prompt 500 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (386, 2, 'F', 5, 1, to_date('07-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (387, 3, 'F', 24, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (389, 0, 'F', 8, 1, to_date('18-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (390, 2, 'F', 38, 1, to_date('13-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (392, 1, 'F', 14, 0, to_date('25-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (393, 3, 'F', 33, 0, to_date('27-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (395, 2, 'F', 7, 1, to_date('09-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (397, 4, 'F', 27, 0, to_date('26-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (398, 0, 'F', 20, 1, to_date('01-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (400, 2, 'F', 29, 1, to_date('04-03-2021', 'dd-mm-yyyy'));
commit;
prompt 510 records loaded
prompt Loading TEACHER...
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (1, 'Neneh', 'Price', 68611, to_date('16-04-1956', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (2, 'Treat', 'Dorff', 84533, to_date('15-06-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (3, 'Tommy', 'Portman', 18453, to_date('03-12-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (4, 'Henry', 'Rosas', 74083, to_date('19-09-1982', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (5, 'Beverley', 'Goldwyn', 42328, to_date('09-07-1958', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (6, 'Ernie', 'Makeba', 96996, to_date('14-10-1971', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (7, 'Gilberto', 'Satriani', 57321, to_date('01-08-1992', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (8, 'Jeffrey', 'Albright', 70912, to_date('24-05-1958', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (9, 'Emm', 'Craven', 50162, to_date('04-05-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (10, 'Hex', 'Folds', 84571, to_date('06-10-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (11, 'Woody', 'Doucette', 37587, to_date('26-12-1967', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (12, 'Nigel', 'Wincott', 42958, to_date('21-08-1988', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (13, 'Taye', 'Parm', 18621, to_date('04-12-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (14, 'Chuck', 'McKean', 51064, to_date('09-02-1955', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (15, 'Clarence', 'Dickinson', 89284, to_date('15-08-1993', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (16, 'Tara', 'Harmon', 91867, to_date('03-07-1980', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (17, 'Philip', 'Ruffalo', 89543, to_date('12-08-1959', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (18, 'Shirley', 'Gough', 28757, to_date('29-08-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (19, 'Nathan', 'Prinze', 90146, to_date('23-02-1965', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (20, 'Carol', 'Green', 23674, to_date('10-12-1964', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (21, 'Colin', 'O''Neal', 95046, to_date('13-07-1992', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (24, 'Jose', 'Berenger', 57489, to_date('24-10-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (25, 'Emerson', 'Trejo', 50348, to_date('29-04-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (26, 'Coley', 'Sawa', 57119, to_date('18-02-1963', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (27, 'Kitty', 'Ripley', 84523, to_date('02-10-1987', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (29, 'Roddy', 'Gordon', 10314, to_date('02-07-1971', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (30, 'Vin', 'Navarro', 61518, to_date('22-04-1969', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (31, 'Paul', 'Garfunkel', 70916, to_date('01-12-1980', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (32, 'Debra', 'Rodriguez', 11255, to_date('06-03-1984', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (33, 'Andrea', 'Hawn', 18298, to_date('22-12-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (34, 'Annette', 'Barnett', 84558, to_date('11-04-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (35, 'Chuck', 'Mueller-Stahl', 24922, to_date('31-03-1958', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (37, 'Ellen', 'Vanian', 15622, to_date('04-10-1967', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (38, 'Julianna', 'O''Neal', 64689, to_date('25-03-1982', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (39, 'Cameron', 'Griffin', 47937, to_date('11-08-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (40, 'Rita', 'Lynne', 20574, to_date('19-05-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (41, 'Hal', 'Stevens', 71668, to_date('01-10-1990', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (42, 'Rhys', 'Hershey', 19950, to_date('12-01-1960', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (43, 'Mekhi', 'O''Connor', 30948, to_date('09-11-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (44, 'Adrien', 'Navarro', 15821, to_date('16-02-1992', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (46, 'Joseph', 'Mattea', 99474, to_date('17-07-1992', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (47, 'Tilda', 'Cohn', 73075, to_date('10-10-1971', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (48, 'Bridgette', 'O''Donnell', 13020, to_date('25-01-1973', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (49, 'Alan', 'Dunst', 42723, to_date('07-02-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (50, 'Anthony', 'Benet', 10617, to_date('07-02-1956', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (53, 'Phoebe', 'Oates', 96438, to_date('02-09-1991', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (54, 'David', 'McAnally', 71714, to_date('28-01-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (55, 'Daryle', 'Hanley', 47394, to_date('11-05-1981', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (56, 'Wade', 'McDowell', 74456, to_date('17-05-1990', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (57, 'Dionne', 'Daniels', 40852, to_date('08-05-1956', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (58, 'Jessica', 'Wood', 20455, to_date('06-08-1966', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (59, 'Austin', 'Leachman', 24045, to_date('05-01-1967', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (60, 'Robby', 'Gayle', 23513, to_date('20-08-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (61, 'Hex', 'Paymer', 48999, to_date('17-11-1989', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (62, 'Russell', 'Oakenfold', 77889, to_date('13-05-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (63, 'Rueben', 'Sanchez', 80172, to_date('01-03-1962', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (64, 'Steven', 'Vassar', 27165, to_date('17-07-1987', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (65, 'Bryan', 'Lemmon', 75685, to_date('27-04-1966', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (66, 'Emilio', 'Tillis', 38055, to_date('17-08-1984', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (67, 'Kurt', 'Faithfull', 45451, to_date('23-07-1993', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (68, 'Meg', 'Diddley', 78659, to_date('23-09-1989', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (69, 'Jonatha', 'Diaz', 81961, to_date('24-09-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (70, 'Wang', 'Kurtz', 73234, to_date('06-04-1975', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (71, 'Miguel', 'Shand', 22022, to_date('16-06-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (72, 'Maura', 'Gold', 87969, to_date('19-07-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (73, 'Lila', 'Lewis', 40222, to_date('18-12-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (76, 'Frankie', 'Thorton', 42991, to_date('26-10-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (77, 'Dylan', 'Negbaur', 79930, to_date('07-08-1991', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (78, 'Kathleen', 'Hershey', 79873, to_date('04-08-1993', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (80, 'Adina', 'Lauper', 86355, to_date('26-09-1993', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (81, 'Nik', 'Nakai', 53958, to_date('26-12-1970', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (82, 'Wallace', 'Sobieski', 73145, to_date('18-08-1974', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (83, 'Robert', 'Whitford', 23383, to_date('13-04-1963', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (84, 'Doug', 'Crouse', 57875, to_date('25-11-1959', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (85, 'Ossie', 'Wen', 55568, to_date('04-06-1996', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (86, 'Chet', 'Finn', 34938, to_date('01-10-1961', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (87, 'Mae', 'Watley', 70840, to_date('06-09-1955', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (88, 'Judi', 'Yorn', 32603, to_date('08-06-1980', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (90, 'Aida', 'Holmes', 84431, to_date('19-07-1963', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (91, 'Gates', 'Berkeley', 71021, to_date('11-01-1950', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (92, 'Tori', 'Iglesias', 54533, to_date('13-04-1985', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (93, 'Pete', 'Kahn', 42721, to_date('03-05-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (94, 'Eliza', 'McLachlan', 88696, to_date('04-05-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (95, 'Delbert', 'Scott', 53852, to_date('14-02-1973', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (96, 'Tzi', 'Ferrell', 55908, to_date('01-08-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (98, 'Connie', 'Vannelli', 57321, to_date('27-02-1975', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (99, 'Lindsey', 'Heche', 45224, to_date('06-12-1976', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (100, 'Lauren', 'Dourif', 52166, to_date('14-03-1971', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (101, 'Eric', 'Adler', 79540, to_date('11-04-1975', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (102, 'Joan', 'Conley', 92672, to_date('17-10-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (103, 'Janeane', 'Orton', 24274, to_date('02-05-1995', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (104, 'Geena', 'Pierce', 72506, to_date('10-05-1966', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (105, 'Terence', 'Clarkson', 38333, to_date('04-10-1984', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (106, 'Kirsten', 'Sizemore', 75767, to_date('14-01-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (107, 'Chubby', 'Moore', 21299, to_date('26-12-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (108, 'Nancy', 'Matthau', 96077, to_date('02-06-1973', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (109, 'Loretta', 'Lewis', 11607, to_date('17-08-1962', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (111, 'Tracy', 'Lang', 86287, to_date('22-04-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (112, 'Freda', 'Doucette', 83798, to_date('14-10-1974', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (113, 'Nick', 'Kilmer', 73062, to_date('31-03-1959', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (114, 'Rolando', 'Webb', 57170, to_date('19-07-1973', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (116, 'Armand', 'Lucien', 15798, to_date('25-11-1950', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (118, 'Tamala', 'MacDonald', 12439, to_date('02-12-1960', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (119, 'Minnie', 'Law', 74157, to_date('03-04-1999', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (120, 'Andrew', 'Palminteri', 24479, to_date('26-05-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (121, 'Albertina', 'Makeba', 51246, to_date('12-10-1987', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (123, 'Frederic', 'Silverman', 81048, to_date('09-03-1981', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (124, 'Catherine', 'Jeter', 83214, to_date('23-05-1956', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (125, 'Victoria', 'Borgnine', 39730, to_date('14-01-1976', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (126, 'Teri', 'Santa Rosa', 10706, to_date('27-03-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (127, 'Rory', 'Margolyes', 75364, to_date('31-03-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (128, 'Phil', 'Garofalo', 60657, to_date('31-10-1960', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (129, 'Marina', 'Cervine', 16971, to_date('15-09-1971', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (130, 'Liev', 'Kudrow', 84437, to_date('01-06-1995', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (131, 'Boyd', 'Underwood', 65462, to_date('13-11-1980', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (132, 'Stevie', 'Pierce', 50689, to_date('24-01-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (133, 'Mae', 'Cross', 62235, to_date('08-09-1958', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (135, 'Campbell', 'Ness', 53726, to_date('24-10-1963', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (137, 'Neve', 'Balaban', 32690, to_date('29-06-1967', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (138, 'Rosanna', 'Rodgers', 15464, to_date('10-12-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (140, 'Jeffrey', 'Preston', 79192, to_date('23-02-1975', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (141, 'Kevn', 'Fiennes', 69137, to_date('03-03-1999', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (142, 'Alana', 'Penders', 21211, to_date('02-01-1950', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (143, 'Wes', 'Duchovny', 12525, to_date('01-08-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (144, 'Adrien', 'Laurie', 69772, to_date('28-12-1960', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (145, 'Bill', 'McGinley', 72349, to_date('09-05-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (146, 'Whoopi', 'Stevenson', 96023, to_date('30-08-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (148, 'Peter', 'Tomei', 46417, to_date('14-07-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (149, 'Charlie', 'Clayton', 40052, to_date('11-06-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (151, 'Pat', 'Thurman', 67627, to_date('27-11-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (152, 'Suzy', 'Fiennes', 75132, to_date('02-03-1982', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (153, 'Hikaru', 'Burmester', 94516, to_date('22-11-1989', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (154, 'Cloris', 'Jeter', 12627, to_date('22-02-1970', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (155, 'Edward', 'Kattan', 22221, to_date('16-05-1967', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (156, 'Geggy', 'Margulies', 24916, to_date('02-06-1971', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (157, 'Gina', 'Davidson', 20780, to_date('25-08-1996', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (158, 'Mia', 'Sharp', 53187, to_date('16-07-1979', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (159, 'Powers', 'King', 70616, to_date('23-06-1980', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (160, 'Stanley', 'Rhys-Davies', 27086, to_date('24-04-1970', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (162, 'Jill', 'Coughlan', 83984, to_date('19-06-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (163, 'Cathy', 'Birch', 79886, to_date('20-05-1990', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (165, 'Lennie', 'Bates', 16423, to_date('01-10-1988', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (166, 'Ike', 'Vaughan', 56299, to_date('01-05-1962', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (167, 'Neve', 'Rankin', 41911, to_date('19-12-1957', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (168, 'Collective', 'Horton', 50698, to_date('27-12-1988', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (169, 'Jim', 'Orton', 12482, to_date('05-01-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (170, 'Joan', 'O''Hara', 29127, to_date('06-11-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (171, 'Natacha', 'Spears', 81295, to_date('12-09-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (172, 'Carol', 'O''Connor', 98946, to_date('18-09-1987', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (174, 'Edgar', 'Fiorentino', 40684, to_date('10-05-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (175, 'Miles', 'Rauhofer', 63894, to_date('19-08-1995', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (176, 'Emm', 'Brody', 41199, to_date('18-08-1959', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (177, 'Crispin', 'Berkley', 46635, to_date('18-04-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (178, 'Cheryl', 'Fox', 75534, to_date('13-04-1982', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (179, 'Nelly', 'Flanagan', 65983, to_date('30-06-1965', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (180, 'David', 'Paquin', 36970, to_date('19-08-1976', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (181, 'Sara', 'Larter', 38160, to_date('15-04-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (183, 'Herbie', 'Dreyfuss', 84035, to_date('15-12-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (184, 'Lynn', 'Ripley', 52110, to_date('21-02-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (185, 'Dave', 'Aiken', 36253, to_date('28-11-1986', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (186, 'Katrin', 'Head', 87256, to_date('26-02-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (187, 'Miles', 'Sossamon', 65136, to_date('19-12-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (188, 'Night', 'Dafoe', 87501, to_date('30-04-1967', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (189, 'Joey', 'Rubinek', 79121, to_date('05-05-1958', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (190, 'Marc', 'Leachman', 87907, to_date('31-03-1976', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (191, 'Jean', 'Dean', 78017, to_date('08-04-1981', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (192, 'Clive', 'Luongo', 53369, to_date('20-07-1975', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (193, 'Woody', 'Cochran', 59872, to_date('16-09-1958', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (195, 'Aidan', 'Fichtner', 84716, to_date('24-12-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (196, 'Brian', 'Chilton', 99229, to_date('07-11-1984', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (197, 'Keith', 'Azaria', 40982, to_date('05-10-1988', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (198, 'Kirsten', 'Logue', 92772, to_date('27-01-1976', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (200, 'Howard', 'McLean', 49452, to_date('14-08-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (201, 'Vanessa', 'Sawa', 79399, to_date('04-09-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (203, 'Drew', 'Evanswood', 88585, to_date('04-09-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (204, 'Lee', 'von Sydow', 14452, to_date('01-05-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (206, 'Red', 'Boone', 19217, to_date('18-04-1976', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (207, 'Winona', 'Redgrave', 20053, to_date('23-02-1959', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (208, 'Marlon', 'Cara', 17505, to_date('21-06-1990', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (209, 'Melanie', 'Curry', 13234, to_date('19-07-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (210, 'Devon', 'Epps', 84032, to_date('19-03-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (212, 'Lin', 'Klein', 77193, to_date('18-07-1991', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (213, 'Jon', 'Bell', 29515, to_date('30-11-1999', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (214, 'Trick', 'Sedaka', 19529, to_date('05-08-1993', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (215, 'Jill', 'Visnjic', 88663, to_date('23-03-1986', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (216, 'Terrence', 'Dean', 25464, to_date('19-03-1961', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (218, 'Lauren', 'Easton', 53345, to_date('17-05-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (219, 'Diane', 'Chan', 42889, to_date('10-11-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (220, 'Nicholas', 'Borden', 51330, to_date('31-07-1993', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (221, 'Carrie-Anne', 'Vince', 60506, to_date('09-10-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (222, 'Colin', 'Utada', 99132, to_date('09-11-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (223, 'Judge', 'Reeves', 68475, to_date('24-07-1970', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (224, 'Pamela', 'Thorton', 80179, to_date('27-07-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (226, 'Chris', 'Paquin', 61188, to_date('26-08-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (227, 'Dorry', 'Furay', 98674, to_date('04-09-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (229, 'Brooke', 'Stone', 77289, to_date('06-07-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (231, 'Lynette', 'Lawrence', 93112, to_date('01-02-1982', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (232, 'Lois', 'Warden', 65543, to_date('28-06-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (235, 'Fionnula', 'Kahn', 45699, to_date('30-01-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (236, 'Rebeka', 'Harris', 67320, to_date('17-09-1980', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (239, 'Diane', 'Gandolfini', 43161, to_date('30-04-1976', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (240, 'Oro', 'Vannelli', 40614, to_date('18-10-1985', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (241, 'Edgar', 'McGoohan', 11959, to_date('01-02-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (242, 'Irene', 'Adkins', 52348, to_date('05-10-1996', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (243, 'Melba', 'Bright', 14203, to_date('03-01-1985', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (245, 'Drew', 'Paige', 56743, to_date('12-05-1963', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (246, 'Celia', 'Sandoval', 65564, to_date('10-06-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (247, 'Al', 'Mantegna', 69294, to_date('15-01-1960', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (248, 'Spike', 'Bridges', 87741, to_date('17-10-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (249, 'Cameron', 'Mirren', 89387, to_date('27-07-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (250, 'Reese', 'Guinness', 72351, to_date('01-04-1973', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (251, 'Woody', 'Ramirez', 81075, to_date('07-06-1962', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (252, 'Willem', 'Burrows', 79265, to_date('22-02-1962', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (253, 'Isaiah', 'Briscoe', 13187, to_date('11-02-1998', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (254, 'Aidan', 'Hershey', 93632, to_date('11-05-1959', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (255, 'Rod', 'David', 35397, to_date('21-10-1956', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (256, 'Stellan', 'Finn', 70691, to_date('23-11-1989', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (258, 'Gaby', 'Wainwright', 80506, to_date('28-05-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (259, 'Molly', 'Brooks', 72980, to_date('22-12-1989', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (260, 'Dennis', 'McCoy', 42170, to_date('19-10-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (261, 'Daryl', 'MacDonald', 89220, to_date('17-04-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (263, 'Bernie', 'Himmelman', 41695, to_date('12-09-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (264, 'Holland', 'Zane', 22769, to_date('02-04-1960', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (265, 'Mae', 'Stiers', 93864, to_date('07-05-1962', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (267, 'Ronny', 'Cassel', 89482, to_date('17-07-1964', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (268, 'Burt', 'Baranski', 71662, to_date('26-01-1985', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (269, 'Sammy', 'Wariner', 25307, to_date('25-04-1966', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (270, 'Suzanne', 'Coolidge', 38033, to_date('03-06-1974', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (271, 'Todd', 'Sainte-Marie', 47875, to_date('15-11-1961', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (272, 'Liev', 'Burns', 84948, to_date('19-05-1990', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (273, 'Chrissie', 'Bale', 15126, to_date('23-05-1970', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (275, 'Gilberto', 'Mandrell', 36172, to_date('16-12-1988', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (277, 'Nils', 'Kane', 94971, to_date('02-03-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (278, 'Kathleen', 'Hall', 64089, to_date('16-08-1984', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (279, 'Hope', 'Young', 36212, to_date('19-03-1992', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (280, 'Rachel', 'Andrews', 83991, to_date('12-10-1950', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (281, 'Quentin', 'Slater', 44163, to_date('02-12-1995', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (282, 'Trace', 'DiBiasio', 58228, to_date('13-09-1959', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (284, 'Katrin', 'Koteas', 86666, to_date('23-06-1997', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (285, 'Marlon', 'Turner', 97916, to_date('11-01-1979', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (286, 'Victor', 'Lindley', 10673, to_date('30-03-1996', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (288, 'David', 'Keen', 10578, to_date('21-07-1988', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (289, 'Joseph', 'Stowe', 86189, to_date('22-07-1961', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (293, 'Vickie', 'Emmett', 63153, to_date('21-11-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (294, 'Marianne', 'Nicholas', 97044, to_date('17-02-1956', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (295, 'Rade', 'Thomson', 80144, to_date('09-04-1960', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (296, 'Oro', 'Lillard', 47429, to_date('22-01-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (297, 'Lindsay', 'Margulies', 87291, to_date('24-07-1957', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (298, 'David', 'Underwood', 25038, to_date('31-08-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (300, 'Buddy', 'DeVito', 44089, to_date('13-02-1998', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (301, 'Taryn', 'Belushi', 52123, to_date('04-03-1964', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (302, 'Edgar', 'Olin', 46851, to_date('05-08-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (303, 'Rosie', 'Payne', 61354, to_date('23-12-1992', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (305, 'Mos', 'Milsap', 17550, to_date('11-06-1957', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (306, 'Tamala', 'Sweet', 64254, to_date('09-06-1981', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (307, 'Alec', 'Iglesias', 32507, to_date('20-03-1973', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (308, 'Teri', 'Atlas', 20741, to_date('31-12-1987', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (309, 'Lydia', 'Richardson', 51827, to_date('18-05-1993', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (310, 'Seth', 'Ford', 16246, to_date('08-01-1981', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (311, 'Collin', 'Gold', 22199, to_date('30-01-1988', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (312, 'Boyd', 'Ticotin', 61762, to_date('26-07-1989', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (313, 'Woody', 'Jackman', 34164, to_date('02-08-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (314, 'Adam', 'Palminteri', 37431, to_date('01-03-1999', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (315, 'Daryl', 'Osmond', 53631, to_date('29-08-1989', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (318, 'Collective', 'Buffalo', 82022, to_date('06-07-1984', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (320, 'Linda', 'Gough', 88015, to_date('27-01-1962', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (321, 'Jimmie', 'Mohr', 14577, to_date('16-11-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (322, 'Joely', 'LuPone', 93472, to_date('08-07-1967', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (323, 'Kate', 'Adams', 90017, to_date('05-12-1971', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (324, 'Steven', 'Jamal', 57402, to_date('09-08-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (325, 'Millie', 'Myers', 97963, to_date('06-08-1991', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (326, 'Larnelle', 'Downey', 89728, to_date('28-06-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (327, 'Sigourney', 'Dalton', 72492, to_date('20-05-1956', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (328, 'Patty', 'Makowicz', 18323, to_date('22-07-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (329, 'Tim', 'Farris', 79601, to_date('01-05-1992', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (330, 'Manu', 'Haysbert', 74105, to_date('28-10-1989', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (331, 'Marisa', 'Pitney', 16936, to_date('10-09-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (332, 'Lloyd', 'Lithgow', 23712, to_date('27-01-1963', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (333, 'Victoria', 'MacDowell', 44302, to_date('18-07-1998', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (334, 'Jennifer', 'Mitra', 41798, to_date('30-04-1996', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (335, 'Udo', 'Shatner', 43256, to_date('05-05-1959', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (336, 'Laurie', 'Cronin', 67489, to_date('03-12-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (337, 'James', 'Nash', 36543, to_date('19-09-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (338, 'Ronnie', 'Rispoli', 82004, to_date('05-09-1993', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (339, 'Lois', 'Forrest', 10679, to_date('16-07-1991', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (340, 'Amy', 'Conlee', 77005, to_date('09-07-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (341, 'Taye', 'Conley', 37437, to_date('13-07-1956', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (342, 'Emma', 'Moriarty', 35679, to_date('31-12-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (343, 'Dean', 'Zappacosta', 82540, to_date('15-06-1965', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (344, 'Melanie', 'Tobolowsky', 91103, to_date('23-01-1984', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (345, 'Demi', 'Fiennes', 82330, to_date('04-03-1984', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (346, 'Courtney', 'Purefoy', 58915, to_date('27-07-1971', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (347, 'Talvin', 'Belle', 81691, to_date('01-08-1950', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (348, 'Daryl', 'Duncan', 83815, to_date('23-10-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (349, 'Gilberto', 'Keith', 69025, to_date('01-10-1988', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (350, 'Barbara', 'DeLuise', 21948, to_date('29-08-1955', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (351, 'Campbell', 'Sobieski', 66536, to_date('22-03-1969', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (352, 'Angie', 'Crimson', 63674, to_date('22-06-1986', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (354, 'Elvis', 'Snider', 83782, to_date('27-06-1971', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (355, 'Philip', 'Ferry', 57691, to_date('06-02-1950', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (357, 'Chaka', 'Blige', 45029, to_date('17-03-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (358, 'Ann', 'Sizemore', 12445, to_date('20-04-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (359, 'Sander', 'Snipes', 85271, to_date('06-02-1985', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (361, 'Nicole', 'Belushi', 14983, to_date('07-07-1991', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (362, 'Oliver', 'Brooks', 40870, to_date('01-08-1987', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (364, 'Lizzy', 'Posener', 72143, to_date('22-08-1985', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (365, 'Joaquim', 'Pitney', 38847, to_date('06-05-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (366, 'Jean-Luc', 'Dillon', 18394, to_date('18-05-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (367, 'Lily', 'Dorff', 65739, to_date('27-02-1963', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (368, 'Sigourney', 'Lynn', 67044, to_date('06-12-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (370, 'Wayman', 'Shorter', 97893, to_date('08-10-1950', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (371, 'Davis', 'Arjona', 90659, to_date('10-03-1960', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (372, 'Hazel', 'Davidtz', 69120, to_date('13-01-1965', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (373, 'Sydney', 'Malkovich', 94428, to_date('02-09-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (374, 'Bret', 'McBride', 78529, to_date('04-06-1967', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (375, 'Linda', 'MacNeil', 25017, to_date('30-08-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (376, 'Jena', 'Idle', 84564, to_date('30-08-1969', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (377, 'Carlos', 'Lynn', 54100, to_date('15-10-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (378, 'Aaron', 'Payton', 14136, to_date('06-05-1969', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (379, 'Daryle', 'Shue', 87568, to_date('22-09-1964', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (380, 'Kelli', 'Farrell', 16786, to_date('27-03-1986', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (381, 'Patricia', 'Roberts', 29409, to_date('22-05-1995', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (382, 'Derrick', 'Deejay', 17218, to_date('02-09-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (383, 'Jonny Lee', 'Teng', 53400, to_date('29-09-1977', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (384, 'Vendetta', 'Janssen', 80730, to_date('14-04-1950', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (385, 'Beverley', 'Clayton', 23413, to_date('12-09-1997', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (386, 'Suzi', 'Mac', 68582, to_date('22-08-1969', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (388, 'Brian', 'Gough', 52817, to_date('22-12-1987', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (389, 'Bo', 'Singletary', 48228, to_date('04-01-1987', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (390, 'Azucar', 'Ryder', 12589, to_date('06-09-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (391, 'Illeana', 'Lovitz', 27517, to_date('01-01-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (392, 'Miguel', 'Lloyd', 56506, to_date('24-09-1976', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (394, 'Mickey', 'Johansson', 98035, to_date('13-08-1986', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (395, 'Laurence', 'Collins', 65713, to_date('14-03-1969', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (396, 'Jake', 'Stuermer', 93493, to_date('14-01-1984', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (397, 'Bette', 'Biehn', 95258, to_date('26-12-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (398, 'Kathy', 'Affleck', 84655, to_date('24-12-1993', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (399, 'Curtis', 'Elizabeth', 43461, to_date('14-02-1969', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (400, 'Emilio', 'Carrere', 30520, to_date('19-04-1984', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (401, 'Jay', 'Marshall', 36000, to_date('09-05-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (402, 'Desmond', 'O''Donnell', 65249, to_date('03-07-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (403, 'Bridget', 'Bedelia', 54918, to_date('04-12-1957', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (404, 'Sammy', 'Wiedlin', 41823, to_date('20-11-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (405, 'Kris', 'Chan', 17928, to_date('02-05-1989', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (406, 'Stellan', 'Hutton', 33439, to_date('02-09-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (407, 'Meg', 'Postlethwaite', 39914, to_date('10-07-1998', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (408, 'Jeffery', 'Connick', 67192, to_date('08-04-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (409, 'Jet', 'Blanchett', 17413, to_date('11-01-1961', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (410, 'Leonardo', 'Diaz', 87047, to_date('06-06-1997', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (411, 'Marc', 'Bell', 39357, to_date('21-12-1988', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (412, 'Connie', 'Coburn', 85668, to_date('13-04-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (413, 'James', 'Reynolds', 89848, to_date('07-04-1959', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (414, 'Rebecca', 'Diggs', 97099, to_date('17-01-1985', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (415, 'Lois', 'Wilder', 51270, to_date('16-12-1962', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (416, 'Andrew', 'Garfunkel', 34857, to_date('13-07-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (417, 'Franco', 'Bracco', 48489, to_date('27-02-1992', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (420, 'Harry', 'Garcia', 95870, to_date('25-11-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (421, 'Heath', 'DeGraw', 93935, to_date('18-10-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (423, 'Benjamin', 'Levy', 10760, to_date('26-02-1999', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (424, 'Rhona', 'Horizon', 83893, to_date('18-03-1980', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (426, 'Laurence', 'Faithfull', 80807, to_date('08-02-1998', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (427, 'Louise', 'Williamson', 53025, to_date('27-12-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (428, 'Will', 'Holbrook', 14373, to_date('22-12-1988', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (429, 'Eddie', 'Weller', 25538, to_date('21-05-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (430, 'Ozzy', 'Molina', 11099, to_date('18-11-1985', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (431, 'Giovanni', 'Vince', 93580, to_date('10-06-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (434, 'Tanya', 'Quinones', 49904, to_date('13-03-1969', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (435, 'Laurence', 'Capshaw', 68426, to_date('03-01-1976', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (436, 'Jim', 'Mandrell', 62349, to_date('30-11-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (437, 'Patti', 'Hynde', 75563, to_date('25-07-1980', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (439, 'Glen', 'Gibson', 70013, to_date('11-05-1952', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (440, 'Cate', 'Flack', 86537, to_date('13-04-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (441, 'Gates', 'Manning', 62710, to_date('02-01-1987', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (442, 'Hugh', 'Wheel', 34106, to_date('02-04-1973', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (444, 'Lydia', 'Vaughan', 48324, to_date('30-11-1956', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (445, 'Gordie', 'Lonsdale', 73595, to_date('19-07-1975', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (447, 'Rickie', 'Pleasure', 98554, to_date('21-04-1958', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (448, 'Alice', 'Morton', 24229, to_date('25-09-1962', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (449, 'Cary', 'Torres', 57925, to_date('14-06-1999', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (451, 'Gavin', 'Swank', 89479, to_date('08-01-1991', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (455, 'Dermot', 'Cole', 79036, to_date('18-02-1995', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (458, 'Crispin', 'Secada', 26891, to_date('28-09-1995', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (459, 'Eddie', 'Skaggs', 70580, to_date('23-02-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (460, 'Meredith', 'Williamson', 53895, to_date('01-09-1993', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (462, 'Kasey', 'Stormare', 40743, to_date('28-04-1969', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (463, 'Burton', 'Garber', 85756, to_date('21-10-1958', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (464, 'Percy', 'Cleary', 39431, to_date('19-09-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (465, 'Orlando', 'Pride', 62012, to_date('13-02-1993', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (466, 'Rhett', 'Holiday', 50187, to_date('28-08-1971', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (467, 'Frances', 'Humphrey', 48654, to_date('12-03-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (468, 'Emm', 'Griggs', 40436, to_date('14-06-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (469, 'Anthony', 'Weiss', 17459, to_date('26-11-1956', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (470, 'Cevin', 'Suchet', 66511, to_date('02-08-1981', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (471, 'Roy', 'McGriff', 80598, to_date('30-12-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (472, 'April', 'Redgrave', 32647, to_date('08-08-1964', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (473, 'Isaiah', 'Van Der Beek', 32929, to_date('25-04-1975', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (475, 'Maria', 'Folds', 35553, to_date('28-10-1957', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (477, 'Karen', 'Ford', 96401, to_date('24-11-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (478, 'Terri', 'Yulin', 20267, to_date('14-05-1986', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (479, 'Robert', 'King', 76160, to_date('25-09-1959', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (480, 'Fred', 'Supernaw', 79518, to_date('04-12-1950', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (482, 'Ellen', 'Hanley', 18226, to_date('12-04-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (483, 'Steven', 'Tomlin', 40400, to_date('30-10-1981', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (484, 'Nelly', 'King', 35103, to_date('06-09-1979', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (485, 'Davy', 'Murphy', 10886, to_date('25-12-1966', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (486, 'Rich', 'Duschel', 39005, to_date('12-12-1987', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (488, 'Cate', 'Briscoe', 89250, to_date('15-03-1969', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (489, 'Swoosie', 'Spall', 28518, to_date('02-12-1966', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (490, 'Walter', 'Farris', 86491, to_date('11-09-1965', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (491, 'Joan', 'Posener', 52723, to_date('22-10-1958', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (494, 'Earl', 'Kattan', 79105, to_date('19-01-1982', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (495, 'Norm', 'Keitel', 92145, to_date('29-05-1984', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (496, 'Mitchell', 'Playboys', 56214, to_date('25-10-1967', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (497, 'Penelope', 'Brando', 41075, to_date('11-03-1986', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (498, 'Collective', 'Crewson', 86929, to_date('09-03-1951', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (499, 'Frances', 'Molina', 25573, to_date('02-10-1950', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (500, 'Vincent', 'Lewin', 88319, to_date('02-05-1965', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (501, 'Giancarlo', 'Cassel', 66245, to_date('23-05-1960', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (502, 'Tom', 'Taha', 34458, to_date('01-07-1996', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (504, 'Debi', 'Oldman', 88071, to_date('18-08-1968', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (506, 'Charlie', 'Branch', 38982, to_date('02-05-1950', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (507, 'Coley', 'Cooper', 38651, to_date('10-09-1978', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (508, 'Jodie', 'Portman', 58902, to_date('15-04-1994', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (509, 'Ani', 'Blanchett', 26519, to_date('27-06-1958', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (510, 'Bo', 'Coward', 34588, to_date('19-10-1981', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (600, 'Kalvin', 'Kleine', 55121, to_date('04-01-1962', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (601, 'Rickie', 'Stembridge', 12927, to_date('23-09-1974', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (602, 'Delora', 'De Paoli', 38602, to_date('22-02-1953', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (603, 'Malvina', 'Bouts', 35225, to_date('12-05-1983', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (604, 'Tracie', 'Hopkyns', 39920, to_date('04-05-1954', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (605, 'Maitilde', 'Renoden', 75971, to_date('24-12-1972', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (606, 'Ainsley', 'Merrydew', 30226, to_date('04-06-1958', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (607, 'Darrell', 'Lawles', 27046, to_date('09-12-1985', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (608, 'Steward', 'Rubra', 65288, to_date('25-08-1975', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (609, 'Patrica', 'Morshead', 48871, to_date('13-12-1961', 'dd-mm-yyyy'));
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (22, 'Pierce', 'Butler', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (23, 'Isaiah', 'Cobbs', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (28, 'Ashton', 'Dafoe', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (36, 'Christine', 'Orbit', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (45, 'Sammy', 'Cantrell', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (51, 'Kate', 'Paymer', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (74, 'Dean', 'Cozier', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (79, 'Rachael', 'Thurman', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (89, 'Tori', 'Postlethwaite', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (110, 'Ed', 'Fehr', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (115, 'Remy', 'Heche', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (117, 'Gordon', 'Hunt', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (122, 'Giancarlo', 'Hawkins', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (134, 'Shannyn', 'Burstyn', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (136, 'Lauren', 'Cartlidge', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (139, 'Andrae', 'Willis', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (147, 'Scarlett', 'Berry', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (150, 'Allan', 'Shepard', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (161, 'Diamond', 'Everett', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (164, 'Taylor', 'Singh', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (173, 'Xander', 'Rock', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (182, 'Giovanni', 'Trejo', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (194, 'Catherine', 'Summer', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (199, 'Harrison', 'Cromwell', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (202, 'Andrae', 'Hornsby', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (205, 'Danni', 'Whitmore', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (211, 'Denzel', 'Pigott-Smith', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (217, 'Tanya', 'Carradine', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (225, 'Bradley', 'Daniels', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (228, 'Darren', 'Heron', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (230, 'Timothy', 'Bean', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (237, 'Luis', 'Cooper', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (238, 'Lily', 'Davis', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (244, 'Coley', 'Conroy', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (257, 'Albertina', 'Cazale', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (262, 'Leon', 'Strathairn', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (266, 'Murray', 'Leary', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (274, 'Benicio', 'Weisberg', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (287, 'Lena', 'Bergen', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (290, 'Mika', 'Ellis', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (291, 'Gary', 'Sirtis', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (299, 'Ernest', 'Sorvino', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (304, 'Glenn', 'Lapointe', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (316, 'Jeffery', 'Navarro', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (317, 'Gary', 'Frost', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (353, 'Christian', 'Sedgwick', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (356, 'Joseph', 'Judd', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (360, 'Rupert', 'Harrison', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (363, 'Christmas', 'Wiedlin', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (369, 'Debbie', 'Paquin', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (387, 'Sophie', 'Patton', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (393, 'Cornell', 'Candy', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (283, 'Cherry', 'Emmett', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (292, 'Jack', 'Walken', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (319, 'Bryan', 'Westerberg', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (52, 'Parker', 'Ripley', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (75, 'Diane', 'Arthur', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (234, 'Ike', 'DeLuise', null, null);
insert into TEACHER (teacher_id, teacher_fname, teacher_lname, teacher_tel, teacher_join_date)
values (276, 'Moe', 'Tinsley', null, null);
commit;
prompt 494 records loaded
prompt Loading SCHTEACHER...
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (1, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (2, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (4, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (5, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (6, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (7, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (8, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (9, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (10, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (12, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (13, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (14, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (15, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (16, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (17, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (18, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (19, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (21, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (22, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (23, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (24, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (25, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (26, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (28, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (29, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (30, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (31, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (32, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (33, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (35, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (36, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (37, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (38, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (39, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (40, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (41, 38.5, 50);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (42, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (44, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (45, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (46, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (47, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (48, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (49, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (50, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (51, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (53, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (54, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (55, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (56, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (57, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (58, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (59, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (61, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (62, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (63, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (64, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (65, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (66, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (68, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (69, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (70, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (71, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (72, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (73, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (74, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (76, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (77, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (78, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (79, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (80, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (81, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (82, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (84, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (85, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (86, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (87, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (88, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (89, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (90, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (91, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (93, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (94, 38.5, 50);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (95, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (96, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (98, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (99, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (101, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (102, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (103, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (104, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (105, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (106, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (107, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (109, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (110, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (111, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (112, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (113, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (114, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (115, 35, 0);
commit;
prompt 100 records committed...
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (117, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (118, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (119, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (120, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (121, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (122, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (123, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (124, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (126, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (127, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (128, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (129, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (130, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (131, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (132, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (133, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (134, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (136, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (137, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (138, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (139, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (140, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (141, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (142, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (143, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (145, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (146, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (147, 38.5, 50);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (148, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (149, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (150, 38.5, 50);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (151, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (153, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (154, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (155, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (156, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (157, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (158, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (159, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (161, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (162, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (163, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (164, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (165, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (166, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (167, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (168, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (169, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (170, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (171, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (173, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (174, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (175, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (176, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (177, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (178, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (179, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (180, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (182, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (183, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (184, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (185, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (186, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (187, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (189, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (190, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (191, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (192, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (193, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (194, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (195, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (197, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (198, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (199, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (200, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (201, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (202, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (203, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (205, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (206, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (207, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (208, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (209, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (210, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (211, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (212, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (214, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (215, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (216, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (217, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (218, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (220, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (221, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (222, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (223, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (224, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (225, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (227, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (228, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (229, 35, 0);
commit;
prompt 200 records committed...
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (230, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (231, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (232, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (236, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (237, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (238, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (239, 38.5, 50);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (240, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (242, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (243, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (244, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (245, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (246, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (247, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (248, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (249, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (251, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (252, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (253, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (254, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (255, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (256, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (257, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (258, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (260, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (261, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (262, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (263, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (264, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (265, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (266, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (268, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (269, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (270, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (271, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (272, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (274, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (275, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (277, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (279, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (280, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (281, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (282, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (284, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (285, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (287, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (289, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (290, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (291, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (293, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (294, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (295, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (297, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (299, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (301, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (302, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (303, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (304, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (306, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (307, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (308, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (311, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (312, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (313, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (314, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (316, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (317, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (320, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (321, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (322, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (323, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (326, 38.5, 50);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (327, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (328, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (329, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (330, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (331, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (332, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (333, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (334, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (335, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (336, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (337, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (338, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (339, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (340, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (341, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (342, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (343, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (344, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (345, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (346, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (347, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (348, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (349, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (350, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (351, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (352, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (353, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (354, 35, 0);
commit;
prompt 300 records committed...
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (355, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (356, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (357, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (358, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (359, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (360, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (361, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (362, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (363, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (364, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (365, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (366, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (367, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (368, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (369, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (370, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (371, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (372, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (373, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (374, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (375, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (376, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (377, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (378, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (379, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (380, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (381, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (382, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (383, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (384, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (385, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (386, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (387, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (388, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (389, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (390, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (391, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (392, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (393, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (394, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (395, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (396, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (397, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (398, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (399, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (400, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (273, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (278, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (283, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (288, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (292, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (296, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (300, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (305, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (309, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (315, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (319, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (3, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (11, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (20, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (27, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (34, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (43, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (52, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (60, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (67, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (75, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (83, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (92, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (100, 38.5, 50);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (108, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (116, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (125, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (135, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (144, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (152, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (160, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (172, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (181, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (188, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (196, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (204, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (213, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (219, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (226, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (234, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (241, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (250, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (259, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (267, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (276, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (286, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (298, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (310, 35, 0);
insert into SCHTEACHER (teacher_id, hourly_salary, bonus)
values (318, 35, 0);
commit;
prompt 395 records loaded
prompt Loading CLASS_...
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (1, 2, 177, 238);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (2, 2, 207, 153);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (3, 1, 387, 137);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (4, 11, 315, 112);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (5, 11, 27, 224);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (6, 1, 272, 5);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (7, 12, 384, 106);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (8, 11, 353, 2);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (9, 2, 397, 157);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (10, 10, 103, 243);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (11, 12, 146, 85);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (12, 8, 63, 288);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (13, 9, 249, 228);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (14, 11, 269, 185);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (15, 1, 160, 263);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (16, 11, 181, 77);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (17, 12, 234, 316);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (18, 2, 5, 140);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (19, 8, 381, 3);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (20, 8, 364, 152);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (21, 1, 309, 104);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (22, 5, 365, 270);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (23, 5, 328, 259);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (24, 10, 242, 22);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (25, 5, 162, 302);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (26, 1, 212, 342);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (27, 7, 120, 64);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (28, 3, 89, 239);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (29, 12, 208, 58);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (30, 4, 144, 20);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (31, 10, 338, 347);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (32, 6, 290, 207);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (33, 2, 80, 26);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (34, 2, 383, 397);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (35, 4, 288, 60);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (36, 2, 39, 354);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (37, 5, 60, 310);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (38, 11, 302, 55);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (39, 10, 348, 341);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (40, 4, 237, 23);
commit;
prompt 40 records loaded
prompt Loading CLIENTS...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1, 'Andre', 'Burton', 1, 91284, 0, to_date('10-02-1965', 'dd-mm-yyyy'), 'Derek', 'Deborah', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (2, 'Glen', 'Meyer', 2, 69755, 0, to_date('23-02-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (3, 'Davis', 'Posener', 3, 16955, 0, to_date('11-01-1977', 'dd-mm-yyyy'), 'Lucas', 'Samantha', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (4, 'Fairuza', 'Gibbons', 4, 69060, 0, to_date('16-02-1980', 'dd-mm-yyyy'), 'Charles', 'Cheryl', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (5, 'Jackie', 'Vance', 5, 87283, 0, to_date('31-08-1942', 'dd-mm-yyyy'), 'Douglas', 'Brenda', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (6, 'Chad', 'Sawa', 6, 36592, 0, to_date('11-12-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (7, 'Natasha', 'Cassidy', 7, 61826, 0, to_date('30-09-1928', 'dd-mm-yyyy'), 'Henry', 'Jennifer', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (8, 'Kyra', 'Worrell', 8, 10109, 0, to_date('13-11-1989', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (9, 'Raul', 'Mazzello', 9, 23367, 151, to_date('27-02-1988', 'dd-mm-yyyy'), 'Joseph', 'Patricia', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (10, 'Wade', 'Clinton', 10, 88313, 521, to_date('24-05-1992', 'dd-mm-yyyy'), 'Adam', 'Lucia', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (11, 'Seann', 'Pleasure', 383, 23724, 0, to_date('18-03-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (13, 'Tzi', 'Dickinson', 178, 14932, 0, to_date('14-04-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (14, 'Dick', 'Andrews', 325, 78976, 0, to_date('02-08-1965', 'dd-mm-yyyy'), 'Travis', 'Pamela', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (15, 'Mae', 'Mohr', 295, 19379, 0, to_date('16-09-1935', 'dd-mm-yyyy'), 'Justin', 'Helena', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (16, 'Vin', 'Lipnicki', 146, 95435, 0, to_date('20-03-1940', 'dd-mm-yyyy'), 'Ethan', 'Mia', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (17, 'Dennis', 'Chambers', 371, 13246, 0, to_date('18-09-1945', 'dd-mm-yyyy'), 'Eric', 'Stephanie', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (18, 'Amanda', 'Galecki', 253, 73631, 0, to_date('17-04-1949', 'dd-mm-yyyy'), 'Diego', 'Phoebe', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (19, 'Nik', 'Peet', 26, 55925, 0, to_date('22-02-1978', 'dd-mm-yyyy'), 'Walter', 'Phoebe', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (20, 'Warren', 'Rodgers', 272, 97220, 0, to_date('19-06-1962', 'dd-mm-yyyy'), 'Ronald', 'Lisa', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (21, 'Jonny Lee', 'Peet', 296, 21980, 0, to_date('29-05-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (22, 'Allan', 'Heron', 32, 38091, 0, to_date('02-07-1988', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (23, 'Anjelica', 'Flatts', 372, 77805, 0, to_date('29-11-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (24, 'Jose', 'Fiennes', 39, 56454, 0, to_date('29-10-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (25, 'Kazem', 'Kudrow', 397, 53761, 0, to_date('01-10-1969', 'dd-mm-yyyy'), 'Paul', 'Brenda', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (26, 'Christian', 'Craig', 182, 92722, 0, to_date('01-11-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (27, 'Ray', 'O''Keefe', 379, 25072, 0, to_date('10-10-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (28, 'Mitchell', 'Phifer', 368, 90739, 0, to_date('20-09-2002', 'dd-mm-yyyy'), 'Richard', 'Agnes', 14);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (29, 'Kelly', 'Cheadle', 170, 27265, 0, to_date('02-05-1982', 'dd-mm-yyyy'), 'Austin', 'Abigail', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (31, 'Christine', 'Pacino', 377, 94427, 0, to_date('19-04-1985', 'dd-mm-yyyy'), 'Walter', 'Alicia', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (32, 'Trick', 'Bonham', 37, 92020, 0, to_date('28-01-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (33, 'Jeroen', 'Krieger', 155, 31070, 0, to_date('07-03-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (34, 'Andie', 'Bloch', 162, 36013, 0, to_date('21-12-1968', 'dd-mm-yyyy'), 'Derek', 'Helena', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (35, 'Charlie', 'Willis', 335, 60877, 0, to_date('20-05-1958', 'dd-mm-yyyy'), 'Zachary', 'Penelope', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (36, 'Mia', 'Grant', 292, 56531, 0, to_date('04-06-2005', 'dd-mm-yyyy'), 'Shannon', 'Alexandra', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (37, 'Emilio', 'Saucedo', 58, 98120, 0, to_date('13-01-1965', 'dd-mm-yyyy'), 'Gregory', 'Danielle', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (38, 'Phil', 'Shorter', 306, 31971, 0, to_date('03-11-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (39, 'Peabo', 'Waits', 347, 90018, 0, to_date('24-10-1928', 'dd-mm-yyyy'), 'Christopher', 'Maria', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (40, 'Gene', 'Cobbs', 183, 60360, 0, to_date('17-07-1984', 'dd-mm-yyyy'), 'Richard', 'Linda', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (41, 'Burt', 'Colon', 198, 30829, 0, to_date('27-09-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (43, 'Emma', 'Schwimmer', 32, 70950, 0, to_date('28-11-1924', 'dd-mm-yyyy'), 'Juan', 'Nancy', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (44, 'Cuba', 'Dean', 232, 60641, 0, to_date('04-09-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (45, 'William', 'Starr', 269, 86805, 0, to_date('09-08-1939', 'dd-mm-yyyy'), 'Sebastian', 'Monica', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (46, 'Paula', 'Moreno', 232, 91908, 0, to_date('31-07-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (47, 'Jeremy', 'Shatner', 74, 79810, 0, to_date('18-03-1934', 'dd-mm-yyyy'), 'Andrew', 'Lydia', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (48, 'Taye', 'Himmelman', 16, 62370, 0, to_date('20-04-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (49, 'Maury', 'Richards', 243, 95190, 0, to_date('06-12-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (50, 'Rutger', 'Gooding', 137, 37426, 0, to_date('06-05-1983', 'dd-mm-yyyy'), 'Dylan', 'Brittany', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (52, 'Nicholas', 'Devine', 85, 20844, 0, to_date('22-06-1929', 'dd-mm-yyyy'), 'Cole', 'Rachel', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (53, 'Thin', 'Suvari', 183, 63641, 0, to_date('12-07-1936', 'dd-mm-yyyy'), 'George', 'Audrey', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (54, 'Liev', 'Def', 382, 20224, 0, to_date('06-09-1989', 'dd-mm-yyyy'), 'Albert', 'Stephanie', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (55, 'Sonny', 'Schreiber', 131, 56626, 0, to_date('08-05-1932', 'dd-mm-yyyy'), 'Isaac', 'Danielle', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (56, 'Robert', 'Aykroyd', 195, 19734, 0, to_date('24-09-1994', 'dd-mm-yyyy'), 'Cody', 'Alexis', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (58, 'Noah', 'Witt', 65, 47156, 0, to_date('28-09-1929', 'dd-mm-yyyy'), 'Jayden', 'Sarah', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (59, 'Sophie', 'Rankin', 355, 52604, 0, to_date('25-07-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (62, 'Millie', 'Carradine', 260, 36093, 0, to_date('04-09-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (63, 'Nathan', 'Langella', 94, 64000, 0, to_date('18-07-1959', 'dd-mm-yyyy'), 'Ezekiel', 'Amanda', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (66, 'Geoffrey', 'Puckett', 364, 30551, 0, to_date('12-09-2002', 'dd-mm-yyyy'), 'Abraham', 'Jasmine', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (67, 'Max', 'Buffalo', 293, 17035, 0, to_date('14-08-1978', 'dd-mm-yyyy'), 'Adam', 'Charlotte', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (69, 'Fairuza', 'Malone', 166, 82076, 0, to_date('27-05-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (70, 'Johnny', 'Pride', 382, 59947, 0, to_date('14-09-1991', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (72, 'Sophie', 'Venora', 379, 19970, 0, to_date('08-08-2009', 'dd-mm-yyyy'), 'Antonio', 'Maya', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (73, 'Frank', 'Hauer', 97, 90421, 0, to_date('07-04-1939', 'dd-mm-yyyy'), 'Adam', 'Lucy', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (74, 'Crispin', 'Stamp', 318, 95472, 0, to_date('15-06-2007', 'dd-mm-yyyy'), 'Felipe', 'Claire', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (75, 'Sona', 'Cole', 243, 87687, 0, to_date('24-01-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (76, 'Ty', 'Foley', 218, 62302, 0, to_date('09-11-1963', 'dd-mm-yyyy'), 'John', 'Leslie', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (77, 'Curt', 'Scott', 391, 32722, 0, to_date('26-03-1991', 'dd-mm-yyyy'), 'Eric', 'Reagan', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (78, 'Tracy', 'Cantrell', 307, 11604, 0, to_date('26-04-1984', 'dd-mm-yyyy'), 'Thomas', 'Agnes', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (79, 'Kelli', 'Rispoli', 29, 46876, 0, to_date('17-04-1985', 'dd-mm-yyyy'), 'Samuel', 'Mia', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (81, 'Faye', 'Foster', 14, 93949, 0, to_date('11-02-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (82, 'Marlon', 'Rudd', 264, 93226, 0, to_date('03-08-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (83, 'Rosanne', 'Theron', 330, 68548, 0, to_date('10-10-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (84, 'Mandy', 'Puckett', 114, 13562, 0, to_date('15-06-1967', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (85, 'Harvey', 'Slater', 283, 25863, 0, to_date('23-10-1932', 'dd-mm-yyyy'), 'Albert', 'Alice', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (86, 'Chrissie', 'Willard', 258, 18391, 0, to_date('01-05-2002', 'dd-mm-yyyy'), 'Joshua', 'Jasmine', 9);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (87, 'Joey', 'Stevens', 204, 31138, 0, to_date('02-06-1983', 'dd-mm-yyyy'), 'Owen', 'Victoria', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (88, 'Joy', 'Orbit', 174, 69124, 0, to_date('24-05-1979', 'dd-mm-yyyy'), 'Edward', 'Diana', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (92, 'Corey', 'Cronin', 298, 70088, 0, to_date('30-08-1997', 'dd-mm-yyyy'), 'Cameron', 'Louise', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (93, 'Hex', 'Mattea', 367, 68976, 0, to_date('27-05-2001', 'dd-mm-yyyy'), 'Owen', 'Rose', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (95, 'Rolando', 'Gere', 347, 29725, 0, to_date('05-05-1973', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (96, 'Aaron', 'Stanton', 143, 84975, 0, to_date('31-10-1928', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (97, 'Hookah', 'Walken', 91, 44165, 0, to_date('20-10-1957', 'dd-mm-yyyy'), 'Ezekiel', 'Jacqueline', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (99, 'Jessica', 'Badalucco', 201, 43229, 0, to_date('23-05-2016', 'dd-mm-yyyy'), 'Gabriel', 'Samantha', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (100, 'Jeffrey', 'Idol', 241, 30651, 0, to_date('26-12-2018', 'dd-mm-yyyy'), 'Jonathan', 'Nancy', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (101, 'Deborah', 'Cazale', 392, 16345, 0, to_date('21-07-1935', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (103, 'Donald', 'Winstone', 36, 86612, 0, to_date('19-03-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (105, 'Ed', 'Redgrave', 206, 32704, 0, to_date('26-10-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (106, 'Randall', 'Epps', 120, 68888, 0, to_date('25-01-1989', 'dd-mm-yyyy'), 'Christopher', 'Sandra', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (108, 'Busta', 'Flanery', 95, 12624, 0, to_date('12-07-1947', 'dd-mm-yyyy'), 'Luke', 'Peyton', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (109, 'Horace', 'Crimson', 357, 92186, 0, to_date('02-06-1935', 'dd-mm-yyyy'), 'Jacob', 'Audrey', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (111, 'Sammy', 'Marshall', 3, 15237, 0, to_date('20-06-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (112, 'Vin', 'Uggams', 190, 12632, 0, to_date('09-04-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (113, 'Nicole', 'Creek', 60, 71837, 0, to_date('17-04-1957', 'dd-mm-yyyy'), 'Jacob', 'Jasmine', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (114, 'Tobey', 'Gore', 112, 14362, 0, to_date('15-07-1949', 'dd-mm-yyyy'), 'Brandon', 'Carla', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (119, 'Ceili', 'Coe', 361, 11624, 0, to_date('06-03-1999', 'dd-mm-yyyy'), 'Wesley', 'Nancy', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (120, 'Raul', 'Mitchell', 397, 49674, 0, to_date('27-09-1931', 'dd-mm-yyyy'), 'Dennis', 'Kelly', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (122, 'Gran', 'Mann', 33, 65288, 0, to_date('27-08-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (123, 'Tea', 'Sainte-Marie', 58, 46126, 0, to_date('13-11-1995', 'dd-mm-yyyy'), 'Andrew', 'Amanda', 9);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (124, 'Gord', 'Wilder', 114, 22064, 0, to_date('15-07-2003', 'dd-mm-yyyy'), 'Ryan', 'Bridget', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (125, 'Mia', 'Tucci', 292, 34558, 0, to_date('15-10-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (127, 'Clive', 'Jackson', 29, 97510, 0, to_date('02-05-1970', 'dd-mm-yyyy'), 'Jacob', 'Angela', 30);
commit;
prompt 100 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (128, 'Davis', 'Tarantino', 240, 53459, 0, to_date('11-07-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (129, 'Willie', 'Weiss', 372, 64517, 0, to_date('25-01-1950', 'dd-mm-yyyy'), 'Brian', 'Kristen', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (130, 'Chely', 'Caldwell', 256, 24280, 0, to_date('12-01-1928', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (133, 'Rowan', 'Garr', 326, 67303, 0, to_date('04-06-1997', 'dd-mm-yyyy'), 'Owen', 'Laura', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (134, 'Machine', 'Khan', 125, 90922, 0, to_date('11-09-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (135, 'Marc', 'Wolf', 154, 13473, 0, to_date('06-03-1955', 'dd-mm-yyyy'), 'Cole', 'Shirley', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (137, 'Hex', 'Fraser', 274, 26868, 0, to_date('13-02-1959', 'dd-mm-yyyy'), 'Jack', 'Leah', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (139, 'Emilio', 'Driver', 375, 59574, 0, to_date('30-11-1964', 'dd-mm-yyyy'), 'Javier', 'Amelia', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (142, 'Don', 'Stoltz', 326, 25861, 0, to_date('06-03-1938', 'dd-mm-yyyy'), 'Walter', 'Cheryl', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (145, 'Loreena', 'Badalucco', 57, 23668, 0, to_date('01-10-1999', 'dd-mm-yyyy'), 'Nathaniel', 'Ruby', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (147, 'Jonatha', 'Kleinenberg', 400, 50003, 0, to_date('17-07-1959', 'dd-mm-yyyy'), 'Scott', 'Phoebe', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (148, 'Percy', 'Malone', 365, 47724, 0, to_date('28-02-1961', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (149, 'Bonnie', 'Yankovic', 173, 84997, 0, to_date('07-05-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (150, 'Loreena', 'MacDowell', 48, 89901, 0, to_date('31-05-2015', 'dd-mm-yyyy'), 'Ryan', 'Natalie', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (152, 'Debbie', 'Lynn', 188, 98933, 0, to_date('11-12-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (153, 'Seann', 'Burmester', 208, 65866, 0, to_date('05-10-1957', 'dd-mm-yyyy'), 'Owen', 'Ashley', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (154, 'Janice', 'Crosby', 224, 69397, 0, to_date('14-01-1967', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (156, 'Mary', 'Melvin', 310, 68555, 0, to_date('14-11-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (157, 'Wayman', 'Matarazzo', 17, 20127, 0, to_date('26-10-1947', 'dd-mm-yyyy'), 'Edward', 'Rachel', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (158, 'Udo', 'Lachey', 217, 33583, 0, to_date('15-11-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (159, 'Naomi', 'Fogerty', 134, 35765, 0, to_date('29-05-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (160, 'Madeline', 'De Niro', 262, 66681, 0, to_date('28-08-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (163, 'Kenny', 'Nunn', 196, 43107, 0, to_date('30-06-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (165, 'Candice', 'Costner', 55, 63826, 0, to_date('12-03-1936', 'dd-mm-yyyy'), 'David', 'Kayla', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (167, 'Tcheky', 'Wills', 48, 93920, 0, to_date('03-03-1969', 'dd-mm-yyyy'), 'Cody', 'Monica', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (168, 'Ruth', 'Cagle', 384, 56434, 0, to_date('14-05-1941', 'dd-mm-yyyy'), 'Isaiah', 'Linda', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (169, 'Gin', 'Idle', 152, 84601, 0, to_date('16-02-2019', 'dd-mm-yyyy'), 'Paul', 'Angela', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (170, 'Maggie', 'Harrelson', 253, 89345, 0, to_date('08-02-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (172, 'Cyndi', 'Mandrell', 157, 28197, 0, to_date('11-12-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (174, 'Hope', 'Faithfull', 202, 43957, 0, to_date('31-12-1991', 'dd-mm-yyyy'), 'Nathan', 'Peyton', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (175, 'Merrilee', 'Kramer', 286, 86972, 0, to_date('25-05-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (176, 'Mel', 'Garza', 222, 46743, 0, to_date('30-08-1950', 'dd-mm-yyyy'), 'Trevor', 'Kayla', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (178, 'LeVar', 'Carnes', 187, 98460, 0, to_date('21-10-1956', 'dd-mm-yyyy'), 'Luke', 'Helena', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (179, 'Joshua', 'Cube', 326, 39283, 0, to_date('11-02-1979', 'dd-mm-yyyy'), 'Anthony', 'Susan', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (180, 'Joy', 'Himmelman', 5, 66140, 0, to_date('06-06-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (181, 'Greg', 'Eastwood', 138, 19664, 0, to_date('20-12-2005', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (183, 'Giovanni', 'Kingsley', 103, 54151, 0, to_date('04-05-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (184, 'Madeleine', 'Graham', 168, 16950, 0, to_date('09-06-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (185, 'Harrison', 'Black', 291, 31799, 0, to_date('09-12-1949', 'dd-mm-yyyy'), 'Isaiah', 'Abigail', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (186, 'Harrison', 'Beckham', 390, 67974, 0, to_date('18-01-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (188, 'Collin', 'Baldwin', 371, 79924, 0, to_date('19-08-2002', 'dd-mm-yyyy'), 'Tyler', 'Ava', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (189, 'Garland', 'Eat World', 207, 51436, 0, to_date('15-05-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (190, 'Bridget', 'Allan', 38, 62751, 0, to_date('19-03-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (191, 'Judge', 'Parsons', 157, 85396, 0, to_date('11-09-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (193, 'Cuba', 'Hamilton', 385, 73149, 0, to_date('11-07-1924', 'dd-mm-yyyy'), 'Xavier', 'Diana', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (195, 'CeCe', 'Choice', 296, 31731, 0, to_date('30-05-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (197, 'Glen', 'Yorn', 167, 37292, 0, to_date('22-04-2015', 'dd-mm-yyyy'), 'Antonio', 'Bridget', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (198, 'Carlos', 'Portman', 30, 73713, 0, to_date('12-01-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (199, 'Mae', 'Dunst', 336, 34486, 0, to_date('22-11-1994', 'dd-mm-yyyy'), 'Chad', 'Gabriella', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (200, 'Carlos', 'Hong', 98, 77129, 0, to_date('30-06-1978', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (202, 'Lucinda', 'Olin', 190, 54296, 0, to_date('29-08-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (203, 'Alessandro', 'Pleasence', 232, 44153, 0, to_date('13-08-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (204, 'Julio', 'Pfeiffer', 113, 14171, 0, to_date('06-08-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (205, 'Stephen', 'Rickman', 152, 84379, 0, to_date('16-07-1999', 'dd-mm-yyyy'), 'Scott', 'Courtney', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (206, 'Fisher', 'Vai', 110, 85888, 0, to_date('14-12-1927', 'dd-mm-yyyy'), 'Sebastian', 'Lisa', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (207, 'Jack', 'Brody', 384, 42164, 0, to_date('03-06-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (208, 'Eric', 'Loggia', 291, 22864, 0, to_date('16-06-1927', 'dd-mm-yyyy'), 'Trevor', 'Ruby', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (210, 'Denny', 'Benet', 270, 10582, 0, to_date('23-05-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (211, 'Bret', 'Oszajca', 289, 60058, 0, to_date('16-10-1947', 'dd-mm-yyyy'), 'Theodore', 'Linda', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (213, 'Mos', 'Kweller', 268, 90399, 0, to_date('27-06-1958', 'dd-mm-yyyy'), 'Nicholas', 'Vivian', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (214, 'Thomas', 'Farris', 131, 81761, 0, to_date('15-01-1983', 'dd-mm-yyyy'), 'Diego', 'Kayla', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (215, 'Roberta', 'Buffalo', 126, 69259, 0, to_date('21-02-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (216, 'Vendetta', 'Davison', 260, 76273, 0, to_date('24-11-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (217, 'Bebe', 'Roundtree', 397, 76024, 0, to_date('30-06-1927', 'dd-mm-yyyy'), 'Joshua', 'Sydney', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (218, 'Garth', 'Palminteri', 37, 42476, 0, to_date('01-01-1957', 'dd-mm-yyyy'), 'Wyatt', 'Lillian', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (220, 'Judge', 'Keen', 281, 39031, 0, to_date('07-01-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (221, 'Simon', 'Zane', 24, 86735, 0, to_date('22-07-1940', 'dd-mm-yyyy'), 'Joseph', 'Charlene', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (222, 'Todd', 'Sewell', 236, 99450, 0, to_date('28-05-1993', 'dd-mm-yyyy'), 'Trevor', 'Monica', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (223, 'Vondie', 'Mantegna', 91, 59812, 0, to_date('03-08-1951', 'dd-mm-yyyy'), 'Julian', 'Nicole', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (225, 'Earl', 'Beck', 268, 51058, 0, to_date('11-04-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (228, 'Jay', 'Oldman', 252, 69906, 0, to_date('01-12-1924', 'dd-mm-yyyy'), 'Cody', 'Hannah', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (230, 'Katie', 'Palin', 82, 80833, 0, to_date('07-01-1948', 'dd-mm-yyyy'), 'Ryan', 'Agnes', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (231, 'Jackie', 'Hewett', 137, 14206, 0, to_date('18-04-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (232, 'Marc', 'Jane', 272, 46343, 0, to_date('06-01-1966', 'dd-mm-yyyy'), 'Julian', 'Sandra', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (233, 'Morris', 'Slater', 40, 10036, 0, to_date('22-05-1995', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (235, 'Joe', 'Johansen', 275, 71128, 0, to_date('07-07-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (236, 'Victoria', 'Lindo', 299, 60251, 0, to_date('30-07-1961', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (237, 'Donald', 'Walken', 24, 23050, 0, to_date('02-06-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (238, 'Marlon', 'Yankovic', 66, 79672, 0, to_date('10-07-1940', 'dd-mm-yyyy'), 'Walter', 'Olivia', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (239, 'Angela', 'Maguire', 78, 62282, 0, to_date('03-02-1966', 'dd-mm-yyyy'), 'Austin', 'Lydia', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (240, 'Nancy', 'Ifans', 90, 50094, 0, to_date('22-05-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (241, 'Ashton', 'Jones', 1, 98467, 0, to_date('15-04-1984', 'dd-mm-yyyy'), 'Christopher', 'Meghan', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (242, 'Candice', 'McDonnell', 188, 96361, 0, to_date('11-03-1936', 'dd-mm-yyyy'), 'Dustin', 'Brittany', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (243, 'Kelly', 'Rudd', 95, 74798, 0, to_date('14-05-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (245, 'Clarence', 'Gambon', 301, 92330, 0, to_date('19-09-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (247, 'Daniel', 'Dalton', 310, 86473, 0, to_date('10-06-1988', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (248, 'Leo', 'Lynne', 85, 31952, 0, to_date('31-03-1991', 'dd-mm-yyyy'), 'Stephen', 'Lauren', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (249, 'Ozzy', 'Coughlan', 27, 86480, 0, to_date('07-01-1975', 'dd-mm-yyyy'), 'Julian', 'Courtney', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (250, 'Meg', 'Streep', 366, 86856, 0, to_date('22-06-1994', 'dd-mm-yyyy'), 'David', 'Linda', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (251, 'Rowan', 'Emmett', 53, 41184, 0, to_date('06-02-1974', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (252, 'Curtis', 'Gallant', 125, 41237, 0, to_date('28-06-1937', 'dd-mm-yyyy'), 'Daniel', 'Leslie', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (253, 'Benjamin', 'Wilson', 331, 16778, 0, to_date('05-10-2018', 'dd-mm-yyyy'), 'Kevin', 'Maria', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (255, 'Rita', 'Craig', 31, 64922, 0, to_date('22-09-1996', 'dd-mm-yyyy'), 'Dennis', 'Jade', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (256, 'Wayne', 'Beck', 257, 74003, 0, to_date('13-11-2020', 'dd-mm-yyyy'), 'Cody', 'Sheila', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (257, 'Mykelti', 'Neil', 203, 71949, 0, to_date('28-06-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (259, 'Garry', 'Holly', 84, 12456, 0, to_date('26-04-2008', 'dd-mm-yyyy'), 'Alan', 'Pamela', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (260, 'Lea', 'Lynch', 114, 68081, 0, to_date('07-04-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (261, 'Timothy', 'Tate', 391, 63061, 0, to_date('11-07-1926', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (262, 'Miki', 'Murphy', 23, 17459, 0, to_date('03-01-1942', 'dd-mm-yyyy'), 'Austin', 'Julia', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (263, 'Ewan', 'Danes', 270, 54611, 0, to_date('29-07-2001', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 200 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (264, 'Daryl', 'Quinlan', 379, 90374, 0, to_date('26-12-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (265, 'Meg', 'Bacon', 250, 13616, 0, to_date('26-10-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (266, 'Hal', 'Blackwell', 175, 37171, 0, to_date('18-01-1977', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (267, 'Andie', 'DiFranco', 68, 56187, 0, to_date('04-01-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (268, 'Teena', 'McGowan', 248, 93049, 0, to_date('21-06-1955', 'dd-mm-yyyy'), 'Thomas', 'Rose', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (269, 'Joey', 'Smurfit', 306, 80278, 0, to_date('06-11-1983', 'dd-mm-yyyy'), 'Wyatt', 'Penelope', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (271, 'Richie', 'Dench', 113, 84486, 0, to_date('02-03-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (272, 'Leelee', 'Niven', 19, 35356, 0, to_date('27-07-1939', 'dd-mm-yyyy'), 'Abraham', 'Kayla', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (274, 'Alessandro', 'Pierce', 320, 61625, 0, to_date('23-12-1999', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (276, 'Loren', 'Albright', 3, 11065, 0, to_date('21-05-1978', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (277, 'Debby', 'Peniston', 73, 23084, 0, to_date('18-09-2014', 'dd-mm-yyyy'), 'Joseph', 'Lillian', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (278, 'Rolando', 'Gryner', 35, 93113, 0, to_date('02-07-1957', 'dd-mm-yyyy'), 'Gabriel', 'Katherine', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (279, 'Carol', 'Randal', 123, 48578, 0, to_date('26-07-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (280, 'Treat', 'Woodard', 166, 21535, 0, to_date('30-08-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (282, 'Terry', 'Pesci', 282, 47571, 0, to_date('08-04-2000', 'dd-mm-yyyy'), 'John', 'Sarah', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (284, 'Elizabeth', 'Fox', 88, 24405, 0, to_date('03-10-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (285, 'Mary', 'Perlman', 91, 24816, 0, to_date('06-08-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (286, 'Ty', 'Tisdale', 130, 65013, 0, to_date('18-12-1990', 'dd-mm-yyyy'), 'Ethan', 'Caroline', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (287, 'Sigourney', 'Blaine', 170, 49134, 0, to_date('29-12-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (288, 'Juliette', 'Snipes', 55, 77909, 0, to_date('04-03-2016', 'dd-mm-yyyy'), 'Isaac', 'Courtney', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (289, 'Ronny', 'Tinsley', 115, 51886, 0, to_date('29-07-1935', 'dd-mm-yyyy'), 'Antonio', 'Charlotte', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (290, 'Famke', 'Tyson', 122, 77819, 0, to_date('03-04-1981', 'dd-mm-yyyy'), 'Cody', 'Karen', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (291, 'Philip', 'Kristofferson', 386, 64497, 0, to_date('25-05-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (292, 'Meryl', 'Tah', 69, 40822, 0, to_date('16-08-1994', 'dd-mm-yyyy'), 'Patrick', 'Michelle', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (293, 'Ann', 'Shandling', 179, 20617, 0, to_date('04-10-2018', 'dd-mm-yyyy'), 'Zachary', 'Ava', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (295, 'Jody', 'Reeves', 55, 19736, 0, to_date('09-03-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (296, 'Bette', 'Bentley', 390, 88020, 0, to_date('14-09-1945', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (297, 'Lou', 'Martinez', 272, 82524, 0, to_date('27-04-1996', 'dd-mm-yyyy'), 'Dustin', 'Louise', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (298, 'Heath', 'Finn', 29, 18004, 0, to_date('10-07-2011', 'dd-mm-yyyy'), 'Nathaniel', 'Rachel', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (299, 'Boyd', 'Van Helden', 94, 91177, 0, to_date('30-10-1925', 'dd-mm-yyyy'), 'Daniel', 'Alana', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (300, 'Tcheky', 'Ramirez', 396, 61676, 0, to_date('07-02-1970', 'dd-mm-yyyy'), 'Isaac', 'Charlotte', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (302, 'Etta', 'Lang', 286, 17369, 0, to_date('26-08-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (303, 'Daryl', 'Reinhold', 131, 68432, 0, to_date('31-08-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (304, 'Shannon', 'Arkenstone', 173, 88075, 0, to_date('14-05-1930', 'dd-mm-yyyy'), 'Sebastian', 'Bridget', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (305, 'Warren', 'Kravitz', 132, 65482, 0, to_date('16-05-1973', 'dd-mm-yyyy'), 'Dennis', 'Lydia', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (306, 'Wally', 'Newman', 345, 84704, 0, to_date('26-09-2012', 'dd-mm-yyyy'), 'Aaron', 'Reagan', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (307, 'Neve', 'Schreiber', 162, 48562, 0, to_date('16-08-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (308, 'Gin', 'Freeman', 28, 30054, 0, to_date('28-03-1926', 'dd-mm-yyyy'), 'Aaron', 'Martha', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (309, 'John', 'Richardson', 324, 82787, 0, to_date('15-10-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (310, 'Kay', 'Buscemi', 135, 55516, 0, to_date('01-06-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (311, 'Humberto', 'Springfield', 334, 10856, 0, to_date('01-02-1979', 'dd-mm-yyyy'), 'Philip', 'Allison', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (312, 'Susan', 'Keen', 326, 25071, 0, to_date('28-07-1951', 'dd-mm-yyyy'), 'Joshua', 'Hayley', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (315, 'Maggie', 'Collie', 50, 72250, 0, to_date('26-09-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (317, 'Jose', 'Swayze', 366, 46600, 0, to_date('09-12-2000', 'dd-mm-yyyy'), 'Philip', 'Penelope', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (318, 'Jake', 'McGriff', 258, 29912, 0, to_date('12-04-1968', 'dd-mm-yyyy'), 'Eric', 'Lily', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (320, 'Michelle', 'Fox', 115, 54922, 0, to_date('12-11-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (321, 'Eileen', 'Spector', 29, 19434, 0, to_date('09-03-2019', 'dd-mm-yyyy'), 'Adrian', 'Alexandra', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (322, 'Crystal', 'Pepper', 78, 57462, 0, to_date('17-12-1934', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (323, 'Howard', 'Schock', 335, 25119, 0, to_date('13-09-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (325, 'Max', 'Harper', 102, 35624, 0, to_date('26-07-1995', 'dd-mm-yyyy'), 'Ezekiel', 'Martha', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (326, 'Sander', 'Hannah', 33, 21303, 0, to_date('29-11-1955', 'dd-mm-yyyy'), 'Trevor', 'Brittany', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (327, 'Harriet', 'Frakes', 110, 66114, 0, to_date('27-10-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (329, 'Jimmie', 'Arkin', 56, 70949, 0, to_date('12-02-1984', 'dd-mm-yyyy'), 'Joan', 'Maya', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (331, 'Eddie', 'McGoohan', 135, 20443, 0, to_date('16-12-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (332, 'Ralph', 'Allison', 78, 27744, 0, to_date('25-07-2016', 'dd-mm-yyyy'), 'Jordan', 'Reagan', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (333, 'Vickie', 'Keith', 247, 90910, 0, to_date('25-07-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (334, 'Clint', 'McKennitt', 282, 19817, 0, to_date('27-05-1933', 'dd-mm-yyyy'), 'Travis', 'Sharon', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (338, 'Famke', 'Tilly', 40, 96430, 0, to_date('25-09-1953', 'dd-mm-yyyy'), 'Richard', 'Stephanie', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (340, 'Fiona', 'Phillippe', 348, 26026, 0, to_date('24-03-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (341, 'Remy', 'Walsh', 290, 44067, 0, to_date('01-07-1967', 'dd-mm-yyyy'), 'Cameron', 'Margaret', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (343, 'Caroline', 'Ammons', 214, 51091, 0, to_date('31-10-1939', 'dd-mm-yyyy'), 'Tyler', 'Faith', 14);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (345, 'Christine', 'Speaks', 161, 32130, 0, to_date('19-01-2001', 'dd-mm-yyyy'), 'Daniel', 'Kristen', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (346, 'Bonnie', 'Osbourne', 187, 26321, 0, to_date('16-05-1979', 'dd-mm-yyyy'), 'Jack', 'Hayley', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (348, 'Katie', 'Perez', 11, 67568, 0, to_date('05-10-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (349, 'Rolando', 'Linney', 320, 40384, 0, to_date('29-11-1958', 'dd-mm-yyyy'), 'Adrian', 'Lucy', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (350, 'Cate', 'Holeman', 27, 74413, 0, to_date('03-05-1972', 'dd-mm-yyyy'), 'Sebastian', 'Aisha', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (352, 'Faye', 'Parish', 84, 58213, 0, to_date('08-09-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (353, 'Stephen', 'Ribisi', 71, 25657, 0, to_date('21-03-1942', 'dd-mm-yyyy'), 'Jonathan', 'Evelyn', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (354, 'Rosanne', 'Campbell', 182, 67104, 0, to_date('15-02-1961', 'dd-mm-yyyy'), 'Abraham', 'Monica', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (357, 'Dave', 'Bush', 47, 71958, 0, to_date('19-08-1950', 'dd-mm-yyyy'), 'Xavier', 'Penelope', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (358, 'Ethan', 'Cummings', 185, 90804, 0, to_date('23-05-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (360, 'Julie', 'Douglas', 116, 21858, 0, to_date('06-11-1944', 'dd-mm-yyyy'), 'Antonio', 'Faith', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (361, 'Holland', 'Danger', 52, 35581, 0, to_date('31-08-2019', 'dd-mm-yyyy'), 'Jordan', 'Sandra', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (362, 'Beverley', 'Warwick', 129, 79488, 0, to_date('23-12-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (365, 'Meg', 'Choice', 232, 50819, 0, to_date('06-02-1976', 'dd-mm-yyyy'), 'Lucas', 'Maya', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (366, 'Lara', 'Keen', 191, 91188, 0, to_date('01-03-1966', 'dd-mm-yyyy'), 'Eric', 'Alice', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (367, 'Guy', 'Beck', 398, 52688, 0, to_date('18-03-1998', 'dd-mm-yyyy'), 'Roy', 'Claire', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (368, 'Thora', 'Stiles', 49, 46077, 0, to_date('04-07-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (370, 'Kim', 'Darren', 85, 50132, 0, to_date('22-06-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (371, 'Josh', 'Leary', 182, 20337, 0, to_date('02-04-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (372, 'Gavin', 'Lithgow', 123, 43719, 0, to_date('01-10-2002', 'dd-mm-yyyy'), 'Albert', 'Claire', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (375, 'Maury', 'Sweeney', 330, 89566, 0, to_date('15-11-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (376, 'Shelby', 'Hiatt', 269, 16697, 0, to_date('01-11-1983', 'dd-mm-yyyy'), 'Roy', 'Maya', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (377, 'Luke', 'Malkovich', 88, 46905, 0, to_date('10-05-2010', 'dd-mm-yyyy'), 'Derek', 'Jennifer', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (378, 'Jessica', 'Colon', 84, 29768, 0, to_date('24-07-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (379, 'Connie', 'Salt', 119, 55363, 0, to_date('09-03-1946', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (382, 'Gran', 'Peet', 104, 47784, 0, to_date('25-09-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (383, 'Dwight', 'Van Der Beek', 30, 57960, 0, to_date('18-03-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (384, 'Kirk', 'Holmes', 110, 73459, 0, to_date('16-08-1928', 'dd-mm-yyyy'), 'Cole', 'Linda', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (385, 'Raul', 'Capshaw', 66, 54119, 0, to_date('01-11-1940', 'dd-mm-yyyy'), 'Sebastian', 'Faith', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (386, 'Giovanni', 'Birch', 162, 71323, 0, to_date('19-05-1978', 'dd-mm-yyyy'), 'Brandon', 'Taylor', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (389, 'Lance', 'Scorsese', 2, 25997, 0, to_date('23-11-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (390, 'Gaby', 'Caine', 389, 94383, 0, to_date('10-01-1959', 'dd-mm-yyyy'), 'Philip', 'Sheila', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (393, 'Rosanna', 'Def', 11, 55609, 0, to_date('06-09-2005', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (394, 'Juliana', 'Wilkinson', 382, 78048, 0, to_date('05-02-1934', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (395, 'Milla', 'Klugh', 286, 41687, 0, to_date('21-04-1951', 'dd-mm-yyyy'), 'Austin', 'Jade', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (396, 'Lili', 'Krabbe', 282, 41147, 0, to_date('17-07-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (397, 'Trey', 'Klugh', 78, 52292, 0, to_date('30-08-1925', 'dd-mm-yyyy'), 'Adrian', 'Isabella', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (398, 'Edie', 'MacLachlan', 128, 92000, 0, to_date('27-08-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (400, 'Sigourney', 'Fichtner', 65, 12708, 0, to_date('31-10-1986', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 300 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (401, 'Frederic', 'Holbrook', 285, 13018, 0, to_date('24-02-1926', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (402, 'Joan', 'Matthau', 58, 11640, 0, to_date('16-09-1949', 'dd-mm-yyyy'), 'Ezekiel', 'Agnes', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (403, 'Garland', 'Cheadle', 203, 49469, 0, to_date('19-12-2020', 'dd-mm-yyyy'), 'Travis', 'Alexis', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (405, 'Jeanne', 'Meniketti', 23, 44364, 0, to_date('27-04-1984', 'dd-mm-yyyy'), 'Xavier', 'Sophia', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (406, 'Reese', 'Collins', 220, 30851, 0, to_date('30-01-1942', 'dd-mm-yyyy'), 'Theodore', 'Mia', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (408, 'Nicole', 'Warburton', 198, 77384, 0, to_date('15-04-1971', 'dd-mm-yyyy'), 'Christopher', 'Penelope', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (409, 'Natascha', 'Karyo', 141, 75108, 0, to_date('01-05-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (412, 'Nanci', 'Channing', 327, 31412, 0, to_date('09-09-1999', 'dd-mm-yyyy'), 'Joseph', 'Audrey', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (414, 'Marley', 'Allison', 55, 91791, 0, to_date('25-04-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (416, 'Murray', 'Donovan', 40, 18831, 0, to_date('04-12-2010', 'dd-mm-yyyy'), 'Jacob', 'Courtney', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (417, 'Emily', 'Pony', 340, 20884, 0, to_date('08-06-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (418, 'Cuba', 'Nicholson', 247, 57202, 0, to_date('06-08-1929', 'dd-mm-yyyy'), 'Antonio', 'Claudia', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (419, 'Jane', 'Everett', 131, 63174, 0, to_date('25-11-1980', 'dd-mm-yyyy'), 'Nathan', 'Meghan', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (420, 'Lisa', 'Rippy', 120, 54685, 0, to_date('26-04-1986', 'dd-mm-yyyy'), 'Jesse', 'Lisa', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (421, 'Marisa', 'Lillard', 56, 86618, 0, to_date('15-07-2000', 'dd-mm-yyyy'), 'Anthony', 'Jacqueline', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (422, 'Edward', 'Rhames', 337, 44431, 0, to_date('22-09-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (423, 'Veruca', 'Blair', 392, 75593, 0, to_date('01-09-2012', 'dd-mm-yyyy'), 'Anthony', 'Katherine', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (424, 'Cameron', 'Foley', 29, 48245, 0, to_date('12-11-1930', 'dd-mm-yyyy'), 'Theodore', 'Margaret', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (425, 'Irene', 'Hart', 182, 52723, 0, to_date('18-02-1966', 'dd-mm-yyyy'), 'Eric', 'Penelope', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (426, 'Russell', 'Waits', 274, 97928, 0, to_date('27-04-2017', 'dd-mm-yyyy'), 'Dustin', 'Diana', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (427, 'Heath', 'Cassidy', 60, 24856, 0, to_date('27-09-1994', 'dd-mm-yyyy'), 'Charles', 'Helena', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (431, 'Neil', 'Hutch', 33, 52315, 0, to_date('30-10-1925', 'dd-mm-yyyy'), 'Henry', 'Lori', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (432, 'Max', 'Rossellini', 95, 79490, 0, to_date('23-09-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (433, 'Ivan', 'Spine', 127, 59491, 0, to_date('05-11-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (434, 'Celia', 'Daniels', 37, 69285, 0, to_date('12-06-1987', 'dd-mm-yyyy'), 'Jesse', 'Hayley', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (435, 'Fairuza', 'Buffalo', 207, 49892, 0, to_date('03-08-1934', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (436, 'Gordie', 'Esposito', 379, 75712, 0, to_date('19-03-2006', 'dd-mm-yyyy'), 'Edward', 'Pamela', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (437, 'Rene', 'Cocker', 365, 11135, 0, to_date('19-10-1944', 'dd-mm-yyyy'), 'Paul', 'Cheryl', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (438, 'Tyrone', 'Stevenson', 179, 55813, 0, to_date('25-03-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (439, 'Lydia', 'Robinson', 49, 44867, 0, to_date('28-05-1977', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (440, 'Patrick', 'O''Neal', 93, 27220, 0, to_date('11-06-1958', 'dd-mm-yyyy'), 'Derek', 'Pamela', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (441, 'Pelvic', 'Andrews', 19, 49679, 0, to_date('25-01-2016', 'dd-mm-yyyy'), 'Gabriel', 'Rachel', 9);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (442, 'Praga', 'Kilmer', 283, 17080, 0, to_date('20-04-2010', 'dd-mm-yyyy'), 'Richard', 'Meghan', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (443, 'King', 'Stormare', 112, 95287, 0, to_date('19-04-1930', 'dd-mm-yyyy'), 'Albert', 'Joan', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (444, 'Hector', 'Tippe', 356, 44804, 0, to_date('19-04-1952', 'dd-mm-yyyy'), 'Samuel', 'Olivia', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (446, 'Miriam', 'Cube', 345, 10703, 0, to_date('08-03-2004', 'dd-mm-yyyy'), 'Oliver', 'Shirley', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (447, 'Rhett', 'Bullock', 62, 56002, 0, to_date('13-11-1977', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (448, 'Grace', 'Chestnut', 221, 15005, 0, to_date('26-01-1938', 'dd-mm-yyyy'), 'Gabriel', 'Angela', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (449, 'Alex', 'MacDonald', 118, 44519, 0, to_date('03-09-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (450, 'Anjelica', 'Dayne', 365, 34319, 0, to_date('01-12-1975', 'dd-mm-yyyy'), 'Oliver', 'Taylor', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (451, 'Walter', 'Summer', 35, 25324, 0, to_date('17-04-1941', 'dd-mm-yyyy'), 'Lucas', 'Kelly', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (452, 'Lindsey', 'Leachman', 288, 65057, 0, to_date('13-01-2010', 'dd-mm-yyyy'), 'Gabriel', 'Stephanie', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (453, 'Nik', 'Loring', 395, 15197, 0, to_date('30-12-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (454, 'Nigel', 'Aniston', 218, 65841, 0, to_date('25-08-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (455, 'Josh', 'Strathairn', 122, 32312, 0, to_date('05-06-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (456, 'Javon', 'Hingle', 248, 43455, 0, to_date('11-08-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (457, 'Azucar', 'Dukakis', 118, 61111, 0, to_date('28-03-1949', 'dd-mm-yyyy'), 'Adrian', 'Hannah', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (458, 'Maceo', 'Feliciano', 260, 19333, 0, to_date('01-11-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (462, 'Mary-Louise', 'Kahn', 250, 66515, 0, to_date('24-12-1933', 'dd-mm-yyyy'), 'Ezekiel', 'Tiffany', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (465, 'Adam', 'Hauser', 172, 95553, 0, to_date('07-05-1925', 'dd-mm-yyyy'), 'Austin', 'Isabella', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (466, 'Sissy', 'Mraz', 200, 63895, 0, to_date('09-12-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (468, 'Grace', 'de Lancie', 78, 21984, 0, to_date('14-03-2002', 'dd-mm-yyyy'), 'Luke', 'Dorothy', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (470, 'Carlene', 'Deejay', 356, 65520, 0, to_date('12-10-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (471, 'Wally', 'Herrmann', 91, 94760, 0, to_date('19-04-1995', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (472, 'Yolanda', 'Porter', 279, 48753, 0, to_date('23-12-2013', 'dd-mm-yyyy'), 'Leonardo', 'Kimberly', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (473, 'Famke', 'Tucker', 324, 16058, 0, to_date('28-11-2011', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (474, 'Mykelti', 'Cantrell', 292, 31354, 0, to_date('28-03-1954', 'dd-mm-yyyy'), 'Cody', 'Maya', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (475, 'Grant', 'Oates', 372, 70855, 0, to_date('27-08-1971', 'dd-mm-yyyy'), 'Isaiah', 'Joan', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (476, 'Gabrielle', 'Crouch', 114, 48826, 0, to_date('16-03-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (477, 'Reese', 'Wilder', 78, 48047, 0, to_date('10-04-1941', 'dd-mm-yyyy'), 'Tyler', 'Abigail', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (479, 'Cole', 'Twilley', 277, 91395, 0, to_date('25-07-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (481, 'Roy', 'Studi', 326, 86086, 0, to_date('14-06-2011', 'dd-mm-yyyy'), 'Travis', 'Amelia', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (482, 'Rob', 'Hobson', 144, 34756, 0, to_date('16-09-2011', 'dd-mm-yyyy'), 'Harold', 'Rachel', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (483, 'Amy', 'Byrd', 369, 57158, 0, to_date('04-10-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (484, 'Fionnula', 'Lachey', 109, 93413, 0, to_date('20-08-1988', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (485, 'Garry', 'Hector', 109, 45611, 0, to_date('14-12-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (486, 'Jonny Lee', 'Barkin', 325, 36006, 0, to_date('16-03-1994', 'dd-mm-yyyy'), 'Albert', 'Diana', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (487, 'Rita', 'Allan', 318, 20450, 0, to_date('19-06-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (488, 'Dan', 'Lillard', 305, 97574, 0, to_date('01-03-1968', 'dd-mm-yyyy'), 'Owen', 'Lucy', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (489, 'Vern', 'Palmieri', 267, 47464, 0, to_date('18-06-1930', 'dd-mm-yyyy'), 'Tyler', 'Mia', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (490, 'King', 'Perrineau', 94, 14967, 0, to_date('01-02-1956', 'dd-mm-yyyy'), 'Dennis', 'Hannah', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (491, 'Timothy', 'Fraser', 312, 58017, 0, to_date('14-01-2008', 'dd-mm-yyyy'), 'Isaac', 'Kelly', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (492, 'Toni', 'Duvall', 10, 41088, 0, to_date('25-08-1998', 'dd-mm-yyyy'), 'Abraham', 'Isabella', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (493, 'Burton', 'Murdock', 207, 23617, 0, to_date('05-04-1960', 'dd-mm-yyyy'), 'Sebastian', 'Jane', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (494, 'Faye', 'Jessee', 368, 53754, 0, to_date('05-07-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (495, 'Howie', 'Stiller', 188, 14579, 0, to_date('18-08-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (496, 'Pete', 'Loggins', 291, 73706, 0, to_date('08-12-1992', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (497, 'Leslie', 'Hector', 397, 93516, 0, to_date('09-09-2009', 'dd-mm-yyyy'), 'Dustin', 'Maya', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (498, 'Danny', 'Makowicz', 28, 38802, 0, to_date('08-09-1941', 'dd-mm-yyyy'), 'Travis', 'Louise', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (499, 'Lynette', 'Shepard', 289, 16990, 0, to_date('29-12-1936', 'dd-mm-yyyy'), 'Douglas', 'Jasmine', 14);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (500, 'Jeffrey', 'Mulroney', 72, 33921, 0, to_date('18-10-1976', 'dd-mm-yyyy'), 'Nathan', 'Fiona', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (501, 'Val', 'Sizemore', 188, 91058, 0, to_date('11-09-1983', 'dd-mm-yyyy'), 'Joseph', 'Ashley', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (502, 'Phil', 'Lindo', 91, 38615, 0, to_date('05-04-1940', 'dd-mm-yyyy'), 'Lawrence', 'Lauren', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (503, 'Whoopi', 'Wright', 46, 49026, 0, to_date('14-04-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (504, 'Rachid', 'Lightfoot', 376, 77032, 0, to_date('25-10-1939', 'dd-mm-yyyy'), 'Jesse', 'Mia', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (505, 'Cathy', 'Calle', 155, 42183, 0, to_date('11-06-1978', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (506, 'Sara', 'Richter', 212, 57149, 0, to_date('24-03-2006', 'dd-mm-yyyy'), 'Roy', 'Diana', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (507, 'Lenny', 'Chambers', 283, 26789, 0, to_date('06-12-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (508, 'Colin', 'Keitel', 84, 48838, 0, to_date('10-11-1934', 'dd-mm-yyyy'), 'Eric', 'Peyton', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (509, 'Embeth', 'Geldof', 168, 63104, 0, to_date('20-12-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1400, 'Ethan', 'Garcia', 7, 94999, 0, to_date('26-04-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1401, 'Ethan', 'Anderson', 1, 27387, 0, to_date('30-05-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1402, 'Michael', 'Miller', 2, 36293, 0, to_date('21-10-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1403, 'Alexander', 'Gonzalez', 6, 32432, 0, to_date('21-09-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1404, 'Elijah', 'Williams', 2, 34216, 0, to_date('14-04-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1405, 'William', 'Martinez', 5, 23234, 0, to_date('23-02-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1406, 'Amelia', 'Rodriguez', 2, 95451, 0, to_date('16-01-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1407, 'Lucas', 'Taylor', 7, 23986, 0, to_date('22-09-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1408, 'Ava', 'Gonzalez', 6, 95771, 0, to_date('23-09-1938', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1409, 'Alexander', 'Martin', 2, 57827, 0, to_date('30-10-2017', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 400 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1410, 'Elijah', 'Garcia', 4, 85379, 0, to_date('03-12-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1411, 'Evelyn', 'Taylor', 10, 70376, 0, to_date('16-04-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1412, 'Benjamin', 'Martinez', 2, 55099, 0, to_date('05-11-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1413, 'Amelia', 'Johnson', 3, 80868, 0, to_date('23-07-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1414, 'Alexander', 'Brown', 10, 64795, 0, to_date('02-04-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1415, 'James', 'Smith', 4, 39146, 0, to_date('06-02-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1416, 'Sophia', 'Hernandez', 1, 71947, 0, to_date('27-03-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1417, 'Lucas', 'Jones', 9, 89405, 0, to_date('23-01-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1418, 'Abigail', 'Martinez', 4, 63133, 0, to_date('30-12-1948', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1419, 'James', 'Wilson', 4, 53876, 0, to_date('16-06-1938', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1420, 'Ava', 'Jackson', 4, 67600, 0, to_date('06-05-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1421, 'Mia', 'Miller', 7, 52493, 0, to_date('05-06-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1422, 'Isabella', 'Hernandez', 10, 56587, 0, to_date('14-03-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1423, 'Mia', 'Wilson', 9, 23214, 0, to_date('06-05-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1424, 'Olivia', 'Martinez', 7, 81361, 0, to_date('11-04-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1425, 'Emma', 'Hernandez', 1, 94975, 0, to_date('12-12-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1426, 'John', 'Martinez', 9, 65292, 0, to_date('13-12-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1427, 'James', 'Taylor', 5, 69736, 0, to_date('15-04-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1428, 'John', 'Hernandez', 5, 29268, 0, to_date('01-02-1974', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1429, 'Lucas', 'Anderson', 10, 97274, 0, to_date('19-04-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1430, 'Alexander', 'Moore', 3, 70929, 0, to_date('07-09-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1431, 'Evelyn', 'Martinez', 6, 84553, 0, to_date('25-12-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1432, 'Michael', 'Lopez', 10, 28652, 0, to_date('27-12-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1433, 'James', 'Rodriguez', 4, 86463, 0, to_date('01-05-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1434, 'Evelyn', 'Miller', 3, 21243, 0, to_date('25-03-1976', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1435, 'Amelia', 'Rodriguez', 9, 38002, 0, to_date('07-06-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1436, 'Emma', 'Rodriguez', 9, 98077, 0, to_date('16-02-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1437, 'Benjamin', 'Lopez', 4, 82813, 0, to_date('15-03-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1438, 'Michael', 'Rodriguez', 7, 11934, 0, to_date('02-03-2007', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1439, 'Michael', 'Hernandez', 6, 78829, 0, to_date('08-08-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1440, 'Olivia', 'Anderson', 3, 73015, 0, to_date('21-09-1948', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1441, 'Lucas', 'Johnson', 8, 25215, 0, to_date('14-07-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1442, 'Mia', 'Brown', 4, 95279, 0, to_date('04-11-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1443, 'John', 'Martin', 9, 80911, 0, to_date('18-05-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1444, 'James', 'Hernandez', 2, 18108, 0, to_date('09-04-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1445, 'Ava', 'Smith', 6, 11588, 0, to_date('27-11-2012', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1446, 'Mason', 'Smith', 2, 96164, 0, to_date('06-10-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1447, 'Elijah', 'Anderson', 8, 28809, 0, to_date('16-11-1980', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1448, 'James', 'Jackson', 6, 92733, 0, to_date('30-07-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1449, 'Alexander', 'Gonzalez', 6, 51344, 0, to_date('04-01-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1450, 'Mason', 'Miller', 1, 47558, 0, to_date('18-04-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1451, 'Benjamin', 'Miller', 6, 20320, 0, to_date('25-11-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1452, 'William', 'Miller', 4, 42503, 0, to_date('01-11-2007', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1453, 'John', 'Garcia', 3, 77132, 0, to_date('11-04-2004', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1454, 'Sophia', 'Moore', 6, 80153, 0, to_date('06-01-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1455, 'Olivia', 'Wilson', 9, 53443, 0, to_date('17-10-1966', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1456, 'Elijah', 'Williams', 3, 65280, 0, to_date('17-04-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1457, 'Benjamin', 'Miller', 3, 73750, 0, to_date('09-11-1935', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1458, 'Isabella', 'Martin', 10, 21115, 0, to_date('08-08-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1459, 'Mason', 'Gonzalez', 6, 73899, 0, to_date('13-03-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1460, 'Ethan', 'Moore', 6, 92686, 0, to_date('01-10-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1461, 'Evelyn', 'Johnson', 4, 66192, 0, to_date('27-01-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1462, 'James', 'Smith', 4, 31297, 0, to_date('13-08-1979', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1463, 'Emma', 'Johnson', 3, 11827, 0, to_date('27-01-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1464, 'Olivia', 'Rodriguez', 7, 69571, 0, to_date('06-02-1988', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1465, 'Benjamin', 'Smith', 9, 86395, 0, to_date('17-11-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1466, 'William', 'Jones', 2, 14226, 0, to_date('08-08-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1467, 'John', 'Taylor', 8, 95831, 0, to_date('23-05-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1468, 'Ethan', 'Johnson', 9, 34183, 0, to_date('28-04-1953', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1469, 'Michael', 'Hernandez', 10, 15124, 0, to_date('23-02-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1470, 'Benjamin', 'Miller', 10, 49111, 0, to_date('21-08-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1471, 'Abigail', 'Taylor', 6, 27735, 0, to_date('24-01-1938', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1472, 'Olivia', 'Moore', 7, 93467, 0, to_date('14-10-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1473, 'Amelia', 'Davis', 4, 53548, 0, to_date('14-01-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1474, 'Evelyn', 'Davis', 3, 35492, 0, to_date('18-12-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1475, 'Elijah', 'Jones', 2, 91616, 0, to_date('26-10-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1476, 'Ava', 'Rodriguez', 3, 71285, 0, to_date('11-04-1999', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1477, 'Abigail', 'Johnson', 10, 89826, 0, to_date('18-04-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1478, 'Elijah', 'Brown', 10, 52759, 0, to_date('05-09-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1479, 'Michael', 'Rodriguez', 7, 14722, 0, to_date('21-12-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1480, 'James', 'Taylor', 1, 26266, 0, to_date('11-11-1946', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1481, 'Lucas', 'Jackson', 6, 85688, 0, to_date('30-05-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1482, 'Sophia', 'Miller', 1, 61271, 0, to_date('01-03-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1483, 'Olivia', 'Lopez', 9, 48553, 0, to_date('10-10-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1484, 'Mia', 'Davis', 1, 39795, 0, to_date('29-04-1991', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1485, 'Lucas', 'Miller', 4, 37327, 0, to_date('13-06-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1486, 'William', 'Garcia', 9, 56604, 0, to_date('27-07-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1487, 'Evelyn', 'Williams', 7, 28554, 0, to_date('15-06-2012', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1488, 'Elijah', 'Lopez', 8, 84532, 0, to_date('15-04-1938', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1489, 'Harper', 'Miller', 6, 33225, 0, to_date('13-12-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1490, 'Amelia', 'Martinez', 9, 38090, 0, to_date('15-05-1992', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1491, 'Lucas', 'Garcia', 1, 15059, 0, to_date('07-04-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1492, 'Abigail', 'Williams', 9, 13327, 0, to_date('15-12-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1493, 'Evelyn', 'Smith', 6, 85565, 0, to_date('28-03-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1494, 'Abigail', 'Johnson', 2, 58513, 0, to_date('11-11-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1495, 'Sophia', 'Brown', 6, 67038, 0, to_date('08-12-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1496, 'Evelyn', 'Williams', 10, 28735, 0, to_date('05-12-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1497, 'Mason', 'Williams', 5, 79728, 0, to_date('25-07-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1498, 'James', 'Hernandez', 5, 27593, 0, to_date('16-03-2012', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1499, 'Alexander', 'Jackson', 7, 94223, 0, to_date('08-04-1926', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1100, 'Elijah', 'Martinez', 6, 87441, 0, to_date('04-08-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1101, 'Isabella', 'Miller', 8, 89405, 0, to_date('19-01-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1102, 'Abigail', 'Wilson', 6, 33097, 0, to_date('26-07-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1103, 'John', 'Johnson', 7, 59002, 0, to_date('23-08-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1104, 'Lucas', 'Thomas', 3, 85122, 0, to_date('28-10-1944', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1105, 'Michael', 'Johnson', 5, 95150, 0, to_date('03-08-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1106, 'Isabella', 'Davis', 7, 64095, 0, to_date('13-05-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1107, 'Olivia', 'Jackson', 9, 68907, 0, to_date('25-01-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1108, 'Isabella', 'Thomas', 8, 90409, 0, to_date('25-06-2005', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1109, 'Mia', 'Thomas', 9, 42856, 0, to_date('14-07-1972', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 500 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1110, 'Mia', 'Jackson', 2, 55209, 0, to_date('02-04-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1111, 'Isabella', 'Brown', 1, 71705, 0, to_date('29-11-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1112, 'John', 'Smith', 3, 69505, 0, to_date('02-01-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1113, 'John', 'Williams', 9, 53260, 0, to_date('27-12-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1114, 'Lucas', 'Jones', 5, 35967, 0, to_date('07-07-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1115, 'William', 'Gonzalez', 8, 36759, 0, to_date('25-04-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1116, 'Isabella', 'Miller', 9, 98608, 0, to_date('25-11-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1117, 'Emma', 'Martinez', 5, 99909, 0, to_date('06-03-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1118, 'Evelyn', 'Taylor', 9, 45447, 0, to_date('03-10-1979', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1119, 'Evelyn', 'Taylor', 10, 56223, 0, to_date('08-10-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1120, 'Benjamin', 'Davis', 8, 38120, 0, to_date('25-08-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1121, 'Sophia', 'Smith', 4, 16532, 0, to_date('07-05-2013', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1122, 'Isabella', 'Rodriguez', 8, 45264, 0, to_date('29-07-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1123, 'Olivia', 'Taylor', 4, 61553, 0, to_date('01-11-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1124, 'Mia', 'Garcia', 1, 35033, 0, to_date('20-08-1925', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1125, 'Evelyn', 'Garcia', 9, 10004, 0, to_date('02-08-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1126, 'Sophia', 'Anderson', 4, 52594, 0, to_date('04-06-1965', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1127, 'Ethan', 'Moore', 8, 61999, 0, to_date('18-05-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1128, 'James', 'Johnson', 7, 91519, 0, to_date('29-04-1935', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1129, 'Elijah', 'Moore', 7, 29008, 0, to_date('16-07-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1130, 'Sophia', 'Smith', 6, 96294, 0, to_date('22-10-2005', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1131, 'Michael', 'Martin', 4, 71265, 0, to_date('29-12-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1132, 'Harper', 'Miller', 1, 73174, 0, to_date('02-01-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1133, 'James', 'Garcia', 3, 79068, 0, to_date('24-11-2013', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1134, 'Harper', 'Rodriguez', 9, 51933, 0, to_date('14-06-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1135, 'Amelia', 'Johnson', 10, 59274, 0, to_date('07-05-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1136, 'Elijah', 'Thomas', 7, 88682, 0, to_date('05-08-1943', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1137, 'Sophia', 'Williams', 9, 84674, 0, to_date('06-05-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1138, 'Abigail', 'Garcia', 10, 69508, 0, to_date('15-05-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1139, 'Elijah', 'Wilson', 2, 37653, 0, to_date('15-07-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1140, 'Ava', 'Anderson', 3, 55122, 0, to_date('25-09-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1141, 'Michael', 'Brown', 7, 24355, 0, to_date('20-03-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1142, 'Abigail', 'Johnson', 1, 53350, 0, to_date('21-08-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1143, 'Lucas', 'Wilson', 9, 23036, 0, to_date('14-10-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1144, 'Olivia', 'Moore', 1, 62597, 0, to_date('01-12-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1145, 'Benjamin', 'Hernandez', 4, 23498, 0, to_date('28-08-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1146, 'Olivia', 'Jones', 9, 68588, 0, to_date('04-04-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1147, 'Abigail', 'Taylor', 4, 28612, 0, to_date('27-03-1992', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1148, 'Emma', 'Wilson', 7, 30784, 0, to_date('26-11-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1149, 'Elijah', 'Lopez', 3, 73748, 0, to_date('20-02-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1150, 'Lucas', 'Rodriguez', 6, 38421, 0, to_date('03-03-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1151, 'John', 'Williams', 9, 11231, 0, to_date('09-01-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1152, 'Mason', 'Lopez', 9, 77319, 0, to_date('02-11-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1153, 'James', 'Johnson', 4, 23841, 0, to_date('26-12-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1154, 'Olivia', 'Miller', 6, 84865, 0, to_date('23-04-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1155, 'Evelyn', 'Taylor', 10, 40706, 0, to_date('24-07-2007', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1156, 'Michael', 'Thomas', 9, 39566, 0, to_date('24-03-1961', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1157, 'Mia', 'Martinez', 5, 12407, 0, to_date('03-09-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1158, 'Abigail', 'Lopez', 5, 34613, 0, to_date('21-04-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1159, 'Olivia', 'Gonzalez', 10, 72518, 0, to_date('23-10-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1160, 'Sophia', 'Anderson', 10, 74677, 0, to_date('01-04-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1161, 'Alexander', 'Williams', 1, 30795, 0, to_date('13-03-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1162, 'John', 'Rodriguez', 5, 59577, 0, to_date('07-11-1980', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1163, 'Benjamin', 'Williams', 1, 35753, 0, to_date('10-09-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1164, 'Abigail', 'Lopez', 2, 73591, 0, to_date('08-02-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1165, 'James', 'Jones', 4, 12376, 0, to_date('29-03-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1166, 'Harper', 'Johnson', 2, 53627, 0, to_date('27-07-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1167, 'Elijah', 'Johnson', 3, 31031, 0, to_date('05-08-2013', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1168, 'William', 'Miller', 6, 46297, 0, to_date('01-07-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1169, 'Harper', 'Brown', 6, 97419, 0, to_date('12-03-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1170, 'Elijah', 'Taylor', 10, 36943, 0, to_date('17-06-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1171, 'William', 'Miller', 4, 84793, 0, to_date('09-05-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1172, 'Benjamin', 'Wilson', 3, 91204, 0, to_date('27-08-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1173, 'Abigail', 'Miller', 6, 63002, 0, to_date('09-05-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1174, 'Ava', 'Anderson', 4, 96875, 0, to_date('03-01-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1175, 'Olivia', 'Jackson', 1, 96301, 0, to_date('26-06-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1176, 'Alexander', 'Brown', 3, 94111, 0, to_date('25-10-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1177, 'Harper', 'Johnson', 7, 52619, 0, to_date('30-01-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1178, 'Mason', 'Jackson', 4, 41559, 0, to_date('17-10-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1179, 'Amelia', 'Jones', 3, 48919, 0, to_date('29-10-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1180, 'Mason', 'Jackson', 4, 40120, 0, to_date('03-03-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1181, 'Lucas', 'Miller', 3, 26973, 0, to_date('03-04-2017', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1182, 'Abigail', 'Brown', 2, 33035, 0, to_date('13-05-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1183, 'Harper', 'Johnson', 6, 50628, 0, to_date('28-06-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1184, 'Mia', 'Davis', 9, 91456, 0, to_date('02-04-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1185, 'Olivia', 'Moore', 9, 66501, 0, to_date('28-12-1945', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1186, 'Mia', 'Taylor', 3, 46731, 0, to_date('27-03-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1187, 'Ava', 'Miller', 6, 79308, 0, to_date('11-04-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1188, 'Sophia', 'Lopez', 9, 37531, 0, to_date('27-04-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1189, 'Ethan', 'Thomas', 3, 52102, 0, to_date('08-09-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1190, 'James', 'Wilson', 1, 13382, 0, to_date('24-08-1973', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1191, 'Abigail', 'Wilson', 3, 11042, 0, to_date('23-10-1946', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1192, 'Sophia', 'Martin', 8, 81083, 0, to_date('01-08-1944', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1193, 'Michael', 'Martin', 9, 31520, 0, to_date('11-10-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1194, 'John', 'Johnson', 2, 30803, 0, to_date('29-10-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1195, 'Ava', 'Garcia', 2, 83217, 0, to_date('16-11-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1196, 'John', 'Jones', 5, 23009, 0, to_date('20-02-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1197, 'Sophia', 'Hernandez', 2, 88887, 0, to_date('15-04-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1198, 'Sophia', 'Miller', 1, 24757, 0, to_date('20-11-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1199, 'Emma', 'Jackson', 4, 13978, 0, to_date('20-05-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1200, 'Evelyn', 'Moore', 1, 54934, 0, to_date('12-01-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1201, 'John', 'Miller', 2, 24686, 0, to_date('28-09-1944', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1202, 'Emma', 'Smith', 5, 71666, 0, to_date('08-11-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1203, 'Mia', 'Lopez', 4, 60010, 0, to_date('15-09-1980', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1204, 'Michael', 'Davis', 3, 82083, 0, to_date('17-11-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1205, 'Benjamin', 'Rodriguez', 8, 37745, 0, to_date('30-10-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1206, 'Evelyn', 'Miller', 3, 50003, 0, to_date('14-07-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1207, 'Ethan', 'Williams', 10, 46360, 0, to_date('07-01-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1208, 'Elijah', 'Martinez', 4, 65952, 0, to_date('07-12-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1209, 'Lucas', 'Hernandez', 10, 79204, 0, to_date('07-08-2001', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 600 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1210, 'Sophia', 'Martin', 3, 26509, 0, to_date('04-03-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1211, 'James', 'Jones', 6, 62471, 0, to_date('20-11-1977', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1212, 'John', 'Jackson', 3, 74617, 0, to_date('25-03-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1213, 'Elijah', 'Smith', 4, 96682, 0, to_date('26-10-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1214, 'Evelyn', 'Rodriguez', 2, 96006, 0, to_date('13-12-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1215, 'Emma', 'Garcia', 10, 94833, 0, to_date('17-09-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1216, 'Lucas', 'Anderson', 9, 86835, 0, to_date('13-09-1976', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1217, 'Ethan', 'Taylor', 5, 73923, 0, to_date('09-12-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1218, 'Harper', 'Martin', 3, 95295, 0, to_date('28-09-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1219, 'Sophia', 'Taylor', 9, 52528, 0, to_date('04-07-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1220, 'Sophia', 'Brown', 8, 57352, 0, to_date('14-10-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1221, 'Evelyn', 'Davis', 1, 62718, 0, to_date('20-12-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1222, 'John', 'Davis', 9, 96856, 0, to_date('06-03-1989', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1223, 'Alexander', 'Smith', 9, 39859, 0, to_date('20-08-1925', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1224, 'Harper', 'Brown', 5, 47275, 0, to_date('14-06-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1225, 'Michael', 'Gonzalez', 7, 38371, 0, to_date('02-08-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1226, 'James', 'Miller', 6, 57436, 0, to_date('15-05-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1227, 'Amelia', 'Anderson', 10, 55542, 0, to_date('18-08-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1228, 'William', 'Jones', 2, 31772, 0, to_date('07-01-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1229, 'Michael', 'Jones', 2, 25585, 0, to_date('12-02-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1230, 'Elijah', 'Wilson', 6, 51375, 0, to_date('15-07-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1231, 'Olivia', 'Rodriguez', 10, 37954, 0, to_date('20-08-1991', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1232, 'Abigail', 'Smith', 8, 14853, 0, to_date('01-04-1946', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1233, 'Abigail', 'Rodriguez', 9, 48225, 0, to_date('27-05-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1234, 'James', 'Jackson', 9, 36642, 0, to_date('03-04-1953', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1235, 'Sophia', 'Jackson', 9, 21911, 0, to_date('19-06-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1236, 'Amelia', 'Davis', 5, 22720, 0, to_date('26-02-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1237, 'Mason', 'Brown', 1, 98590, 0, to_date('17-11-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1238, 'Mia', 'Davis', 6, 84926, 0, to_date('20-09-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1239, 'Olivia', 'Garcia', 6, 97369, 0, to_date('01-08-1946', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1240, 'Lucas', 'Brown', 8, 37392, 0, to_date('13-01-2004', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1241, 'Benjamin', 'Miller', 8, 53373, 0, to_date('17-11-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1242, 'Alexander', 'Johnson', 3, 26879, 0, to_date('10-11-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1243, 'Ethan', 'Johnson', 1, 92006, 0, to_date('26-06-1953', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1244, 'Abigail', 'Anderson', 5, 14793, 0, to_date('24-06-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1245, 'Harper', 'Jackson', 5, 90248, 0, to_date('06-07-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1246, 'Sophia', 'Miller', 6, 93673, 0, to_date('20-07-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1247, 'Sophia', 'Moore', 6, 55087, 0, to_date('26-06-2011', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1248, 'Olivia', 'Garcia', 1, 98938, 0, to_date('08-10-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1249, 'Sophia', 'Lopez', 4, 76779, 0, to_date('18-10-1991', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1250, 'Emma', 'Wilson', 10, 61530, 0, to_date('10-09-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1251, 'Abigail', 'Rodriguez', 4, 78836, 0, to_date('25-10-1977', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1252, 'William', 'Brown', 6, 17186, 0, to_date('24-08-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1253, 'Evelyn', 'Taylor', 10, 63293, 0, to_date('25-03-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1254, 'William', 'Johnson', 8, 53395, 0, to_date('15-12-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1255, 'Amelia', 'Taylor', 1, 50654, 0, to_date('22-04-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1256, 'Sophia', 'Jones', 4, 54758, 0, to_date('28-03-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1257, 'Ava', 'Brown', 2, 66619, 0, to_date('04-04-1979', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1258, 'Benjamin', 'Williams', 4, 94986, 0, to_date('02-03-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1259, 'Harper', 'Brown', 3, 75919, 0, to_date('07-10-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1260, 'Lucas', 'Taylor', 7, 57172, 0, to_date('27-03-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1261, 'Elijah', 'Brown', 10, 69687, 0, to_date('25-05-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1262, 'Lucas', 'Brown', 10, 32184, 0, to_date('24-03-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1263, 'Abigail', 'Brown', 2, 68188, 0, to_date('12-10-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1264, 'James', 'Taylor', 10, 65947, 0, to_date('22-09-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1265, 'Evelyn', 'Miller', 5, 74204, 0, to_date('05-12-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1266, 'Michael', 'Moore', 4, 68776, 0, to_date('18-08-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1267, 'Lucas', 'Taylor', 4, 36601, 0, to_date('28-09-2011', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1268, 'Mia', 'Jackson', 2, 82605, 0, to_date('26-03-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1269, 'Harper', 'Jackson', 10, 85607, 0, to_date('10-08-1999', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1270, 'Ava', 'Thomas', 7, 35084, 0, to_date('14-11-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1271, 'Elijah', 'Hernandez', 10, 10465, 0, to_date('10-02-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1272, 'Elijah', 'Martinez', 1, 72278, 0, to_date('25-01-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1273, 'William', 'Martin', 2, 99439, 0, to_date('11-11-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1274, 'Ava', 'Garcia', 5, 50005, 0, to_date('29-12-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1275, 'Olivia', 'Martin', 1, 95166, 0, to_date('19-03-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1276, 'Harper', 'Anderson', 6, 77230, 0, to_date('18-10-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1277, 'Mason', 'Taylor', 6, 76588, 0, to_date('21-02-1973', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1278, 'Sophia', 'Smith', 2, 70846, 0, to_date('22-01-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1279, 'Benjamin', 'Williams', 2, 36301, 0, to_date('04-11-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1280, 'Mia', 'Miller', 2, 66815, 0, to_date('19-06-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1281, 'Benjamin', 'Brown', 2, 26036, 0, to_date('17-05-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1282, 'Elijah', 'Taylor', 4, 30009, 0, to_date('07-01-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1283, 'Elijah', 'Smith', 8, 18877, 0, to_date('16-09-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1284, 'Abigail', 'Davis', 6, 76894, 0, to_date('07-09-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1285, 'Isabella', 'Wilson', 5, 50148, 0, to_date('01-05-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1286, 'Mia', 'Martin', 9, 78098, 0, to_date('10-01-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1287, 'Sophia', 'Hernandez', 9, 29770, 0, to_date('11-09-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1288, 'Amelia', 'Smith', 4, 41292, 0, to_date('14-02-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1289, 'Mason', 'Garcia', 2, 95022, 0, to_date('04-05-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1290, 'Amelia', 'Martin', 3, 61660, 0, to_date('05-11-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1291, 'Alexander', 'Williams', 1, 93316, 0, to_date('27-09-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1292, 'Elijah', 'Martin', 10, 58261, 0, to_date('17-12-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1293, 'Lucas', 'Anderson', 9, 42008, 0, to_date('10-01-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1294, 'Harper', 'Rodriguez', 5, 22004, 0, to_date('12-02-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1295, 'Harper', 'Thomas', 9, 43666, 0, to_date('29-03-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1296, 'Harper', 'Davis', 1, 68978, 0, to_date('26-07-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1297, 'James', 'Johnson', 4, 82060, 0, to_date('15-04-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1298, 'Sophia', 'Wilson', 2, 41832, 0, to_date('17-04-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1299, 'Mason', 'Williams', 2, 15040, 0, to_date('05-03-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1300, 'Alexander', 'Thomas', 5, 29233, 0, to_date('27-04-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1301, 'William', 'Martinez', 1, 59849, 0, to_date('31-10-1966', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1302, 'Elijah', 'Jones', 8, 86425, 0, to_date('19-02-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1303, 'Abigail', 'Jones', 9, 79038, 0, to_date('22-04-1945', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1304, 'Ava', 'Anderson', 9, 47972, 0, to_date('21-01-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1305, 'Emma', 'Wilson', 6, 66740, 0, to_date('13-10-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1306, 'Lucas', 'Davis', 1, 28770, 0, to_date('25-03-1974', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1307, 'Mason', 'Davis', 1, 45726, 0, to_date('03-01-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1308, 'Mason', 'Gonzalez', 3, 89063, 0, to_date('01-02-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1309, 'William', 'Williams', 10, 75604, 0, to_date('15-08-1929', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 700 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1310, 'Harper', 'Wilson', 4, 22510, 0, to_date('09-03-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1311, 'Emma', 'Williams', 4, 92702, 0, to_date('28-07-1976', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1312, 'Emma', 'Davis', 5, 15889, 0, to_date('26-01-2004', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1313, 'Alexander', 'Anderson', 1, 85136, 0, to_date('23-01-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1314, 'James', 'Martin', 7, 38009, 0, to_date('10-01-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1315, 'Michael', 'Martin', 9, 34992, 0, to_date('09-08-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1316, 'James', 'Wilson', 9, 98054, 0, to_date('06-03-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1317, 'Lucas', 'Smith', 10, 73854, 0, to_date('07-01-1943', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1318, 'Benjamin', 'Miller', 2, 13261, 0, to_date('11-06-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1319, 'Isabella', 'Wilson', 8, 35212, 0, to_date('22-08-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1320, 'William', 'Martin', 9, 64196, 0, to_date('13-04-2011', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1321, 'Emma', 'Lopez', 3, 93219, 0, to_date('10-06-1995', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1322, 'Elijah', 'Brown', 10, 37492, 0, to_date('18-10-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1323, 'Sophia', 'Lopez', 1, 43937, 0, to_date('09-04-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1324, 'Ava', 'Brown', 9, 45647, 0, to_date('21-08-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1325, 'Harper', 'Smith', 3, 94043, 0, to_date('20-02-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1326, 'Lucas', 'Miller', 7, 82100, 0, to_date('29-08-2017', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1327, 'Isabella', 'Brown', 9, 85836, 0, to_date('23-11-1953', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1328, 'Evelyn', 'Smith', 3, 93644, 0, to_date('23-08-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1329, 'Ethan', 'Miller', 5, 26625, 0, to_date('01-11-1973', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1330, 'Evelyn', 'Miller', 5, 73435, 0, to_date('05-06-1965', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1331, 'Olivia', 'Taylor', 10, 93596, 0, to_date('10-03-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1332, 'Harper', 'Smith', 1, 43873, 0, to_date('16-05-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1333, 'John', 'Johnson', 5, 60085, 0, to_date('15-06-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1334, 'Mia', 'Rodriguez', 9, 66446, 0, to_date('16-08-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1335, 'Alexander', 'Brown', 9, 88740, 0, to_date('09-04-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1336, 'Ethan', 'Lopez', 3, 48657, 0, to_date('08-07-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1337, 'Harper', 'Taylor', 6, 31453, 0, to_date('19-11-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1338, 'Isabella', 'Brown', 4, 20696, 0, to_date('21-02-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1339, 'Evelyn', 'Miller', 1, 69219, 0, to_date('02-05-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1340, 'Evelyn', 'Anderson', 1, 77209, 0, to_date('25-02-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1341, 'Emma', 'Miller', 6, 25576, 0, to_date('17-04-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1342, 'Mason', 'Gonzalez', 5, 24107, 0, to_date('08-11-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1343, 'Amelia', 'Smith', 9, 62135, 0, to_date('22-02-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1344, 'Amelia', 'Smith', 7, 96660, 0, to_date('27-09-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1345, 'Lucas', 'Jackson', 5, 63139, 0, to_date('05-08-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1346, 'Elijah', 'Miller', 4, 16770, 0, to_date('28-05-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1347, 'Evelyn', 'Anderson', 2, 39086, 0, to_date('31-07-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1348, 'John', 'Williams', 5, 71043, 0, to_date('11-07-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1349, 'Isabella', 'Martin', 8, 25234, 0, to_date('24-05-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1350, 'William', 'Miller', 7, 63983, 0, to_date('28-03-1926', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1351, 'Harper', 'Martinez', 10, 51375, 0, to_date('25-07-1943', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1352, 'Ava', 'Brown', 6, 28269, 0, to_date('15-08-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1353, 'Evelyn', 'Miller', 6, 75246, 0, to_date('26-12-1967', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1354, 'Isabella', 'Moore', 3, 74469, 351, to_date('13-12-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1355, 'Sophia', 'Williams', 5, 72814, 0, to_date('12-12-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1356, 'Alexander', 'Jackson', 4, 94311, 0, to_date('11-04-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1357, 'Alexander', 'Williams', 1, 46848, 0, to_date('11-02-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1358, 'Ethan', 'Johnson', 6, 40678, 0, to_date('01-10-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1359, 'John', 'Martin', 1, 42726, 0, to_date('28-01-1961', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1360, 'Alexander', 'Williams', 10, 90478, 0, to_date('05-03-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1361, 'Isabella', 'Martin', 4, 94820, 0, to_date('22-03-1944', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1362, 'Ethan', 'Davis', 8, 92556, 0, to_date('27-09-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1363, 'William', 'Gonzalez', 2, 39369, 0, to_date('18-06-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1364, 'James', 'Wilson', 5, 73890, 0, to_date('04-12-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1365, 'Sophia', 'Wilson', 10, 68676, 0, to_date('17-03-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1366, 'Olivia', 'Rodriguez', 3, 22327, 0, to_date('29-12-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1367, 'Ethan', 'Williams', 5, 81660, 0, to_date('24-03-2007', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1368, 'Olivia', 'Martin', 7, 58602, 0, to_date('02-02-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1369, 'Benjamin', 'Brown', 1, 91136, 0, to_date('03-02-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1370, 'Sophia', 'Martin', 2, 23834, 0, to_date('22-01-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1371, 'James', 'Brown', 1, 59950, 0, to_date('26-05-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1372, 'Abigail', 'Miller', 9, 36903, 0, to_date('06-10-1992', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1373, 'John', 'Anderson', 7, 20548, 0, to_date('08-12-1925', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1374, 'Ethan', 'Jones', 9, 99160, 0, to_date('04-08-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1375, 'James', 'Martinez', 9, 86491, 0, to_date('24-01-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1376, 'John', 'Williams', 7, 64396, 0, to_date('18-06-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1377, 'Ava', 'Miller', 4, 54015, 0, to_date('18-06-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1378, 'Olivia', 'Martin', 1, 88601, 0, to_date('24-02-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1379, 'Lucas', 'Smith', 7, 94383, 0, to_date('15-01-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1380, 'Ethan', 'Anderson', 6, 92925, 0, to_date('08-02-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1381, 'Ava', 'Gonzalez', 2, 81899, 0, to_date('12-09-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1382, 'Abigail', 'Gonzalez', 8, 82384, 0, to_date('08-09-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1383, 'William', 'Brown', 10, 31880, 0, to_date('20-12-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1384, 'Evelyn', 'Moore', 6, 91318, 0, to_date('21-04-1980', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1385, 'Evelyn', 'Wilson', 3, 33125, 0, to_date('13-05-1945', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1386, 'Alexander', 'Wilson', 5, 23562, 0, to_date('05-12-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1387, 'Mia', 'Gonzalez', 8, 47339, 0, to_date('16-05-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1388, 'Harper', 'Garcia', 7, 95196, 0, to_date('28-12-1928', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1389, 'Harper', 'Miller', 10, 15001, 0, to_date('10-08-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1390, 'Michael', 'Johnson', 1, 28054, 0, to_date('26-09-2012', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1391, 'John', 'Smith', 5, 69997, 0, to_date('21-11-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1392, 'Evelyn', 'Anderson', 3, 28356, 0, to_date('02-05-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1393, 'John', 'Taylor', 7, 25186, 0, to_date('16-01-1974', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1394, 'Emma', 'Rodriguez', 9, 80336, 0, to_date('23-08-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1395, 'Alexander', 'Jones', 2, 21907, 0, to_date('10-07-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1396, 'Ethan', 'Thomas', 10, 68355, 0, to_date('19-11-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1397, 'James', 'Anderson', 5, 35742, 0, to_date('02-05-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1398, 'Mason', 'Thomas', 10, 35503, 0, to_date('26-02-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (1399, 'Benjamin', 'Wilson', 10, 98272, 0, to_date('20-12-1953', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (91, 'Jarvis', 'Weiss', 71, 70257, 0, to_date('21-02-1994', 'dd-mm-yyyy'), 'Dennis', 'Caroline', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (94, 'Solomon', 'Dunn', 344, 83271, 0, to_date('29-07-1934', 'dd-mm-yyyy'), 'Walter', 'Jade', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (98, 'Whoopi', 'Callow', 86, 68447, 0, to_date('03-11-1983', 'dd-mm-yyyy'), 'Cameron', 'Charlotte', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (104, 'Junior', 'Ruiz', 147, 97903, 0, to_date('08-05-2001', 'dd-mm-yyyy'), 'Jesse', 'Madison', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (107, 'Kathleen', 'Cale', 97, 30780, 0, to_date('27-11-1956', 'dd-mm-yyyy'), 'Zachary', 'Alana', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (110, 'Joy', 'Postlethwaite', 167, 36082, 0, to_date('11-04-1984', 'dd-mm-yyyy'), 'Douglas', 'Sarah', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (117, 'Vivica', 'DiBiasio', 333, 63773, 0, to_date('24-01-2014', 'dd-mm-yyyy'), 'Julian', 'Madison', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (121, 'Walter', 'Crewson', 347, 42785, 0, to_date('15-08-1987', 'dd-mm-yyyy'), 'Sean', 'Penelope', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (126, 'Johnette', 'Coward', 207, 95179, 0, to_date('10-01-2016', 'dd-mm-yyyy'), 'Caleb', 'Michelle', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (131, 'Hilary', 'Salt', 116, 23179, 0, to_date('17-08-1945', 'dd-mm-yyyy'), 'Wyatt', 'Alicia', 17);
commit;
prompt 800 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (136, 'Brent', 'Donovan', 157, 60458, 0, to_date('02-11-1967', 'dd-mm-yyyy'), 'Sebastian', 'Luna', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (140, 'Alana', 'Ruffalo', 196, 18219, 0, to_date('12-04-1969', 'dd-mm-yyyy'), 'Eric', 'Charlotte', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (146, 'Leslie', 'Belles', 60, 46663, 0, to_date('10-12-2009', 'dd-mm-yyyy'), 'Lawrence', 'Tiffany', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (151, 'Juice', 'Neil', 71, 30867, 0, to_date('17-12-1989', 'dd-mm-yyyy'), 'Joseph', 'Catherine', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (164, 'Graham', 'Lineback', 68, 65813, 0, to_date('06-06-1946', 'dd-mm-yyyy'), 'Jordan', 'Lillian', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (166, 'Jean', 'Griggs', 274, 96207, 0, to_date('24-05-1965', 'dd-mm-yyyy'), 'Lawrence', 'Jacqueline', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (173, 'Eugene', 'Viterelli', 375, 92263, 0, to_date('12-09-1924', 'dd-mm-yyyy'), 'Timothy', 'Meghan', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (177, 'Taylor', 'Pride', 179, 56757, 0, to_date('02-01-1962', 'dd-mm-yyyy'), 'Tyler', 'Lisa', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (182, 'Bebe', 'Osbourne', 145, 98029, 0, to_date('02-09-2004', 'dd-mm-yyyy'), 'Zachary', 'Lauren', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (192, 'Powers', 'Skaggs', 158, 65313, 0, to_date('23-09-1993', 'dd-mm-yyyy'), 'Philip', 'Brittany', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (196, 'Kurtwood', 'Kudrow', 173, 57812, 0, to_date('24-10-1929', 'dd-mm-yyyy'), 'Vincent', 'Samantha', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (201, 'Arnold', 'Osborne', 191, 60094, 0, to_date('23-01-2007', 'dd-mm-yyyy'), 'George', 'Amanda', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (316, 'Swoosie', 'Haggard', 55, 38894, 0, to_date('11-10-1993', 'dd-mm-yyyy'), 'Dustin', 'Taylor', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (319, 'Gavin', 'Ward', 4, 73355, 0, to_date('14-07-1983', 'dd-mm-yyyy'), 'Shannon', 'Jessica', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (324, 'Orlando', 'Pigott-Smith', 128, 89117, 0, to_date('04-01-1958', 'dd-mm-yyyy'), 'Ryan', 'Catherine', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (328, 'Marley', 'Kimball', 379, 30582, 0, to_date('22-09-1929', 'dd-mm-yyyy'), 'Ezekiel', 'Penelope', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (336, 'Rosie', 'Ness', 351, 70174, 0, to_date('23-05-1986', 'dd-mm-yyyy'), 'Philip', 'Susan', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (339, 'Beverley', 'Roth', 137, 45025, 0, to_date('25-02-2017', 'dd-mm-yyyy'), 'Sebastian', 'Kayla', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (344, 'Jennifer', 'Cartlidge', 86, 45108, 0, to_date('27-08-1951', 'dd-mm-yyyy'), 'Harold', 'Gabriella', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (347, 'Joaquin', 'Forrest', 23, 32315, 0, to_date('17-06-1952', 'dd-mm-yyyy'), 'Harold', 'Ashley', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (351, 'Lindsey', 'Serbedzija', 326, 40994, 0, to_date('21-09-1933', 'dd-mm-yyyy'), 'Dustin', 'Sheila', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (356, 'Andie', 'Diesel', 399, 66452, 0, to_date('13-09-2001', 'dd-mm-yyyy'), 'Owen', 'Lillian', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (359, 'Paula', 'Kirshner', 356, 12777, 0, to_date('10-06-1945', 'dd-mm-yyyy'), 'Richard', 'Bethany', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (363, 'Jackson', 'McCann', 71, 70832, 0, to_date('15-08-1970', 'dd-mm-yyyy'), 'Benjamin', 'Lucy', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (369, 'Julianna', 'Tyler', 372, 96318, 0, to_date('26-06-1975', 'dd-mm-yyyy'), 'Stephen', 'Jane', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (374, 'Jack', 'Caine', 37, 34493, 0, to_date('17-01-2013', 'dd-mm-yyyy'), 'Benjamin', 'Nancy', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (380, 'Rhett', 'Postlethwaite', 40, 25787, 167, to_date('27-02-1969', 'dd-mm-yyyy'), 'Oliver', 'Evelyn', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (388, 'Azucar', 'Alston', 293, 28812, 0, to_date('18-03-1985', 'dd-mm-yyyy'), 'Isaac', 'Caroline', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (391, 'Kyle', 'Baranski', 10, 61259, 0, to_date('29-03-1955', 'dd-mm-yyyy'), 'Isaiah', 'Monica', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (399, 'Ice', 'Gandolfini', 35, 84813, 0, to_date('14-07-1936', 'dd-mm-yyyy'), 'Nathan', 'Bridget', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (404, 'Lennie', 'Hughes', 214, 60369, 0, to_date('12-06-1947', 'dd-mm-yyyy'), 'Wesley', 'Diana', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (407, 'Keith', 'Himmelman', 152, 69063, 0, to_date('17-07-2013', 'dd-mm-yyyy'), 'Adam', 'Margaret', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (411, 'Laurence', 'Gaines', 172, 41988, 0, to_date('06-07-1950', 'dd-mm-yyyy'), 'Andrew', 'Teresa', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (12, 'Keith', 'Roberts', 1, 89883, 0, to_date('16-04-2012', 'dd-mm-yyyy'), 'Patrick', 'Janet', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (30, 'Luna', 'Cruz', 1, 2077, 0, to_date('25-04-2015', 'dd-mm-yyyy'), 'Eric', 'Natalie', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (42, 'Heather', 'Robinson', 1, 40285, 0, to_date('06-08-2008', 'dd-mm-yyyy'), 'Eric', 'Tiffany', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (57, 'Zachary', 'Garcia', 1, 18023, 0, to_date('13-12-2014', 'dd-mm-yyyy'), 'Cody', 'Kelly', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (60, 'Jayden', 'Hernandez', 1, 72076, 0, to_date('16-01-2016', 'dd-mm-yyyy'), 'Harold', 'Claudia', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (61, 'Scott', 'Hall', 1, 87298, 0, to_date('13-12-2011', 'dd-mm-yyyy'), 'Gabriel', 'Hannah', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (65, 'Anthony', 'Moore', 1, 91495, 0, to_date('12-10-2017', 'dd-mm-yyyy'), 'William', 'Penelope', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (68, 'Courtney', 'Rodriguez', 1, 52704, 0, to_date('23-03-2006', 'dd-mm-yyyy'), 'Jacob', 'Sophia', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (71, 'Nathan', 'Anderson', 1, 10704, 0, to_date('13-09-2009', 'dd-mm-yyyy'), 'Vincent', 'Jennifer', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (89, 'Ava', 'Williams', 1, 73809, 0, to_date('02-08-2013', 'dd-mm-yyyy'), 'Nicholas', 'Abigail', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (90, 'Louise', 'Robinson', 1, 1305, 0, to_date('16-10-2011', 'dd-mm-yyyy'), 'Ronald', 'Heather', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (102, 'Nicholas', 'Garcia', 1, 67652, 0, to_date('29-01-2009', 'dd-mm-yyyy'), 'Derek', 'Linda', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (115, 'Lillian', 'Lewis', 1, 44067, 0, to_date('27-06-2010', 'dd-mm-yyyy'), 'Sebastian', 'Tiffany', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (116, 'Dustin', 'Lewis', 1, 52384, 0, to_date('24-06-2006', 'dd-mm-yyyy'), 'George', 'Rachel', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (118, 'Aaron', 'Lee', 1, 40356, 0, to_date('11-10-2015', 'dd-mm-yyyy'), 'Julian', 'Cheryl', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (132, 'Faith', 'Thomas', 1, 68539, 0, to_date('02-09-2017', 'dd-mm-yyyy'), 'Brian', 'Evelyn', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (138, 'Joshua', 'Rodriguez', 1, 86276, 0, to_date('12-06-2013', 'dd-mm-yyyy'), 'Adrian', 'Teresa', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (141, 'Maya', 'Scott', 1, 59396, 0, to_date('22-11-2013', 'dd-mm-yyyy'), 'Joan', 'Lily', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (143, 'Antonio', 'Garcia', 1, 45388, 0, to_date('06-02-2009', 'dd-mm-yyyy'), 'Javier', 'Luna', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (144, 'Jordan', 'Lee', 1, 74390, 0, to_date('19-06-2007', 'dd-mm-yyyy'), 'Leonardo', 'Ruby', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (155, 'Scott', 'Phillips', 1, 61420, 0, to_date('06-03-2012', 'dd-mm-yyyy'), 'Dennis', 'Natalie', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (161, 'Dustin', 'Phillips', 1, 38015, 0, to_date('13-05-2016', 'dd-mm-yyyy'), 'Brandon', 'Bridget', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (162, 'Kevin', 'Johnson', 1, 58249, 0, to_date('13-12-2011', 'dd-mm-yyyy'), 'Brandon', 'Bethany', 14);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (171, 'Leonardo', 'Rodriguez', 1, 40465, 0, to_date('17-06-2009', 'dd-mm-yyyy'), 'Jayden', 'Julia', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (209, 'Jacob', 'Moore', 1, 20844, 0, to_date('11-06-2015', 'dd-mm-yyyy'), 'Stephen', 'Abigail', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (224, 'Chad', 'Clark', 1, 66830, 0, to_date('03-01-2013', 'dd-mm-yyyy'), 'Jacob', 'Stephanie', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (226, 'Maria', 'Hernandez', 1, 92833, 0, to_date('25-04-2009', 'dd-mm-yyyy'), 'George', 'Alexis', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (229, 'Shannon', 'Lopez', 1, 77565, 0, to_date('17-11-2011', 'dd-mm-yyyy'), 'Austin', 'Isabella', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (234, 'Diana', 'Clark', 1, 58229, 0, to_date('01-02-2014', 'dd-mm-yyyy'), 'Joan', 'Nicole', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (244, 'Julia', 'Nguyen', 1, 77729, 0, to_date('27-03-2016', 'dd-mm-yyyy'), 'Chad', 'Rose', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (254, 'Rebecca', 'Roberts', 1, 78219, 0, to_date('24-01-2005', 'dd-mm-yyyy'), 'Miguel', 'Courtney', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (258, 'Thomas', 'Nguyen', 1, 25948, 0, to_date('10-06-2017', 'dd-mm-yyyy'), 'Justin', 'Brenda', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (270, 'Christopher', 'Davis', 1, 79700, 0, to_date('03-03-2014', 'dd-mm-yyyy'), 'Patrick', 'Cecilia', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (273, 'Nicholas', 'Allen', 1, 7005, 0, to_date('26-02-2005', 'dd-mm-yyyy'), 'Ezekiel', 'Pamela', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (275, 'Antonio', 'Walker', 1, 78813, 0, to_date('05-10-2017', 'dd-mm-yyyy'), 'Andrew', 'Danielle', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (283, 'Andrew', 'Garcia', 1, 34600, 0, to_date('09-05-2013', 'dd-mm-yyyy'), 'Wesley', 'Lucy', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (301, 'Luke', 'Johnson', 1, 33279, 0, to_date('15-06-2012', 'dd-mm-yyyy'), 'Trevor', 'Alice', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (313, 'Mia', 'Rogers', 1, 47544, 0, to_date('26-02-2017', 'dd-mm-yyyy'), 'Richard', 'Linda', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (330, 'Cole', 'Green', 1, 20537, 0, to_date('19-03-2017', 'dd-mm-yyyy'), 'Keith', 'Sheila', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (342, 'Derek', 'Robinson', 1, 44493, 0, to_date('11-07-2010', 'dd-mm-yyyy'), 'Isaac', 'Janet', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (355, 'Aaron', 'Hernandez', 1, 31214, 0, to_date('26-03-2009', 'dd-mm-yyyy'), 'Diego', 'Lisa', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (364, 'Luna', 'Walker', 1, 24067, 0, to_date('16-06-2013', 'dd-mm-yyyy'), 'Aaron', 'Diana', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (392, 'Sean', 'Rogers', 1, 26195, 0, to_date('16-01-2014', 'dd-mm-yyyy'), 'Kyle', 'Heather', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (415, 'Jayden', 'Brown', 1, 33734, 0, to_date('28-07-2005', 'dd-mm-yyyy'), 'Miguel', 'Lillian', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (428, 'Dylan', 'Lopez', 1, 57681, 0, to_date('19-03-2012', 'dd-mm-yyyy'), 'Luke', 'Jillian', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (429, 'Nathan', 'Campbell', 1, 7588, 0, to_date('27-08-2017', 'dd-mm-yyyy'), 'Lawrence', 'Meghan', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (460, 'Dennis', 'Hernandez', 1, 83538, 0, to_date('15-04-2017', 'dd-mm-yyyy'), 'Diego', 'Heather', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (461, 'Isaiah', 'Allen', 1, 61548, 0, to_date('02-12-2016', 'dd-mm-yyyy'), 'Julian', 'Maria', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (463, 'Rose', 'Walker', 1, 8009, 0, to_date('10-09-2017', 'dd-mm-yyyy'), 'Edward', 'Phoebe', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (512, 'Dorothy', 'Davis', 1, 81323, 0, to_date('03-08-2010', 'dd-mm-yyyy'), 'John', 'Agnes', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (514, 'Joan', 'Garcia', 1, 87263, 0, to_date('16-09-2008', 'dd-mm-yyyy'), 'Daniel', 'Rebecca', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (515, 'Dorothy', 'Lopez', 1, 13819, 0, to_date('10-08-2006', 'dd-mm-yyyy'), 'Chad', 'Alexis', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (517, 'Andrew', 'Hernandez', 1, 60321, 0, to_date('29-03-2006', 'dd-mm-yyyy'), 'Cameron', 'Kristen', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (518, 'Isaiah', 'Scott', 1, 97642, 0, to_date('29-03-2006', 'dd-mm-yyyy'), 'Julian', 'Shirley', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (521, 'Philip', 'Clark', 1, 14546, 0, to_date('06-09-2011', 'dd-mm-yyyy'), 'Lawrence', 'Hannah', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (522, 'Douglas', 'Moore', 1, 74412, 0, to_date('24-03-2010', 'dd-mm-yyyy'), 'Zachary', 'Leah', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (523, 'Dorothy', 'Clark', 1, 84493, 0, to_date('21-01-2006', 'dd-mm-yyyy'), 'Aaron', 'Sheila', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (524, 'Owen', 'Garcia', 1, 78217, 0, to_date('17-01-2005', 'dd-mm-yyyy'), 'Cole', 'Rebecca', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (526, 'Agnes', 'Jones', 1, 99013, 0, to_date('11-12-2013', 'dd-mm-yyyy'), 'Austin', 'Danielle', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (528, 'David', 'Lee', 1, 10357, 0, to_date('28-07-2015', 'dd-mm-yyyy'), 'Nicholas', 'Taylor', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (529, 'Lori', 'Watson', 1, 86248, 0, to_date('26-11-2011', 'dd-mm-yyyy'), 'Jesse', 'Ruby', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (530, 'Brandon', 'Lee', 1, 48173, 0, to_date('17-11-2012', 'dd-mm-yyyy'), 'Jonathan', 'Ruby', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (531, 'Katherine', 'Lewis', 1, 34140, 0, to_date('24-06-2010', 'dd-mm-yyyy'), 'Brandon', 'Jessica', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (532, 'Michelle', 'Davis', 1, 74729, 0, to_date('31-10-2007', 'dd-mm-yyyy'), 'Felipe', 'Lisa', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (533, 'Brenda', 'Garcia', 1, 54118, 0, to_date('19-08-2008', 'dd-mm-yyyy'), 'Douglas', 'Sandra', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (535, 'Jordan', 'Wilson', 1, 76686, 0, to_date('11-11-2011', 'dd-mm-yyyy'), 'Abraham', 'Samantha', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (537, 'Mia', 'Allen', 1, 95129, 0, to_date('28-06-2014', 'dd-mm-yyyy'), 'Antonio', 'Isabella', 10);
commit;
prompt 900 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (538, 'Aaron', 'Lopez', 1, 30194, 0, to_date('17-12-2008', 'dd-mm-yyyy'), 'Cameron', 'Kelly', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (540, 'Sharon', 'Hernandez', 1, 37605, 0, to_date('03-05-2006', 'dd-mm-yyyy'), 'Jordan', 'Vivian', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (542, 'Alice', 'Clark', 1, 75027, 0, to_date('03-03-2007', 'dd-mm-yyyy'), 'Joshua', 'Sheila', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (543, 'Jonathan', 'Walker', 1, 22228, 0, to_date('31-03-2011', 'dd-mm-yyyy'), 'Walter', 'Alice', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (544, 'Kayla', 'Hernandez', 1, 31356, 0, to_date('31-03-2009', 'dd-mm-yyyy'), 'Nathaniel', 'Audrey', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (545, 'Lauren', 'Lopez', 1, 15213, 0, to_date('10-08-2015', 'dd-mm-yyyy'), 'Joseph', 'Claire', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (546, 'Molly', 'Rodriguez', 1, 29179, 0, to_date('15-07-2012', 'dd-mm-yyyy'), 'Lawrence', 'Diana', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (547, 'Cody', 'Garcia', 1, 96919, 0, to_date('19-03-2012', 'dd-mm-yyyy'), 'Benjamin', 'Danielle', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (548, 'Alexandra', 'Sanchez', 1, 50530, 0, to_date('05-04-2012', 'dd-mm-yyyy'), 'Alan', 'Heather', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (550, 'Jack', 'Miller', 1, 73969, 0, to_date('13-01-2016', 'dd-mm-yyyy'), 'Ezekiel', 'Ava', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (551, 'Agnes', 'Lopez', 1, 63521, 0, to_date('07-10-2011', 'dd-mm-yyyy'), 'Nathan', 'Shirley', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (553, 'Juan', 'Robinson', 1, 50929, 0, to_date('11-03-2017', 'dd-mm-yyyy'), 'Ezekiel', 'Lily', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (554, 'Bethany', 'Roy', 1, 16969, 0, to_date('22-12-2013', 'dd-mm-yyyy'), 'Wyatt', 'Alexandra', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (555, 'Diego', 'Hernandez', 1, 39358, 0, to_date('16-10-2008', 'dd-mm-yyyy'), 'Jacob', 'Heather', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (556, 'Maria', 'Roberts', 1, 31670, 0, to_date('18-09-2008', 'dd-mm-yyyy'), 'Derek', 'Lily', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (557, 'Julia', 'Rodriguez', 1, 6422, 0, to_date('10-10-2008', 'dd-mm-yyyy'), 'Abraham', 'Rachel', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (558, 'Alana', 'Rodriguez', 1, 45671, 0, to_date('21-08-2016', 'dd-mm-yyyy'), 'Harold', 'Shirley', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (561, 'Bethany', 'Scott', 1, 85652, 0, to_date('15-11-2014', 'dd-mm-yyyy'), 'Nathan', 'Olivia', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (562, 'Danielle', 'Robinson', 1, 99365, 0, to_date('13-06-2007', 'dd-mm-yyyy'), 'Henry', 'Nicole', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (563, 'Jonathan', 'Garcia', 1, 22939, 0, to_date('01-11-2005', 'dd-mm-yyyy'), 'Alan', 'Kimberly', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (566, 'Charles', 'Rodriguez', 1, 48105, 0, to_date('11-12-2016', 'dd-mm-yyyy'), 'Nathaniel', 'Heather', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (567, 'Stephen', 'Rogers', 1, 66111, 0, to_date('31-08-2015', 'dd-mm-yyyy'), 'Christopher', 'Charlene', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (568, 'Eric', 'Davis', 1, 96592, 0, to_date('20-03-2013', 'dd-mm-yyyy'), 'Douglas', 'Lauren', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (570, 'Lawrence', 'Hernandez', 1, 18858, 0, to_date('05-04-2017', 'dd-mm-yyyy'), 'William', 'Lisa', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (573, 'Julian', 'Garcia', 1, 57085, 0, to_date('20-01-2012', 'dd-mm-yyyy'), 'Christopher', 'Ruby', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (576, 'Diana', 'Adams', 1, 31629, 0, to_date('16-05-2012', 'dd-mm-yyyy'), 'Shannon', 'Alexandra', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (577, 'Peyton', 'Lewis', 1, 32098, 0, to_date('05-04-2012', 'dd-mm-yyyy'), 'Scott', 'Bridget', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (578, 'Luke', 'Mitchell', 1, 6307, 0, to_date('22-07-2008', 'dd-mm-yyyy'), 'Travis', 'Diana', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (579, 'Miguel', 'Hall', 1, 40333, 0, to_date('24-01-2016', 'dd-mm-yyyy'), 'Douglas', 'Olivia', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (580, 'Gregory', 'Lewis', 1, 90541, 0, to_date('06-11-2008', 'dd-mm-yyyy'), 'Joseph', 'Danielle', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (581, 'Wesley', 'Williams', 1, 8560, 0, to_date('10-06-2012', 'dd-mm-yyyy'), 'George', 'Sandra', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (583, 'Richard', 'Young', 1, 51274, 0, to_date('20-03-2011', 'dd-mm-yyyy'), 'Cameron', 'Lucy', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (587, 'Diana', 'King', 1, 83003, 0, to_date('11-10-2005', 'dd-mm-yyyy'), 'Xavier', 'Nicole', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (588, 'Dennis', 'Scott', 1, 61170, 0, to_date('19-04-2009', 'dd-mm-yyyy'), 'Keith', 'Kristen', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (589, 'Kelly', 'Rogers', 1, 71631, 0, to_date('29-08-2014', 'dd-mm-yyyy'), 'Sean', 'Alexis', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (591, 'Jayden', 'Miller', 1, 94306, 0, to_date('18-05-2016', 'dd-mm-yyyy'), 'Scott', 'Bethany', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (592, 'Margaret', 'Lee', 1, 93860, 0, to_date('22-04-2012', 'dd-mm-yyyy'), 'Nathaniel', 'Angela', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (594, 'Shannon', 'Johnson', 1, 20344, 0, to_date('26-01-2014', 'dd-mm-yyyy'), 'George', 'Lydia', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (595, 'Susan', 'Hernandez', 1, 4037, 0, to_date('28-09-2014', 'dd-mm-yyyy'), 'Brian', 'Linda', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (597, 'Sebastian', 'King', 1, 31552, 0, to_date('16-10-2011', 'dd-mm-yyyy'), 'John', 'Cecilia', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (599, 'Jade', 'Jones', 1, 1954, 0, to_date('05-03-2006', 'dd-mm-yyyy'), 'Douglas', 'Lori', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (600, 'Albert', 'Lopez', 1, 56806, 0, to_date('16-04-2013', 'dd-mm-yyyy'), 'Samuel', 'Leslie', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (601, 'Courtney', 'Campbell', 1, 47728, 0, to_date('10-05-2009', 'dd-mm-yyyy'), 'Tyler', 'Carla', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (603, 'Laura', 'Rogers', 1, 90684, 0, to_date('21-11-2013', 'dd-mm-yyyy'), 'Jacob', 'Maria', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (604, 'Paul', 'Garcia', 1, 34930, 0, to_date('06-07-2007', 'dd-mm-yyyy'), 'Carlos', 'Charlene', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (606, 'Isaac', 'Anderson', 1, 79904, 0, to_date('15-08-2011', 'dd-mm-yyyy'), 'Ryan', 'Shirley', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (608, 'Christopher', 'Allen', 1, 53766, 0, to_date('08-07-2014', 'dd-mm-yyyy'), 'Henry', 'Leah', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (609, 'Alicia', 'Williams', 1, 37993, 0, to_date('02-08-2006', 'dd-mm-yyyy'), 'Samuel', 'Caroline', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (610, 'Penelope', 'Campbell', 1, 20257, 0, to_date('17-06-2014', 'dd-mm-yyyy'), 'Dennis', 'Diana', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (611, 'Philip', 'Rodriguez', 1, 25592, 0, to_date('28-02-2007', 'dd-mm-yyyy'), 'Henry', 'Jennifer', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (612, 'Madison', 'Scott', 1, 13117, 0, to_date('11-10-2014', 'dd-mm-yyyy'), 'Jacob', 'Alexis', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (613, 'Samantha', 'Lee', 1, 22821, 0, to_date('05-02-2009', 'dd-mm-yyyy'), 'Philip', 'Jennifer', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (614, 'Sophia', 'Miller', 1, 91749, 0, to_date('25-01-2009', 'dd-mm-yyyy'), 'Carlos', 'Linda', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (616, 'Philip', 'Anderson', 1, 55058, 0, to_date('24-06-2005', 'dd-mm-yyyy'), 'Henry', 'Ashley', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (618, 'Sarah', 'Williams', 1, 59031, 0, to_date('28-01-2008', 'dd-mm-yyyy'), 'Joan', 'Alexis', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (619, 'Michelle', 'Nguyen', 1, 67512, 0, to_date('05-08-2017', 'dd-mm-yyyy'), 'Joshua', 'Allison', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (620, 'Allison', 'Hernandez', 1, 89613, 0, to_date('30-06-2016', 'dd-mm-yyyy'), 'Luke', 'Claire', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (621, 'Laura', 'Robinson', 1, 5403, 0, to_date('16-06-2010', 'dd-mm-yyyy'), 'Joseph', 'Joan', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (622, 'Ronald', 'Lopez', 1, 49087, 0, to_date('27-09-2017', 'dd-mm-yyyy'), 'Ethan', 'Bethany', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (624, 'Caleb', 'Rodriguez', 1, 22450, 0, to_date('24-12-2006', 'dd-mm-yyyy'), 'Daniel', 'Stephanie', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (625, 'Samuel', 'Lee', 1, 27646, 0, to_date('01-06-2017', 'dd-mm-yyyy'), 'Chad', 'Maria', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (626, 'Antonio', 'Robinson', 1, 88620, 0, to_date('17-03-2016', 'dd-mm-yyyy'), 'Sebastian', 'Lucia', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (628, 'Isaac', 'Moore', 1, 51674, 0, to_date('28-08-2015', 'dd-mm-yyyy'), 'Gabriel', 'Danielle', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (630, 'Alan', 'Anderson', 1, 82014, 0, to_date('22-02-2010', 'dd-mm-yyyy'), 'Antonio', 'Deborah', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (632, 'Catherine', 'Nguyen', 1, 89300, 0, to_date('15-10-2017', 'dd-mm-yyyy'), 'Daniel', 'Madison', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (633, 'Harold', 'Jones', 1, 28382, 0, to_date('21-05-2010', 'dd-mm-yyyy'), 'Chad', 'Sophia', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (639, 'Isabella', 'Robinson', 1, 37063, 0, to_date('19-05-2005', 'dd-mm-yyyy'), 'Kyle', 'Evelyn', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (640, 'Lillian', 'Harris', 1, 3381, 0, to_date('23-08-2006', 'dd-mm-yyyy'), 'Felipe', 'Lisa', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (641, 'Rebecca', 'Mitchell', 1, 27499, 0, to_date('08-08-2014', 'dd-mm-yyyy'), 'Chad', 'Jennifer', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (642, 'Adam', 'Allen', 1, 16990, 0, to_date('12-09-2012', 'dd-mm-yyyy'), 'Timothy', 'Rebecca', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (643, 'Alicia', 'Wright', 1, 53159, 0, to_date('19-09-2017', 'dd-mm-yyyy'), 'Stephen', 'Samantha', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (644, 'David', 'Moore', 1, 83965, 0, to_date('06-01-2009', 'dd-mm-yyyy'), 'Cameron', 'Kristen', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (645, 'John', 'Johnson', 1, 6644, 0, to_date('16-06-2008', 'dd-mm-yyyy'), 'Xavier', 'Teresa', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (646, 'Kimberly', 'Johnson', 1, 87866, 0, to_date('04-03-2015', 'dd-mm-yyyy'), 'Juan', 'Monica', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (647, 'Travis', 'Johnson', 1, 85745, 0, to_date('23-01-2009', 'dd-mm-yyyy'), 'Harold', 'Jillian', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (649, 'Monica', 'Lopez', 1, 41380, 0, to_date('05-11-2010', 'dd-mm-yyyy'), 'Isaac', 'Alexis', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (651, 'Shirley', 'Garcia', 1, 6669, 0, to_date('15-06-2006', 'dd-mm-yyyy'), 'Christopher', 'Heather', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (653, 'Brittany', 'Mitchell', 1, 93338, 0, to_date('24-12-2010', 'dd-mm-yyyy'), 'Luke', 'Cecilia', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (655, 'Amelia', 'Walker', 1, 83231, 0, to_date('12-03-2010', 'dd-mm-yyyy'), 'Austin', 'Kimberly', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (656, 'Danielle', 'Clark', 1, 83208, 0, to_date('24-01-2010', 'dd-mm-yyyy'), 'Dustin', 'Claire', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (657, 'Alexandra', 'Garcia', 1, 21025, 0, to_date('31-12-2012', 'dd-mm-yyyy'), 'Noah', 'Hannah', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (659, 'Jade', 'Young', 1, 62552, 0, to_date('09-09-2007', 'dd-mm-yyyy'), 'Cody', 'Penelope', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (660, 'Paul', 'Martinez', 1, 60332, 0, to_date('13-10-2005', 'dd-mm-yyyy'), 'Kyle', 'Samantha', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (661, 'Adam', 'Scott', 1, 5686, 0, to_date('11-08-2017', 'dd-mm-yyyy'), 'Alan', 'Jacqueline', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (665, 'Lucas', 'Clark', 1, 50571, 0, to_date('20-09-2016', 'dd-mm-yyyy'), 'Tyler', 'Fiona', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (666, 'Brittany', 'Lee', 1, 65097, 0, to_date('13-07-2008', 'dd-mm-yyyy'), 'Travis', 'Cecilia', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (668, 'Ava', 'Hernandez', 1, 2160, 0, to_date('14-08-2017', 'dd-mm-yyyy'), 'Theodore', 'Rachel', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (669, 'Stephanie', 'Rodriguez', 1, 40477, 0, to_date('15-06-2011', 'dd-mm-yyyy'), 'Joshua', 'Jade', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (671, 'Sean', 'Robinson', 1, 31477, 0, to_date('15-01-2009', 'dd-mm-yyyy'), 'Eric', 'Alice', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (672, 'Bethany', 'Thompson', 1, 70854, 0, to_date('23-04-2008', 'dd-mm-yyyy'), 'Joseph', 'Lillian', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (676, 'Abigail', 'Miller', 1, 12168, 0, to_date('21-01-2006', 'dd-mm-yyyy'), 'Xavier', 'Courtney', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (677, 'Andrew', 'Rodriguez', 1, 62269, 0, to_date('20-12-2010', 'dd-mm-yyyy'), 'Jordan', 'Claire', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (680, 'Hannah', 'Rogers', 1, 68137, 0, to_date('09-01-2014', 'dd-mm-yyyy'), 'Cody', 'Sheila', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (682, 'Xavier', 'Hernandez', 1, 21749, 0, to_date('02-11-2006', 'dd-mm-yyyy'), 'Edward', 'Jessica', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (685, 'Bridget', 'Robinson', 1, 1222, 0, to_date('26-06-2010', 'dd-mm-yyyy'), 'Sebastian', 'Madison', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (687, 'Lawrence', 'Garcia', 1, 75431, 0, to_date('08-01-2010', 'dd-mm-yyyy'), 'Zachary', 'Ashley', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (688, 'Natalie', 'Allen', 1, 3125, 0, to_date('03-06-2006', 'dd-mm-yyyy'), 'Theodore', 'Meghan', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (689, 'Philip', 'Clark', 1, 57971, 0, to_date('13-05-2006', 'dd-mm-yyyy'), 'Keith', 'Olivia', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (695, 'Luke', 'Allen', 1, 13858, 0, to_date('19-07-2007', 'dd-mm-yyyy'), 'Sebastian', 'Samantha', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (696, 'Luna', 'Walker', 1, 89639, 0, to_date('11-05-2017', 'dd-mm-yyyy'), 'Paul', 'Olivia', 7);
commit;
prompt 1000 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (698, 'Diego', 'Moore', 1, 99771, 0, to_date('16-06-2006', 'dd-mm-yyyy'), 'Albert', 'Alana', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, fathername, mothername, class_id)
values (699, 'Alexis', 'Hall', 1, 5192, 0, to_date('27-06-2010', 'dd-mm-yyyy'), 'Javier', 'Abigail', 29);
commit;
prompt 1002 records loaded
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
prompt Loading SUBJECT...
insert into SUBJECT (subject_id, subject_name, mandatory)
values (1, ' Anatomy', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (2, ' Astronomy', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (3, ' Algebra', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (4, ' Band/Orchestra', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (5, ' Ballet', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (6, ' Bible Studies', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (7, ' Biology', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (8, ' Business and Entrepreneurship', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (9, ' Calculus', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (10, ' Career Exploration', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (11, ' Chemistry', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (12, ' Chorus', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (13, ' Civics and Government', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (14, ' Computer Science', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (15, ' Creative Writing', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (16, ' Dance', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (17, ' Digital Literacy', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (18, ' Drama', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (19, ' Economics', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (20, ' Engineering Design', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (21, ' English Language Arts', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (22, ' Environmental Science', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (23, ' Film Studies', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (24, ' Foreign Language (French)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (25, ' Foreign Language (German)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (26, ' Foreign Language (Hebrew)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (27, ' Foreign Language (Spanish)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (28, ' Geography', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (29, ' Health', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (30, ' Jewish History', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (31, ' Jewish Philosophy', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (32, ' Latin', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (33, ' Literature', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (34, ' Mathematics', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (35, ' Media Literacy', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (36, ' Modern Art', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (37, ' Music', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (38, ' Mythology', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (39, ' Physical Education', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (40, ' Physics', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (41, ' Psychology', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (42, ' Robotics', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (43, ' Science (General)', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (44, ' Social Studies (General)', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (45, ' Sociology', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (46, ' Speech and Debate', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (47, ' Sports', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (48, ' Statistics', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (49, ' Talmud', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (50, ' United States History', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (51, ' Visual Arts', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (52, ' World History', 1);
commit;
prompt 52 records loaded
prompt Loading LESSON...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (1, 3, 9, 18, 12, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (2, 3, 10, 1, 340, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (3, 1, 11, 36, 150, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (4, 4, 12, 14, 85, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (5, 4, 10, 6, 124, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (6, 5, 9, 16, 263, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (7, 3, 8, 2, 80, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (8, 5, 10, 2, 269, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (9, 4, 9, 18, 185, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (10, 6, 11, 10, 172, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (11, 3, 14, 17, 160, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (12, 5, 14, 1, 232, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (13, 1, 14, 22, 125, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (14, 3, 13, 6, 5, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (15, 1, 12, 5, 147, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (16, 5, 9, 8, 135, 9);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (17, 5, 16, 10, 129, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (18, 3, 8, 34, 283, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (19, 1, 10, 27, 157, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (20, 6, 11, 16, 148, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (21, 3, 12, 28, 6, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (22, 4, 8, 15, 243, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (24, 2, 10, 13, 226, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (25, 2, 13, 26, 390, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (26, 5, 11, 35, 163, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (27, 2, 11, 1, 176, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (28, 1, 16, 4, 149, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (29, 4, 14, 15, 388, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (30, 2, 8, 26, 65, 6);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (31, 6, 13, 4, 70, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (32, 6, 11, 24, 305, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (33, 2, 13, 9, 88, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (34, 2, 15, 21, 344, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (35, 3, 9, 4, 41, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (36, 4, 10, 36, 184, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (37, 6, 12, 29, 90, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (38, 2, 11, 3, 318, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (39, 6, 11, 18, 211, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (40, 1, 14, 39, 48, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (41, 6, 12, 6, 304, 9);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (42, 1, 12, 31, 39, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (43, 3, 15, 36, 270, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (44, 4, 15, 4, 150, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (45, 4, 12, 30, 342, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (46, 1, 15, 40, 360, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (47, 2, 8, 19, 27, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (48, 1, 12, 26, 374, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (49, 6, 8, 35, 367, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (50, 1, 14, 18, 5, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (51, 3, 13, 11, 316, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (52, 6, 14, 20, 45, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (53, 1, 10, 34, 131, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (54, 2, 10, 14, 34, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (55, 1, 13, 40, 50, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (56, 2, 12, 35, 210, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (57, 1, 8, 20, 52, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (58, 1, 12, 15, 237, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (59, 3, 10, 4, 128, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (60, 2, 8, 24, 331, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (61, 2, 13, 18, 268, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (62, 3, 8, 30, 76, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (63, 1, 14, 33, 180, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (64, 1, 13, 1, 270, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (65, 3, 8, 23, 117, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (66, 3, 15, 7, 81, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (67, 4, 14, 36, 238, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (68, 1, 16, 2, 138, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (69, 6, 13, 19, 183, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (71, 5, 14, 17, 343, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (72, 5, 13, 1, 266, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (73, 6, 13, 22, 354, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (74, 2, 12, 36, 370, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (75, 3, 8, 10, 369, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (76, 2, 11, 20, 80, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (77, 1, 10, 12, 238, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (78, 4, 13, 19, 41, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (79, 6, 10, 33, 61, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (80, 1, 10, 2, 338, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (81, 1, 14, 32, 372, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (82, 1, 13, 26, 396, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (83, 6, 13, 17, 179, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (84, 6, 14, 27, 102, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (85, 1, 11, 14, 376, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (86, 1, 8, 10, 256, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (87, 2, 11, 12, 151, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (88, 2, 11, 21, 317, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (89, 5, 13, 6, 300, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (90, 5, 12, 30, 94, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (91, 6, 13, 37, 116, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (92, 3, 16, 35, 355, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (93, 3, 16, 1, 287, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (94, 3, 13, 7, 400, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (96, 3, 13, 22, 7, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (97, 3, 16, 37, 222, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (98, 5, 16, 36, 260, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (99, 5, 9, 10, 6, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (100, 5, 8, 25, 284, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (101, 1, 10, 19, 296, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (102, 5, 13, 13, 169, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (103, 4, 11, 1, 273, 37);
commit;
prompt 100 records committed...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (104, 5, 15, 18, 92, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (105, 3, 10, 31, 327, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (106, 4, 15, 2, 390, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (107, 5, 10, 26, 170, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (108, 4, 9, 34, 358, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (109, 5, 10, 29, 190, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (110, 1, 12, 32, 287, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (111, 1, 10, 4, 263, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (112, 6, 9, 34, 72, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (113, 5, 13, 32, 193, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (114, 3, 11, 9, 144, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (115, 3, 14, 36, 253, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (116, 4, 13, 8, 11, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (117, 6, 12, 22, 352, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (118, 3, 11, 26, 286, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (119, 1, 14, 3, 17, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (120, 6, 13, 34, 20, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (121, 6, 14, 13, 392, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (122, 1, 11, 39, 36, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (123, 3, 10, 10, 191, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (124, 6, 13, 28, 213, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (125, 2, 11, 27, 37, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (126, 5, 10, 23, 304, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (127, 2, 16, 35, 296, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (128, 6, 14, 28, 165, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (129, 3, 10, 18, 18, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (130, 6, 8, 32, 150, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (131, 6, 12, 10, 95, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (132, 3, 15, 32, 267, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (134, 1, 8, 17, 118, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (135, 6, 11, 6, 378, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (137, 5, 16, 29, 148, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (138, 1, 12, 10, 80, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (139, 6, 14, 37, 266, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (140, 2, 10, 27, 33, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (141, 3, 11, 1, 7, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (142, 4, 14, 21, 193, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (143, 5, 16, 25, 231, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (145, 4, 13, 34, 14, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (146, 1, 11, 1, 94, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (147, 4, 9, 26, 126, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (148, 6, 11, 31, 368, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (149, 5, 10, 30, 100, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (150, 3, 9, 34, 357, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (151, 6, 13, 16, 13, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (152, 5, 14, 24, 398, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (153, 5, 13, 24, 318, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (154, 1, 12, 24, 321, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (155, 5, 11, 19, 88, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (156, 3, 13, 36, 204, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (157, 1, 12, 17, 143, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (158, 1, 9, 36, 111, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (160, 1, 14, 29, 400, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (161, 5, 13, 21, 54, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (162, 5, 14, 39, 373, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (163, 4, 14, 7, 333, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (164, 6, 14, 14, 237, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (165, 6, 14, 25, 323, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (166, 5, 14, 22, 147, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (167, 3, 11, 24, 16, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (168, 1, 9, 9, 82, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (169, 3, 9, 1, 71, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (172, 3, 8, 19, 54, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (173, 4, 8, 30, 129, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (174, 2, 11, 23, 307, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (175, 3, 14, 5, 344, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (176, 4, 12, 38, 71, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (177, 6, 10, 10, 147, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (178, 4, 8, 38, 47, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (179, 4, 15, 29, 69, 37);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (180, 4, 16, 24, 277, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (181, 1, 12, 13, 94, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (182, 5, 16, 1, 360, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (183, 4, 14, 12, 290, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (184, 6, 15, 30, 136, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (185, 1, 14, 8, 398, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (186, 6, 15, 29, 366, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (187, 2, 11, 26, 22, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (188, 4, 14, 8, 133, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (189, 4, 10, 32, 263, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (190, 5, 10, 20, 398, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (192, 5, 9, 24, 174, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (193, 4, 16, 32, 208, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (194, 5, 15, 27, 109, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (196, 1, 14, 15, 50, 6);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (197, 3, 15, 40, 184, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (198, 2, 15, 3, 72, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (199, 4, 11, 3, 326, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (200, 6, 9, 40, 216, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (201, 3, 13, 5, 285, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (202, 4, 14, 30, 176, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (203, 4, 14, 23, 121, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (204, 6, 10, 28, 81, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (205, 3, 12, 39, 30, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (206, 1, 9, 7, 239, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (207, 1, 13, 28, 161, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (208, 2, 14, 25, 258, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (209, 2, 13, 22, 237, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (212, 5, 10, 11, 147, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (213, 3, 11, 27, 39, 4);
commit;
prompt 200 records committed...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (214, 3, 16, 8, 239, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (216, 6, 13, 18, 326, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (217, 5, 8, 9, 86, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (218, 4, 16, 4, 343, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (219, 2, 16, 17, 290, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (221, 4, 14, 37, 283, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (223, 4, 9, 20, 128, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (224, 2, 8, 39, 355, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (225, 6, 13, 9, 91, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (226, 1, 9, 8, 293, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (227, 5, 10, 14, 381, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (229, 1, 8, 3, 359, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (230, 1, 10, 5, 169, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (231, 1, 10, 6, 229, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (232, 3, 15, 1, 299, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (235, 3, 9, 33, 273, 9);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (236, 5, 9, 31, 77, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (237, 4, 14, 11, 211, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (239, 6, 9, 33, 23, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (240, 5, 8, 22, 64, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (241, 3, 16, 23, 60, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (242, 1, 8, 13, 351, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (243, 3, 12, 31, 249, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (244, 2, 8, 36, 94, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (245, 4, 9, 7, 70, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (246, 6, 11, 7, 397, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (247, 4, 15, 9, 384, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (248, 1, 13, 4, 66, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (249, 1, 8, 19, 365, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (250, 5, 13, 40, 378, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (251, 4, 10, 5, 69, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (252, 2, 16, 28, 154, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (253, 5, 9, 13, 322, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (254, 2, 12, 16, 12, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (255, 1, 8, 27, 41, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (257, 4, 13, 40, 243, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (258, 2, 11, 35, 18, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (259, 3, 12, 32, 55, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (262, 5, 14, 29, 366, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (263, 4, 11, 12, 27, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (264, 6, 10, 19, 334, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (265, 6, 13, 6, 383, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (266, 6, 8, 2, 30, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (267, 2, 15, 25, 306, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (268, 1, 11, 2, 312, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (269, 4, 11, 29, 208, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (270, 4, 15, 22, 59, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (271, 1, 13, 16, 253, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (272, 6, 12, 26, 165, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (273, 6, 8, 15, 322, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (274, 6, 11, 1, 286, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (275, 6, 14, 23, 32, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (276, 2, 16, 1, 340, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (277, 2, 12, 10, 355, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (278, 2, 8, 25, 93, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (279, 1, 8, 29, 206, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (280, 5, 14, 10, 59, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (281, 5, 14, 21, 149, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (282, 1, 13, 12, 156, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (283, 2, 13, 28, 218, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (285, 1, 8, 6, 329, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (286, 6, 10, 39, 177, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (287, 2, 14, 36, 176, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (288, 3, 15, 15, 42, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (290, 2, 12, 7, 131, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (291, 1, 10, 20, 8, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (292, 1, 14, 31, 305, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (293, 4, 15, 39, 291, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (295, 5, 12, 37, 203, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (296, 4, 16, 33, 326, 10);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (297, 2, 16, 31, 298, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (298, 4, 15, 38, 254, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (299, 4, 13, 1, 19, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (300, 2, 16, 33, 164, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (301, 3, 14, 38, 185, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (302, 2, 8, 18, 43, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (303, 6, 11, 29, 353, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (304, 6, 15, 24, 246, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (305, 3, 10, 12, 262, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (306, 4, 13, 13, 191, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (307, 2, 13, 13, 177, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (308, 5, 11, 25, 13, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (310, 5, 12, 1, 241, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (313, 1, 9, 29, 285, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (314, 3, 14, 18, 118, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (315, 4, 15, 30, 78, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (316, 2, 16, 5, 42, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (317, 4, 10, 39, 88, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (318, 3, 15, 14, 100, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (319, 5, 9, 15, 326, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (320, 6, 10, 9, 315, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (321, 6, 15, 27, 178, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (322, 6, 10, 25, 37, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (323, 4, 13, 16, 275, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (324, 4, 14, 16, 179, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (325, 3, 10, 5, 244, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (326, 1, 14, 25, 267, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (327, 2, 8, 10, 222, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (328, 4, 10, 27, 290, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (330, 2, 10, 4, 316, 28);
commit;
prompt 300 records committed...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (331, 5, 13, 27, 93, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (332, 4, 8, 16, 116, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (333, 5, 16, 3, 140, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (334, 3, 11, 3, 33, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (335, 5, 10, 17, 209, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (336, 5, 12, 31, 197, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (337, 6, 12, 39, 50, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (338, 5, 12, 24, 251, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (339, 4, 12, 33, 359, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (340, 3, 15, 5, 348, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (341, 2, 11, 31, 110, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (342, 3, 10, 26, 211, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (343, 5, 11, 23, 167, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (344, 1, 16, 18, 55, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (345, 4, 11, 7, 350, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (347, 6, 8, 20, 269, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (349, 5, 11, 38, 8, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (350, 3, 12, 19, 41, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (351, 6, 8, 29, 267, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (352, 1, 16, 10, 130, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (353, 6, 9, 13, 100, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (356, 4, 9, 2, 372, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (357, 3, 13, 28, 105, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (359, 5, 11, 17, 129, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (362, 1, 16, 25, 289, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (363, 2, 11, 36, 90, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (364, 2, 14, 38, 156, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (365, 6, 14, 29, 300, 37);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (367, 4, 14, 24, 87, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (368, 2, 9, 9, 114, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (369, 2, 13, 11, 385, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (370, 1, 12, 8, 3, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (371, 6, 10, 37, 136, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (372, 1, 13, 18, 285, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (373, 5, 8, 6, 71, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (374, 2, 11, 28, 232, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (375, 2, 9, 28, 198, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (376, 3, 10, 27, 296, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (378, 4, 9, 36, 136, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (379, 2, 12, 33, 295, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (380, 5, 15, 23, 58, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (383, 3, 13, 39, 156, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (384, 4, 10, 25, 186, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (386, 4, 9, 19, 28, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (387, 1, 12, 12, 101, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (388, 2, 10, 26, 178, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (390, 3, 15, 9, 341, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (391, 5, 15, 20, 150, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (395, 4, 13, 25, 53, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (398, 4, 8, 14, 239, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (399, 5, 12, 26, 234, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (400, 2, 15, 30, 298, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (401, 6, 13, 14, 100, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (402, 6, 10, 24, 343, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (404, 5, 16, 38, 72, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (406, 2, 15, 4, 185, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (409, 1, 11, 7, 232, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (410, 2, 9, 1, 53, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (411, 5, 8, 11, 139, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (412, 2, 10, 36, 212, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (414, 6, 8, 19, 298, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (415, 4, 11, 19, 130, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (416, 4, 9, 8, 189, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (418, 3, 16, 12, 102, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (419, 1, 8, 36, 337, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (420, 2, 14, 20, 197, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (422, 5, 11, 12, 366, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (423, 3, 14, 16, 295, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (424, 6, 13, 27, 239, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (425, 1, 15, 25, 332, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (426, 6, 13, 32, 52, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (427, 6, 12, 18, 107, 10);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (428, 6, 10, 29, 389, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (432, 1, 12, 33, 60, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (433, 4, 11, 23, 159, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (434, 4, 12, 15, 322, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (435, 1, 15, 15, 110, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (436, 2, 16, 16, 62, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (437, 2, 11, 16, 20, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (439, 1, 9, 25, 247, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (440, 2, 12, 9, 111, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (442, 3, 13, 21, 278, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (443, 3, 15, 38, 266, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (444, 4, 16, 18, 167, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (446, 6, 10, 36, 15, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (448, 2, 10, 23, 51, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (449, 3, 11, 10, 73, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (450, 1, 15, 8, 350, 30);
commit;
prompt 388 records loaded
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
prompt Loading WTEACHER...
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (1, 0, 1);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (2, 0, 2);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (3, 0, 3);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (4, 0, 4);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (5, 0, 5);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (6, 0, 6);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (7, 370, 7);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (8, 0, 8);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (9, 151, 9);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (10, 0, 10);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (11, 0, 105);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (12, 0, 366);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (13, 0, 11);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (14, 0, 312);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (15, 0, 96);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (16, 0, 12);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (17, 0, 245);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (18, 0, 70);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (19, 0, 371);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (20, 0, 185);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (21, 0, 151);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (24, 0, 42);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (25, 0, 134);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (26, 0, 226);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (27, 0, 336);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (29, 0, 170);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (30, 0, 20);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (31, 0, 314);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (32, 0, 5);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (33, 0, 1);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (34, 0, 5);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (35, 0, 142);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (37, 0, 251);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (38, 0, 101);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (39, 0, 215);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (40, 0, 131);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (41, 0, 75);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (42, 0, 195);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (43, 0, 275);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (44, 0, 221);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (46, 0, 266);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (47, 0, 345);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (48, 0, 43);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (49, 0, 45);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (50, 0, 35);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (53, 0, 95);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (54, 0, 141);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (55, 0, 77);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (56, 0, 386);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (57, 0, 88);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (58, 0, 43);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (59, 0, 122);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (60, 0, 68);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (61, 0, 66);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (62, 0, 241);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (63, 0, 85);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (64, 0, 53);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (65, 0, 290);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (66, 0, 36);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (67, 0, 145);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (68, 0, 63);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (69, 0, 165);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (70, 0, 395);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (71, 0, 176);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (72, 0, 203);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (73, 0, 76);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (76, 0, 220);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (77, 377, 168);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (78, 0, 171);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (80, 0, 294);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (81, 0, 30);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (82, 0, 314);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (83, 0, 340);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (84, 0, 152);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (85, 0, 125);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (86, 404, 101);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (87, 0, 31);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (88, 0, 104);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (90, 0, 170);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (91, 0, 152);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (92, 0, 8);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (93, 0, 185);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (94, 0, 109);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (95, 0, 283);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (96, 0, 157);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (98, 0, 6);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (99, 0, 177);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (100, 0, 94);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (101, 0, 20);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (102, 0, 330);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (103, 0, 41);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (104, 0, 147);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (105, 0, 97);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (106, 0, 125);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (107, 0, 142);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (108, 0, 98);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (109, 0, 253);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (111, 0, 139);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (112, 0, 164);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (113, 0, 76);
commit;
prompt 100 records committed...
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (114, 0, 283);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (116, 0, 317);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (118, 0, 384);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (119, 0, 286);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (120, 0, 318);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (121, 0, 43);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (123, 0, 57);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (124, 0, 83);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (125, 0, 90);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (126, 0, 188);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (127, 0, 101);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (128, 0, 367);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (129, 0, 275);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (130, 0, 345);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (131, 0, 196);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (132, 0, 183);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (133, 0, 106);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (135, 0, 129);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (137, 0, 188);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (138, 100, 44);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (140, 200, 90);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (141, 0, 194);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (142, 0, 395);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (143, 0, 72);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (144, 0, 350);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (145, 0, 157);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (146, 0, 222);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (148, 0, 383);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (149, 0, 294);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (151, 0, 211);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (152, 0, 251);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (153, 0, 144);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (154, 0, 270);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (155, 0, 369);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (156, 0, 376);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (157, 0, 245);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (158, 200, 345);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (159, 0, 35);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (160, 0, 28);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (162, 0, 379);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (163, 0, 258);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (165, 0, 11);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (166, 0, 386);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (167, 0, 58);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (168, 0, 42);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (169, 0, 100);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (170, 0, 369);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (171, 0, 25);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (172, 0, 130);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (174, 0, 48);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (175, 0, 54);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (176, 0, 48);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (177, 0, 350);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (178, 0, 110);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (179, 0, 4);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (180, 0, 9);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (181, 0, 9);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (183, 0, 75);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (184, 0, 23);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (185, 0, 29);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (186, 377, 350);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (187, 0, 121);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (188, 0, 272);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (189, 0, 12);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (190, 0, 146);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (191, 0, 277);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (192, 0, 189);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (193, 0, 5);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (195, 167, 120);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (196, 0, 274);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (197, 0, 221);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (198, 0, 189);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (200, 0, 237);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (201, 0, 83);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (203, 351, 189);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (204, 0, 253);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (206, 0, 314);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (207, 0, 131);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (208, 0, 157);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (209, 0, 29);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (210, 0, 24);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (212, 304, 154);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (213, 0, 161);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (214, 0, 286);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (215, 0, 247);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (216, 0, 259);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (218, 0, 154);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (219, 0, 43);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (220, 0, 57);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (221, 0, 53);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (222, 0, 57);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (223, 0, 324);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (224, 0, 395);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (226, 0, 152);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (227, 0, 39);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (229, 0, 125);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (231, 0, 19);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (232, 0, 394);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (235, 0, 177);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (236, 0, 195);
commit;
prompt 200 records committed...
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (239, 0, 45);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (240, 0, 74);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (241, 0, 271);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (242, 0, 143);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (243, 0, 231);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (245, 0, 389);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (246, 0, 274);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (247, 0, 396);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (248, 0, 79);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (249, 0, 49);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (250, 0, 386);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (251, 0, 167);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (252, 0, 114);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (253, 0, 333);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (254, 0, 245);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (255, 0, 167);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (256, 0, 296);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (258, 0, 247);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (259, 0, 371);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (260, 0, 16);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (261, 0, 10);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (263, 0, 188);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (264, 0, 283);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (265, 0, 162);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (267, 0, 270);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (268, 0, 189);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (269, 0, 269);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (270, 0, 55);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (271, 0, 42);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (272, 237, 95);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (273, 0, 249);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (275, 0, 159);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (277, 377, 29);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (278, 0, 290);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (279, 0, 291);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (280, 0, 307);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (281, 0, 285);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (282, 0, 249);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (284, 0, 129);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (285, 0, 114);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (286, 0, 174);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (288, 0, 37);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (289, 0, 25);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (293, 0, 266);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (294, 0, 90);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (295, 0, 76);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (296, 0, 179);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (297, 0, 60);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (298, 0, 306);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (300, 0, 171);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (301, 0, 179);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (302, 0, 62);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (303, 0, 65);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (305, 0, 41);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (306, 0, 211);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (307, 0, 73);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (308, 0, 10);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (309, 0, 121);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (310, 370, 177);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (311, 0, 201);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (312, 0, 264);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (313, 0, 107);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (314, 0, 248);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (315, 0, 48);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (318, 0, 211);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (320, 0, 267);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (321, 0, 308);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (322, 0, 297);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (323, 0, 201);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (324, 0, 286);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (325, 517, 179);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (326, 0, 58);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (327, 0, 202);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (328, 0, 53);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (329, 0, 30);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (330, 0, 367);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (331, 0, 400);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (332, 0, 176);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (333, 0, 123);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (334, 0, 147);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (335, 0, 158);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (336, 0, 142);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (337, 0, 220);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (338, 0, 217);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (339, 0, 380);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (340, 0, 234);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (341, 0, 202);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (342, 0, 274);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (343, 0, 96);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (344, 0, 173);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (345, 0, 13);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (346, 0, 185);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (347, 0, 369);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (348, 0, 71);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (349, 0, 129);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (350, 0, 23);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (351, 0, 325);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (352, 0, 132);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (354, 0, 9);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (355, 0, 113);
commit;
prompt 300 records committed...
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (357, 0, 337);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (358, 0, 394);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (359, 0, 383);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (361, 150, 23);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (362, 0, 56);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (364, 0, 337);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (365, 0, 212);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (366, 0, 226);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (367, 0, 65);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (368, 0, 61);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (370, 0, 143);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (371, 0, 385);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (372, 0, 77);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (373, 0, 310);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (374, 0, 222);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (375, 0, 45);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (376, 0, 355);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (377, 0, 205);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (378, 237, 364);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (379, 0, 18);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (380, 0, 268);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (381, 0, 189);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (382, 0, 175);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (383, 0, 100);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (384, 0, 80);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (385, 0, 88);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (386, 0, 318);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (388, 0, 361);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (389, 0, 229);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (390, 0, 191);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (391, 0, 141);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (392, 0, 125);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (394, 0, 326);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (395, 0, 31);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (396, 0, 91);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (397, 0, 259);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (398, 0, 317);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (399, 0, 32);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (400, 0, 274);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (401, 0, 145);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (402, 0, 266);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (403, 0, 296);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (404, 0, 299);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (405, 0, 183);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (406, 0, 164);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (407, 0, 216);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (408, 0, 35);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (409, 0, 183);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (410, 100, 389);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (411, 0, 327);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (412, 0, 162);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (413, 0, 202);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (414, 0, 133);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (415, 0, 344);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (416, 0, 258);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (417, 0, 336);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (420, 0, 13);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (421, 0, 242);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (423, 0, 294);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (424, 0, 367);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (426, 0, 231);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (427, 0, 376);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (428, 0, 170);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (429, 0, 178);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (430, 0, 134);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (431, 237, 1);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (434, 0, 165);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (435, 0, 19);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (436, 0, 159);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (437, 0, 58);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (439, 0, 79);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (440, 0, 132);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (441, 0, 347);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (442, 0, 363);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (444, 0, 337);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (445, 0, 330);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (447, 0, 49);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (448, 0, 113);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (449, 0, 25);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (451, 0, 12);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (455, 0, 160);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (458, 0, 125);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (459, 0, 217);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (460, 0, 212);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (462, 0, 293);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (463, 0, 17);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (464, 0, 71);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (465, 0, 228);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (466, 0, 320);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (467, 0, 361);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (468, 150, 217);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (469, 0, 274);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (470, 0, 289);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (471, 0, 4);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (472, 0, 71);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (473, 0, 398);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (475, 0, 354);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (477, 0, 36);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (478, 0, 231);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (479, 0, 312);
commit;
prompt 400 records committed...
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (480, 0, 393);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (482, 0, 204);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (483, 0, 22);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (484, 0, 95);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (485, 0, 283);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (486, 0, 348);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (488, 0, 324);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (489, 0, 330);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (490, 0, 60);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (491, 0, 135);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (494, 0, 312);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (495, 0, 224);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (496, 0, 350);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (497, 0, 79);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (498, 0, 107);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (499, 0, 229);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (500, 0, 333);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (501, 0, 68);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (502, 0, 55);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (504, 0, 173);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (506, 0, 272);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (507, 0, 35);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (508, 0, 370);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (509, 0, 83);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (510, 0, 203);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (600, 0, 1);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (601, 100, 2);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (602, 0, 3);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (603, 0, 4);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (604, 0, 5);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (605, 0, 6);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (606, 0, 7);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (607, 0, 8);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (608, 0, 9);
insert into WTEACHER (teacher_id, teacher_salary, teacher_addr)
values (609, 0, 10);
commit;
prompt 435 records loaded
prompt Loading SCHEDULER...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 5, 5, 5, 7, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 190, 156, 5, 1, 310);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 269, 206, 2, 2, 431);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 321, 498, 2, 7, 272);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1695, 284, 10, 472, 609);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1697, 23, 3, 345, 219);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1698, 157, 5, 365, 483);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1701, 338, 6, 87, 364);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 1702, 494, 1, 268, 412);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1707, 144, 1, 478, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1709, 416, 4, 5, 171);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 1710, 341, 13, 57, 380);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1711, 26, 13, 474, 87);
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
values (6, 1, 1718, 335, 6, 8, 248);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 1, 1720, 157, 6, 108, 372);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 5, 1721, 26, 2, 286, 471);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 3, 1728, 450, 10, 447, 507);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1730, 163, 6, 158, 378);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1732, 45, 4, 381, 69);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1737, 169, 10, 3, 495);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 6, 1742, 301, 6, 369, 43);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1745, 48, 7, 6, 84);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1052, 169, 2, 10, 378);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 5, 1746, 461, 3, 289, 400);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1748, 453, 2, 13, 124);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 1749, 66, 10, 150, 494);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1750, 102, 4, 283, 270);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 1753, 305, 7, 154, 471);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1755, 484, 10, 387, 281);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1758, 324, 10, 11, 71);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1761, 142, 1, 374, 334);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 1, 1762, 499, 10, 251, 298);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1767, 327, 5, 228, 114);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 6, 1769, 310, 1, 382, 373);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 6, 1770, 242, 7, 167, 218);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 6, 1773, 222, 7, 262, 174);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 2, 1774, 203, 3, 122, 482);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1776, 160, 4, 14, 12);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1778, 336, 3, 12, 298);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1781, 449, 13, 20, 337);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 3, 1783, 64, 4, 21, 130);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 1, 1785, 319, 4, 284, 407);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 1786, 221, 4, 221, 336);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 5, 1797, 188, 5, 226, 320);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1803, 70, 5, 15, 242);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1805, 431, 4, 17, 285);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 4, 1808, 67, 11, 306, 298);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 6, 1810, 264, 4, 13, 195);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1813, 277, 14, 258, 344);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1814, 359, 7, 20, 142);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1815, 7, 1, 21, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1817, 173, 5, 269, 302);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 1821, 500, 1, 220, 241);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1822, 169, 10, 140, 384);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 1, 1830, 475, 6, 147, 123);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1836, 67, 2, 71, 271);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 5, 1837, 47, 4, 380, 267);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1838, 15, 7, 30, 232);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1841, 426, 4, 23, 311);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 6, 1842, 149, 6, 267, 215);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 6, 1844, 500, 12, 390, 407);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 6, 1845, 14, 7, 442, 428);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1847, 201, 7, 22, 129);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 1849, 96, 2, 339, 259);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 4, 1851, 346, 3, 440, 209);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1852, 268, 1, 84, 430);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 1, 1853, 457, 6, 506, 44);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1854, 340, 10, 495, 407);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 1859, 422, 13, 269, 44);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1866, 411, 3, 18, 609);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 1870, 79, 7, 14, 248);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1872, 213, 10, 25, 63);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1875, 201, 6, 198, 236);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1877, 247, 5, 1, 124);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 3, 1878, 341, 6, 474, 448);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 1879, 53, 10, 41, 101);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 1880, 59, 4, 11, 227);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1881, 442, 1, 27, 35);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1882, 460, 10, 28, 104);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 6, 1885, 452, 10, 227, 59);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1887, 357, 2, 419, 449);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 1888, 169, 6, 293, 435);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 3, 1897, 387, 6, 278, 86);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 1906, 36, 5, 253, 95);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 1907, 111, 6, 474, 242);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 5, 1908, 283, 4, 461, 315);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1912, 45, 3, 9, 480);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1914, 463, 14, 441, 219);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 6, 1916, 355, 4, 363, 367);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 3, 1925, 154, 6, 408, 65);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1926, 481, 4, 2, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1450, 483, 4, 29, 324);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 1452, 292, 4, 91, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 1454, 263, 12, 77, 297);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 1456, 375, 4, 394, 489);
commit;
prompt 100 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 2, 1460, 415, 5, 285, 118);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1463, 440, 2, 30, 415);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1466, 321, 5, 42, 252);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1467, 241, 10, 110, 265);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1468, 451, 3, 169, 43);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 6, 1472, 377, 2, 212, 368);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 2, 1475, 188, 2, 170, 498);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1476, 65, 13, 128, 376);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 1479, 378, 13, 388, 486);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 1481, 203, 6, 7, 101);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1483, 475, 3, 310, 265);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1488, 85, 12, 24, 410);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1493, 20, 5, 32, 90);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1494, 301, 7, 134, 388);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 1495, 85, 5, 247, 496);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 1498, 236, 4, 17, 62);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1499, 466, 5, 373, 171);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1500, 491, 1, 48, 312);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1504, 103, 2, 205, 201);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1505, 46, 10, 34, 156);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 6, 1507, 199, 6, 305, 53);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1511, 393, 5, 38, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 5, 1512, 489, 2, 51, 390);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1513, 179, 2, 263, 344);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 4, 1515, 143, 1, 145, 60);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 6, 1519, 115, 1, 56, 236);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 2, 1526, 321, 2, 462, 58);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 6, 1528, 145, 10, 489, 397);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1529, 193, 2, 41, 296);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1532, 218, 7, 273, 107);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 6, 1533, 369, 10, 443, 96);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 1541, 129, 1, 461, 231);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 6, 1545, 157, 6, 255, 483);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1548, 126, 2, 493, 406);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 1549, 5, 8, 190, 349);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1550, 289, 1, 20, 431);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1552, 377, 1, 42, 204);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1554, 107, 2, 39, 335);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 4, 1556, 251, 13, 167, 63);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 6, 1561, 249, 6, 148, 61);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 5, 1563, 199, 1, 205, 401);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1564, 491, 13, 35, 212);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1565, 257, 10, 23, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1568, 96, 5, 40, 301);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 6, 1572, 250, 10, 203, 430);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 1577, 31, 3, 317, 123);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 1579, 67, 11, 256, 379);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 2, 1582, 347, 12, 504, 128);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 1588, 157, 7, 275, 69);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1589, 176, 10, 494, 187);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1591, 172, 13, 354, 495);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1592, 382, 7, 407, 183);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 1593, 445, 1, 473, 44);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 4, 1595, 384, 12, 203, 306);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 5, 1596, 292, 5, 142, 484);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1599, 349, 2, 89, 212);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 1601, 149, 5, 304, 345);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1608, 254, 1, 36, 166);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 5, 1609, 319, 10, 399, 73);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 1, 1615, 428, 7, 266, 174);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1619, 416, 10, 397, 502);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1623, 36, 3, 163, 441);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1628, 230, 10, 42, 374);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 1636, 309, 4, 100, 495);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 1, 1639, 95, 10, 334, 232);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 2, 1641, 163, 4, 71, 201);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 1643, 324, 3, 128, 391);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1644, 279, 6, 141, 63);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 1, 1645, 341, 13, 263, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1646, 420, 4, 43, 275);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 4, 1647, 5, 9, 393, 426);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 1, 1648, 163, 6, 238, 462);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1655, 356, 5, 44, 186);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 3, 1659, 272, 2, 345, 102);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1660, 37, 6, 368, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 4, 1661, 1, 7, 162, 77);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 2, 1663, 61, 4, 17, 227);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1665, 140, 1, 113, 118);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1667, 109, 10, 181, 347);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1670, 255, 4, 46, 320);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 3, 1675, 127, 2, 13, 162);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 5, 1677, 256, 6, 495, 467);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 6, 1678, 166, 4, 275, 127);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 1679, 96, 12, 229, 402);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1680, 38, 2, 64, 58);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 5, 1685, 298, 5, 462, 423);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 1436, 367, 7, 305, 229);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1439, 336, 12, 36, 448);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 3, 1446, 375, 13, 47, 334);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 4, 1447, 195, 8, 237, 431);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1448, 53, 1, 497, 508);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1200, 474, 1, 223, 465);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 4, 1203, 349, 12, 13, 172);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 1, 1210, 180, 4, 2, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1211, 191, 6, 261, 441);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 1212, 195, 4, 308, 490);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 1214, 134, 13, 288, 206);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 1215, 349, 13, 282, 260);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 6, 1217, 53, 6, 507, 414);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1218, 241, 1, 51, 124);
commit;
prompt 200 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1220, 385, 4, 102, 129);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 1222, 173, 10, 298, 483);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1224, 308, 10, 47, 608);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 6, 1228, 126, 11, 99, 224);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 1230, 266, 2, 167, 218);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1231, 367, 4, 48, 73);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1237, 461, 12, 495, 218);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 4, 1238, 441, 2, 89, 195);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 2, 1241, 25, 3, 454, 350);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1242, 46, 2, 50, 203);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 6, 1243, 324, 6, 346, 207);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 3, 1246, 174, 4, 504, 366);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 5, 1247, 142, 7, 404, 181);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 4, 1248, 85, 2, 435, 167);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 4, 1253, 365, 6, 160, 496);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 4, 1256, 423, 12, 278, 364);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 6, 1258, 416, 12, 92, 213);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1262, 407, 5, 58, 269);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 1268, 377, 10, 31, 212);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 5, 1274, 67, 13, 260, 254);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1278, 211, 7, 357, 601);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1280, 416, 6, 51, 108);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 5, 1285, 195, 12, 340, 391);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1288, 396, 3, 57, 376);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 2, 1289, 144, 3, 40, 384);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1293, 372, 4, 65, 413);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 1294, 26, 11, 259, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1296, 1, 6, 67, 76);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 6, 1297, 90, 6, 19, 178);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1298, 67, 11, 338, 286);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 6, 1305, 174, 5, 189, 490);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 5, 1306, 344, 7, 300, 153);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1313, 205, 12, 26, 8);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1317, 423, 3, 3, 212);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 3, 1321, 358, 2, 203, 11);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 3, 1327, 331, 13, 454, 131);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1328, 314, 4, 160, 143);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 1332, 331, 11, 59, 302);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 1334, 280, 6, 408, 601);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 6, 1336, 26, 4, 507, 57);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 5, 1338, 102, 4, 451, 54);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1346, 231, 10, 67, 133);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 2, 1349, 52, 6, 281, 275);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 1352, 162, 6, 144, 392);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 1, 1353, 341, 3, 270, 385);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 1356, 299, 13, 54, 480);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1359, 86, 2, 71, 412);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 1361, 58, 10, 416, 253);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 6, 1362, 96, 6, 328, 186);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 4, 1364, 105, 6, 110, 380);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 3, 1367, 267, 6, 487, 323);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 1370, 191, 10, 460, 216);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1371, 201, 2, 5, 374);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1374, 340, 1, 86, 358);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 1, 1375, 216, 4, 495, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1376, 179, 7, 52, 191);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1378, 74, 4, 223, 405);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 6, 1379, 195, 5, 178, 91);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 1382, 289, 1, 279, 44);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 1383, 157, 4, 486, 128);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1386, 73, 10, 319, 224);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 1387, 463, 7, 16, 53);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 1388, 445, 1, 482, 78);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 3, 1393, 188, 7, 131, 394);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 2, 1398, 385, 2, 41, 53);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 4, 1399, 229, 2, 451, 43);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 1, 1404, 129, 12, 254, 370);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 1, 1405, 226, 4, 241, 293);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1415, 271, 7, 7, 310);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 3, 1416, 342, 13, 179, 345);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1417, 313, 2, 68, 441);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 1, 1419, 411, 2, 140, 246);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 5, 1421, 263, 6, 410, 345);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 1422, 211, 13, 68, 497);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 6, 1427, 241, 10, 167, 156);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1428, 8, 4, 73, 399);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 1, 1430, 105, 10, 484, 382);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 5, 1928, 451, 10, 309, 390);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1930, 58, 5, 53, 127);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 1933, 23, 2, 453, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 1936, 242, 3, 161, 430);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1940, 463, 1, 324, 226);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 1, 1941, 182, 10, 376, 226);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 3, 1942, 410, 12, 440, 49);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 2, 1944, 299, 4, 201, 218);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 1948, 309, 1, 242, 306);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1949, 161, 4, 56, 130);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 1, 1950, 142, 1, 120, 338);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 3, 1951, 211, 12, 266, 366);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 1956, 410, 6, 277, 403);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1959, 359, 6, 75, 54);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 1960, 335, 2, 86, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1964, 265, 5, 78, 197);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1967, 282, 1, 54, 338);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 6, 1972, 177, 1, 120, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 1975, 23, 5, 313, 338);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1976, 499, 4, 76, 277);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1977, 431, 4, 82, 200);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 1982, 178, 3, 166, 293);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 3, 1983, 224, 10, 437, 484);
commit;
prompt 300 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1986, 395, 1, 57, 507);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 1987, 216, 2, 84, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 1, 1989, 308, 4, 454, 50);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 1993, 494, 13, 116, 132);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 1995, 375, 1, 6, 200);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 2003, 390, 2, 86, 421);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 2005, 289, 2, 235, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 2007, 96, 6, 431, 40);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2010, 99, 7, 61, 421);
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
values (13, 4, 2021, 471, 12, 241, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 5, 2023, 14, 12, 384, 420);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 5, 2024, 90, 11, 441, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 5, 2025, 474, 7, 250, 226);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 2027, 123, 7, 480, 398);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 3, 2031, 406, 12, 498, 264);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 2, 2033, 479, 6, 301, 220);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 2035, 143, 10, 151, 135);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 4, 2038, 489, 1, 94, 379);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2039, 247, 5, 62, 416);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 2, 2040, 74, 4, 418, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 4, 2041, 152, 4, 338, 313);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 6, 2044, 10, 3, 399, 126);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 4, 2045, 439, 4, 482, 294);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 1, 2048, 258, 2, 349, 469);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 5, 2052, 25, 5, 487, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2053, 352, 6, 80, 464);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 2, 2054, 390, 7, 470, 47);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 2, 2059, 142, 13, 88, 154);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 2067, 27, 2, 167, 325);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 2070, 266, 4, 19, 402);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 1, 2071, 134, 12, 318, 270);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2072, 431, 2, 88, 373);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 2, 2074, 218, 12, 316, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 4, 2075, 306, 2, 123, 416);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 3, 2076, 253, 2, 356, 273);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 2, 2079, 266, 11, 260, 184);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2080, 235, 5, 90, 81);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (7, 1, 2082, 316, 2, 13, 462);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 2086, 378, 10, 388, 296);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2089, 415, 12, 70, 473);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2090, 253, 6, 74, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 2092, 270, 10, 144, 603);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 2094, 37, 7, 267, 219);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (12, 2, 2095, 142, 5, 116, 331);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2106, 268, 1, 79, 180);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 2107, 277, 12, 56, 314);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2109, 290, 4, 91, 158);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 2111, 79, 4, 137, 374);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2114, 349, 6, 60, 109);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 4, 2115, 423, 1, 258, 229);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 2, 2117, 493, 13, 333, 126);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 1, 2118, 199, 13, 269, 200);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 1, 2121, 332, 2, 227, 359);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (16, 1, 2123, 65, 7, 237, 470);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (9, 5, 2128, 386, 13, 156, 188);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (14, 3, 2131, 386, 7, 494, 174);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (18, 1, 2139, 346, 5, 359, 338);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 2, 2140, 230, 2, 15, 294);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 2, 2143, 6, 4, 383, 498);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 1, 2150, 336, 13, 187, 158);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (15, 5, 2155, 318, 1, 487, 62);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (6, 1, 2159, 11, 12, 66, 471);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (8, 2, 2164, 31, 10, 395, 431);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 4, 2165, 154, 5, 230, 241);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 3, 2167, 171, 1, 175, 602);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (21, 3, 2171, 61, 2, 250, 144);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (10, 5, 2172, 476, 5, 41, 254);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (22, 4, 2173, 246, 10, 186, 504);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 5, 2175, 109, 7, 105, 145);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (13, 2, 2177, 120, 6, 482, 8);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 5, 2178, 120, 1, 89, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 2181, 439, 12, 15, 497);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (24, 3, 2183, 53, 7, 95, 138);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 4, 2188, 174, 5, 475, 203);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (23, 1, 2189, 308, 6, 300, 442);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (19, 3, 2190, 367, 10, 347, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (11, 4, 2192, 204, 5, 87, 84);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (20, 3, 2195, 111, 10, 162, 61);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id)
values (17, 4, 2196, 36, 4, 35, 394);
commit;
prompt 384 records loaded
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
prompt Enabling foreign key constraints for SCHTEACHER...
alter table SCHTEACHER enable constraint SYS_C008549;
prompt Enabling foreign key constraints for CLASS_...
alter table CLASS_ enable constraint SYS_C008556;
alter table CLASS_ enable constraint SYS_C008557;
prompt Enabling foreign key constraints for CLIENTS...
alter table CLIENTS enable constraint SYS_C008561;
alter table CLIENTS enable constraint SYS_C008562;
prompt Enabling foreign key constraints for GROUPS_...
alter table GROUPS_ enable constraint SYS_C008565;
prompt Enabling foreign key constraints for LESSON...
alter table LESSON enable constraint SYS_C008577;
alter table LESSON enable constraint SYS_C008578;
alter table LESSON enable constraint SYS_C008579;
prompt Enabling foreign key constraints for PARTICIPATE...
alter table PARTICIPATE enable constraint SYS_C008584;
alter table PARTICIPATE enable constraint SYS_C008585;
prompt Enabling foreign key constraints for WTEACHER...
alter table WTEACHER enable constraint SYS_C008590;
alter table WTEACHER enable constraint SYS_C008591;
prompt Enabling foreign key constraints for SCHEDULER...
alter table SCHEDULER enable constraint SYS_C008595;
alter table SCHEDULER enable constraint SYS_C008596;
alter table SCHEDULER enable constraint SYS_C008597;
alter table SCHEDULER enable constraint SYS_C008598;
prompt Enabling foreign key constraints for TEACH...
alter table TEACH enable constraint SYS_C008604;
alter table TEACH enable constraint SYS_C008605;
prompt Enabling triggers for AGE_GROUP...
alter table AGE_GROUP enable all triggers;
prompt Enabling triggers for CITY...
alter table CITY enable all triggers;
prompt Enabling triggers for ROOMS...
alter table ROOMS enable all triggers;
prompt Enabling triggers for TEACHER...
alter table TEACHER enable all triggers;
prompt Enabling triggers for SCHTEACHER...
alter table SCHTEACHER enable all triggers;
prompt Enabling triggers for CLASS_...
alter table CLASS_ enable all triggers;
prompt Enabling triggers for CLIENTS...
alter table CLIENTS enable all triggers;
prompt Enabling triggers for GROUPS_...
alter table GROUPS_ enable all triggers;
prompt Enabling triggers for SUBJECT...
alter table SUBJECT enable all triggers;
prompt Enabling triggers for LESSON...
alter table LESSON enable all triggers;
prompt Enabling triggers for PARTICIPATE...
alter table PARTICIPATE enable all triggers;
prompt Enabling triggers for WORKSHOPS...
alter table WORKSHOPS enable all triggers;
prompt Enabling triggers for WTEACHER...
alter table WTEACHER enable all triggers;
prompt Enabling triggers for SCHEDULER...
alter table SCHEDULER enable all triggers;
prompt Enabling triggers for TEACH...
alter table TEACH enable all triggers;
set feedback on
set define on
prompt Done.
