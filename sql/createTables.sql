CREATE TABLE Age_Group
(
  age_ID NUMERIC(5),
  minAge NUMERIC(5),
  maxAge NUMERIC(5),
  descript VARCHAR(15),
  PRIMARY KEY (age_ID)
);

CREATE TABLE City
(
  city_num NUMERIC(5),
  city_name VARCHAR(15),
  PRIMARY KEY (city_num),
  UNIQUE(city_name)
);

CREATE TABLE Clients
(
  client_ID NUMERIC(5),
  client_fname VARCHAR(15),
  client_lname VARCHAR(15),
  client_addr NUMERIC(5),
  client_TEL NUMERIC(5),
  client_payment NUMERIC(5),
  birthday DATE,
  PRIMARY KEY (client_ID),
  FOREIGN KEY (client_addr) REFERENCES City(city_num)
);

CREATE TABLE Workshops
(
  workshop_ID NUMERIC(5),
  workshop_name VARCHAR(15),
  workshop_price NUMERIC(5),
  workshop_hours NUMERIC(5),
  workshop_capacity NUMERIC(5),
  PRIMARY KEY (workshop_ID)
);

CREATE TABLE Teachers
(
  teacher_ID NUMERIC(5),
  teacher_fname VARCHAR(15),
  teacher_lname VARCHAR(15),
  teacher_addr NUMERIC(5),
  teacher_TEL NUMERIC(5),
  teacher_salary NUMERIC(5),
  teacher_join_date DATE,
  PRIMARY KEY (teacher_ID),
  FOREIGN KEY (teacher_addr) REFERENCES City(city_num)
);

CREATE TABLE Groups_
(
  group_ID NUMERIC(5),
  amount NUMERIC(5),
  age_ID NUMERIC(5),
  PRIMARY KEY (group_ID),
  FOREIGN KEY (age_ID) REFERENCES Age_Group(age_ID)
);

CREATE TABLE Rooms
(
  room_ID NUMERIC(5),
  room_floor NUMERIC(5),
  isStudio CHAR(1) CHECK (isStudio IN ('T', 'F')),
  room_capacity NUMERIC(5),
  PRIMARY KEY (room_ID)
);

CREATE TABLE Scheduler
(
  sc_time NUMERIC(5) CHECK (sc_time BETWEEN 6 AND 24),
  sc_day NUMERIC(5) CHECK (sc_day BETWEEN 1 AND 7),
  scheduler_ID NUMERIC(5),
  group_ID NUMERIC(5),
  workshop_ID NUMERIC(5),
  room_ID NUMERIC(5),
  teacher_ID NUMERIC(5),
  PRIMARY KEY (scheduler_ID),
  FOREIGN KEY (group_ID) REFERENCES Groups_(group_ID),
  FOREIGN KEY (workshop_ID) REFERENCES Workshops(workshop_ID),
  FOREIGN KEY (room_ID) REFERENCES Rooms(room_ID),
  FOREIGN KEY (teacher_ID) REFERENCES Teachers(teacher_ID),
  UNIQUE(sc_day, sc_time, room_ID),
  UNIQUE(sc_day, sc_time, teacher_ID)
);

CREATE TABLE Teach
(
  workshop_ID NUMERIC(5),
  teacher_ID NUMERIC(5),
  PRIMARY KEY (workshop_ID, teacher_ID),
  FOREIGN KEY (workshop_ID) REFERENCES Workshops(workshop_ID),
  FOREIGN KEY (teacher_ID) REFERENCES Teachers(teacher_ID)
);

CREATE TABLE Participate
(
  group_ID NUMERIC(5),
  client_ID NUMERIC(5),
  PRIMARY KEY (group_ID, client_ID),
  FOREIGN KEY (group_ID) REFERENCES Groups_(group_ID),
  FOREIGN KEY (client_ID) REFERENCES Clients(client_ID)
);

