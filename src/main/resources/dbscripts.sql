CREATE SCHEMA REGISTRATION;

CREATE TABLE REGISTRATION.REGISTEREDUSER(
id bigint auto_increment primary key, 
username varchar(50),
firstname varchar(50),
lastname varchar(50),
password varchar(1064),
level double,
ROLE VARCHAR(40),
team_id BIGINT);

ALTER TABLE REGISTRATION.REGISTEREDUSER ADD teammasterdata_id BIGINT;
ALTER TABLE REGISTRATION.REGISTEREDUSER ADD FOREIGN KEY (teammasterdata_id) REFERENCES REGISTRATION.TEAMMASTERDATA(id);

ALTER TABLE REGISTRATION.REGISTEREDUSER ADD rsvp number(1,0) default 0;
ALTER TABLE REGISTRATION.REGISTEREDUSER ADD ninja number(1,0) default 0;

CREATE TABLE REGISTRATION.TEAM(
id bigint auto_increment primary key, 
teamname varchar(50) not null,
numberofgames int,
cumulativepoint int,
rank int);

ALTER TABLE REGISTRATION.REGISTEREDUSER ADD FOREIGN KEY (team_id) REFERENCES REGISTRATION.TEAM(id);

INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (1, 'Team 1');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (2, 'Team 2');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (3, 'Team 3');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (4, 'Team 4');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (5, 'Team 5');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (6, 'Team 6');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (7, 'Team 7');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (8, 'Team 8');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (9, 'Team 9');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (10, 'Team 10');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (11, 'Team 11');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (12, 'Team 12');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (13, 'Team 13');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (14, 'Team 14');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (15, 'Team 15');
INSERT INTO REGISTRATION.TEAM(ID, teamname) VALUES (16, 'Team 16');
COMMIT;

CREATE TABLE REGISTRATION.TEAMMASTERDATA(
id bigint auto_increment primary key, 
teamname varchar(50) not null);

INSERT INTO REGISTRATION.TEAMMASTERDATA(ID, teamname) VALUES (1, 'Development');
INSERT INTO REGISTRATION.TEAMMASTERDATA(ID, teamname) VALUES (2, 'Test');
INSERT INTO REGISTRATION.TEAMMASTERDATA(ID, teamname) VALUES (3, 'Support');
INSERT INTO REGISTRATION.TEAMMASTERDATA(ID, teamname) VALUES (4, 'Specification');
INSERT INTO REGISTRATION.TEAMMASTERDATA(ID, teamname) VALUES (5, 'Customer Service');
INSERT INTO REGISTRATION.TEAMMASTERDATA(ID, teamname) VALUES (6, 'HR');
INSERT INTO REGISTRATION.TEAMMASTERDATA(ID, teamname) VALUES (7, 'Business');
INSERT INTO REGISTRATION.TEAMMASTERDATA(ID, teamname) VALUES (8, 'Helpdesk');
COMMIT;