CREATE DATABASE csgo_database;
USE csgo_database;

CREATE table PLAYERS(
	p_first_name NATIONAL VARCHAR(30) NOT NULL,
    p_ingame_name VARCHAR(20) NOT NULL,
    p_second_name NATIONAL VARCHAR(30) NOT NULL,
    p_id INT NOT NULL PRIMARY KEY,
    p_nationality VARCHAR(20) NOT NULL,
    p_age INT NOT NULL,
    p_team_id INT,
    p_total_winnings INT
);
CREATE table TEAMS(
	t_name VARCHAR(20) NOT NULL,
    t_id INT NOT NULL PRIMARY KEY,
    t_nationality VARCHAR(20),
    t_year_established INT NOT NULL,
    t_hq_city VARCHAR(20),
    t_main_partner_id INT,
    t_coach_id INT,
    t_n_of_tournaments_won INT
);

CREATE table LEAGUES_HOST_COMPANIES(
	l_name VARCHAR(20) NOT NULL,
    l_y_established INT NOT NULL,
    l_id INT NOT NULL PRIMARY KEY,
    l_num_of_employees INT NOT NULL,
    l_home_country VARCHAR(15)
);

CREATE table COACHES(
	c_first_name NATIONAL VARCHAR(30) NOT NULL,
    c_second_name NATIONAL VARCHAR(30)  NOT NULL,
    c_id INT NOT NULL PRIMARY KEY,
    c_years_of_exp INT NOT NULL,
    c_team_id INT,
    c_monthly_salary INT
);

CREATE table TOURNAMENTS(
	tour_name VARCHAR(50) NOT NULL,
    tour_date DATE NOT NULL,
    tour_host_company_id INT NOT NULL,
    tour_prize_pool INT NOT NULL,
    tour_type VARCHAR(10) NOT NULL CHECK(tour_type IN('Major','Minor','Regional')),
    tour_play_type VARCHAR(7) NOT NULL CHECK(tour_play_type IN('Online','Offline')),
    tour_bracket_type VARCHAR(30) NOT NULL CHECK(tour_bracket_type IN('Round Robin','Single Elimination','Swiss','Double Elimination')),
    CONSTRAINT PK_tour PRIMARY KEY(tour_name,tour_date)
);

CREATE table PARTNERS(
	part_name VARCHAR(35) NOT NULL,
    part_id INT NOT NULL PRIMARY KEY,
    part_industry VARCHAR(50) NOT NULL
);

CREATE table SECONDARY_PARTNERS_AND_TEAMS(
	pt_part_id INT NOT NULL,
    pt_team_id INT NOT NULL,
    pt_contract_sum INT NOT NULL,
    pt_start_date DATE NOT NULL,
    pt_expiration_date DATE NOT NULL,
    CONSTRAINT PK_pt PRIMARY KEY(pt_part_id,pt_team_id),
    CONSTRAINT FK_pt_part FOREIGN KEY(pt_part_id) REFERENCES PARTNERS(part_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_pt_team FOREIGN KEY(pt_team_id) REFERENCES TEAMS(t_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE table TEAMS_IN_TOURNAMENTS(
	tmt_team_id INT NOT NULL,
    tmt_tour_name VARCHAR(50) NOT NULL,
    tmt_tour_date DATE NOT NULL,
    CONSTRAINT PK_tmt PRIMARY KEY(tmt_team_id,tmt_tour_name,tmt_tour_date),
    CONSTRAINT FK_tmt_team FOREIGN KEY(tmt_team_id) REFERENCES TEAMS(t_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_tmt_tour FOREIGN KEY(tmt_tour_name,tmt_tour_date) REFERENCES TOURNAMENTS(tour_name,tour_date)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO LEAGUES_HOST_COMPANIES VALUES ('ESL', 2000, 1111, 211, 'Germany' );
INSERT INTO LEAGUES_HOST_COMPANIES VALUES ('ESEA', 2003, 1112, 54, NULL);
INSERT INTO LEAGUES_HOST_COMPANIES VALUES ('FACE_IT', 2012, 1113, 131, 'United Kingdom');
INSERT INTO LEAGUES_HOST_COMPANIES VALUES ('DreamHack', 1994, 1114, 263, 'Sweden');
INSERT INTO LEAGUES_HOST_COMPANIES VALUES ('StarLadder', 2012, 1115, 86, 'Ukraine');
INSERT INTO LEAGUES_HOST_COMPANIES VALUES ('RFRSH', 2016, 1116, 59, 'Denmark');

INSERT INTO TEAMS VALUES ('Astralis', 1, 'Danish', 2016, 'Copenhagen', 10000, 100000, 7);
INSERT INTO TEAMS VALUES ('Virtus Pro', 2, 'Polish', 2003, 'Moscow', 10001, 100001, 6);
INSERT INTO TEAMS VALUES ('SK Gaming', 3, 'German', 2010, 'Cologne', 10002, 100002, 7);
INSERT INTO TEAMS VALUES ('fnatic', 4, 'Swedish', 2004, 'London', 10003, 100003, 10);
INSERT INTO TEAMS VALUES ('Team Liquid', 5, 'American' , 2000, 'Santa Monica', 10004, 100004, 5);
INSERT INTO TEAMS VALUES ('Natus Vincere', 6, 'Ukrainian', 2009, 'Kyiv', 10005, 100005, 6);

INSERT INTO PARTNERS VALUES ('JACK & JONES', 10000, 'Clothing');
INSERT INTO PARTNERS VALUES ('Pari Match', 10001, 'Betting');
INSERT INTO PARTNERS VALUES ('Deutsche Telekom', 10002, 'Telecommunications');
INSERT INTO PARTNERS VALUES ('OnePlus', 10003, 'Consumer Electroncis');
INSERT INTO PARTNERS VALUES ('Monster Beverage Corporation', 10004, 'Energy Drinks');
INSERT INTO PARTNERS VALUES ('GG.BET', 10005, 'Betting');
INSERT INTO PARTNERS VALUES ('Intel', 10006, 'Semiconductors');
INSERT INTO PARTNERS VALUES ('MSI', 10007, 'Computer hardware and electronics');
INSERT INTO PARTNERS VALUES ('Alienware', 10008, 'Computer hardware');
INSERT INTO PARTNERS VALUES ('Omen by HP', 10009, 'Computer hardware and software');

INSERT INTO COACHES VALUES ('Danny', 'Sørensen', 100000, 3, 1, 22000);
INSERT INTO COACHES VALUES ('Jakub', 'Gurczyński', 100001, 5, 2, 24000);
INSERT INTO COACHES VALUES ('Wilton', 'Prado', 100002, 3, 3, 7000);
INSERT INTO COACHES VALUES ('Andreas', 'Samuelsson', 100003, 0, 4, 23000);
INSERT INTO COACHES VALUES ('Eric', 'Hoag', 100004, 1, 5, 20000);
INSERT INTO COACHES VALUES ('Andrey', 'Gorodenskiy', 100005, 5, 6, 9000); 

INSERT INTO TOURNAMENTS VALUES ('Intel Extreme Masters XIII - Katowice Major 2019', '2019-02-13', 1111, 1000000, 'Major', 'Offline', 'Swiss');
INSERT INTO TOURNAMENTS VALUES ('StarSeries & i-League CS:GO Season 7', '2019-03-30', 1115, 500000, 'Minor', 'Offline', 'Swiss');
INSERT INTO TOURNAMENTS VALUES ('DreamHack Masters Dallas 2019', '2019-05-28', 1114, 250000, 'Minor', 'Offline', 'Double Elimination');
INSERT INTO TOURNAMENTS VALUES ('Esports Championship Series Season 7 - Finals', '2019-06-06', 1113, 500000, 'Minor', 'Offline', 'Double Elimination');
INSERT INTO TOURNAMENTS VALUES ('ESL One: Cologne 2019', '2019-07-02', 1111, 300000, 'Minor', 'Offline', 'Single Elimination');
INSERT INTO TOURNAMENTS VALUES ('StarLadder Berlin Major 2019', '2019-08-23', 1115, 1000000, 'Major', 'Offline', 'Swiss');
INSERT INTO TOURNAMENTS VALUES ('BLAST Pro Series: Global Final 2019', '2019-12-12', 1116, 500000, 'Minor', 'Offline', 'Double Elimination');
INSERT INTO TOURNAMENTS VALUES ('ESEA Season 32: Premier Division - Europe', '2019-09-09', 1112, 75000, 'Regional', 'Online', 'Round Robin');

INSERT INTO TEAMS_IN_TOURNAMENTS VALUES(1,'Intel Extreme Masters XIII - Katowice Major 2019', '2019-02-13');
INSERT INTO TEAMS_IN_TOURNAMENTS VALUES(4,'Intel Extreme Masters XIII - Katowice Major 2019', '2019-02-13');
INSERT INTO TEAMS_IN_TOURNAMENTS VALUES(6,'Intel Extreme Masters XIII - Katowice Major 2019', '2019-02-13');
INSERT INTO TEAMS_IN_TOURNAMENTS VALUES(4,'StarLadder Berlin Major 2019', '2019-08-23');
INSERT INTO TEAMS_IN_TOURNAMENTS VALUES(6,'StarLadder Berlin Major 2019', '2019-08-23');
INSERT INTO TEAMS_IN_TOURNAMENTS VALUES(2,'StarLadder Berlin Major 2019', '2019-08-23');
INSERT INTO TEAMS_IN_TOURNAMENTS VALUES(1,'Esports Championship Series Season 7 - Finals', '2019-06-06');
INSERT INTO TEAMS_IN_TOURNAMENTS VALUES(3,'Esports Championship Series Season 7 - Finals', '2019-06-06');
INSERT INTO TEAMS_IN_TOURNAMENTS VALUES(5,'DreamHack Masters Dallas 2019', '2019-05-28');
INSERT INTO TEAMS_IN_TOURNAMENTS VALUES(4,'DreamHack Masters Dallas 2019', '2019-05-28');

INSERT INTO SECONDARY_PARTNERS_AND_TEAMS VALUES(10006,1, 750000, '2019-01-21', '2020-01-21');
INSERT INTO SECONDARY_PARTNERS_AND_TEAMS VALUES(10006,4, 800000, '2019-05-11', '2020-05-11');
INSERT INTO SECONDARY_PARTNERS_AND_TEAMS VALUES(10006,6, 650000, '2019-03-05', '2020-03-05');
INSERT INTO SECONDARY_PARTNERS_AND_TEAMS VALUES(10007,1, 600000, '2019-07-12', '2020-07-12');
INSERT INTO SECONDARY_PARTNERS_AND_TEAMS VALUES(10007,4, 250000, '2019-02-02', '2020-02-02');
INSERT INTO SECONDARY_PARTNERS_AND_TEAMS VALUES(10008,5, 150000, '2019-09-23', '2020-09-23');
INSERT INTO SECONDARY_PARTNERS_AND_TEAMS VALUES(10008,3, 750000, '2019-01-29', '2020-01-29');
INSERT INTO SECONDARY_PARTNERS_AND_TEAMS VALUES(10009,2, 1000000, '2019-10-09', '2020-10-09');
INSERT INTO SECONDARY_PARTNERS_AND_TEAMS VALUES(10009,5, 450000, '2019-05-17', '2020-05-17');
INSERT INTO SECONDARY_PARTNERS_AND_TEAMS VALUES(10005,3, 770000, '2019-03-15', '2020-03-15');

INSERT INTO PLAYERS VALUES('Nicolai', 'dev1ce', 'Reedtz', 10, 'Danish', 24, 1, 1590501);
INSERT INTO PLAYERS VALUES('Peter', 'dupreeh', 'Rasmussen', 11, 'Danish', 26, 1, 1621123);
INSERT INTO PLAYERS VALUES('Andreas', 'Xyp9x', 'Højsleth', 12, 'Danish', 24, 1, 1624934);
INSERT INTO PLAYERS VALUES('Lukas', 'gla1ve', 'Rossander', 13, 'Danish', 24, 1, 1323552);
INSERT INTO PLAYERS VALUES('Emil', 'Magisk', 'Reif', 14, 'Danish', 21, 1, 1203818);
INSERT INTO PLAYERS VALUES('Janusz', 'Snax', 'Pogorzelski', 15, 'Polish', 26, 2, 637630);
INSERT INTO PLAYERS VALUES('Paweł', 'byali', 'Bieliński', 16, 'Polish', 25, 2, 570881);
INSERT INTO PLAYERS VALUES('Jarosław', 'pashaBiceps', 'Jarząbkowski', 17, 'Polish', 31, 2, 620576);
INSERT INTO PLAYERS VALUES('Filip', 'NEO', 'Kubski', 18, 'Polish', 32, 2, 743495);
INSERT INTO PLAYERS VALUES('Wiktor', 'TaZ', 'Wojtas', 19, 'Polish', 33, 2, 725958);
INSERT INTO PLAYERS VALUES('Gabriel', 'FalleN', 'Toledo', 20, 'Brazilian', 28, 3, 948740);
INSERT INTO PLAYERS VALUES('Fernando', 'fer', 'Alvarenga', 21, 'Brazilian', 28, 3, 935596);
INSERT INTO PLAYERS VALUES('Marcelo', 'coldzera', 'David', 22, 'Brazilian', 25, 3, 942699);
INSERT INTO PLAYERS VALUES('Ricardo', 'boltz', 'Prass', 23, 'Brazilian', 22, 3, 344150);
INSERT INTO PLAYERS VALUES('Freddy', 'KRIMZ', 'Johansson', 24, 'Swedish', 25, 4, 782580);
INSERT INTO PLAYERS VALUES('Jesper', 'JW', 'Wecksell', 25, 'Swedish', 24, 4, 812521);
INSERT INTO PLAYERS VALUES('Ludvig', 'Brollan', 'Brolin', 26, 'Swedish', 17, 4, 140437);
INSERT INTO PLAYERS VALUES('Robin', 'flusha', 'Rönnquist', 27, 'Swedish', 26, 4, 786441);
INSERT INTO PLAYERS VALUES('Richard', 'Xizt', 'Landström', 28, 'Swedish', 28, 4, 541198);
INSERT INTO PLAYERS VALUES('Nicholas', 'nitr0', 'Cannella', 29, 'United States', 24, 5, 838332);
INSERT INTO PLAYERS VALUES('Jonathan', 'EliGE', 'Jablonowski', 30, 'United States', 22, 5, 829482);
INSERT INTO PLAYERS VALUES('Russel', 'Twistzz', 'Van Dulken', 31, 'Canadian', 19, 5, 404272);
INSERT INTO PLAYERS VALUES('Keith', 'NAF', 'Markovic', 32, 'Canadian', 21, 5, 882649);
INSERT INTO PLAYERS VALUES('Jacky', '"Stewie2K', 'Yip', 33, 'United States', 21, 5, 979640);
INSERT INTO PLAYERS VALUES('Epitácio', 'TACO', 'de Melo', 34, 'Brazilian', 24, 3, 944996); 
INSERT INTO PLAYERS VALUES('Egor', 'flamie', 'Vasilev', 35, 'Russian', 22, 6, 610060);
INSERT INTO PLAYERS VALUES('Oleksandr', 's1mple', 'Kostyliev', 36, 'Ukrainian', 22, 6, 486886);
INSERT INTO PLAYERS VALUES('Ladislav', 'GuardiaN', 'Kovács', 37, 'Slovakian', 28, 6, 788607);
INSERT INTO PLAYERS VALUES('Danylo', 'Zeus', 'Teslenko', 38, 'Ukrainian', 32, 6, 785002);
INSERT INTO PLAYERS VALUES('Ioann', 'Edward', 'Sukhariev', 39, 'Ukrainian', 31, 6, 710977);

ALTER TABLE PLAYERS ADD CONSTRAINT FK_p_team FOREIGN KEY(p_team_id) REFERENCES TEAMS(t_id) 
    ON DELETE SET NULL
    ON UPDATE CASCADE;
ALTER TABLE TEAMS ADD CONSTRAINT FK_t_partner FOREIGN KEY(t_main_partner_id) REFERENCES PARTNERS(part_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;
ALTER TABLE TEAMS ADD CONSTRAINT FK_t_coach FOREIGN KEY(t_coach_id) REFERENCES COACHES(c_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;
ALTER TABLE COACHES ADD CONSTRAINT FK_c_team FOREIGN KEY(c_team_id) REFERENCES TEAMS(t_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;
ALTER TABLE TOURNAMENTS ADD CONSTRAINT FK_host_id FOREIGN KEY(tour_host_company_id) REFERENCES LEAGUES_HOST_COMPANIES(l_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE PLAYERS ADD CHECK(p_id>0);
ALTER TABLE TEAMS ADD CHECK(t_id>0);
ALTER TABLE LEAGUES_HOST_COMPANIES ADD CHECK(l_id>0);
ALTER TABLE COACHES ADD CHECK(c_id>0);
ALTER TABLE PARTNERS ADD CHECK(part_id>0);

CREATE VIEW Coach_View(f_name, nickname, s_name, id, nationality, age, team_id) AS SELECT p_first_name, p_ingame_name, p_second_name, p_id, p_nationality, p_age, p_team_id 
FROM PLAYERS WHERE 1 = p_team_id;

CREATE VIEW Host_view(team_name, team_id, team_nationality, team_year_established, t_main_partner_id,  team_coach_id, team_n_of_tournaments_won) AS 
SELECT DISTINCT t_name, t_id, t_nationality, t_year_established, t_main_partner_id, t_coach_id, t_n_of_tournaments_won
FROM TEAMS, TEAMS_IN_TOURNAMENTS, LEAGUES_HOST_COMPANIES, TOURNAMENTS
WHERE t_id = tmt_team_id AND tmt_tour_name IN (SELECT tour_name FROM TOURNAMENTS, LEAGUES_HOST_COMPANIES WHERE tour_host_company_id = 1115) 
AND tmt_tour_date IN (SELECT tour_date FROM TOURNAMENTS, LEAGUES_HOST_COMPANIES WHERE tour_host_company_id = 1115);

CREATE VIEW Analytics_view(total_winnings) AS
SELECT p_total_winnings FROM PLAYERS;

CREATE ROLE Coach;
CREATE ROLE Player;
CREATE ROLE Event_Organiser;
CREATE ROLE Analytics;

GRANT SELECT ON Coach_view TO Coach;
GRANT ALL ON Host_view TO Event_Organiser WITH GRANT OPTION;
GRANT SELECT ON PLAYERS TO Player;
GRANT SELECT ON TEAMS TO Player;
GRANT SELECT ON Analytics_view TO Analytics;

DELIMITER $$
CREATE TRIGGER Team_deletion_update_tournaments
AFTER DELETE ON TEAMS
FOR EACH ROW
BEGIN
DECLARE
	deleted_t_id int;
IF (OLD.t_id IS NOT NULL) THEN
	SET @deleted_t_id := OLD.t_id;
	DELETE FROM TEAMS_IN_TOURNAMENTS
	WHERE tmt_team_id=deleted_t_id;
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER Team_deletion_update_sponsors
AFTER DELETE ON TEAMS
FOR EACH ROW
BEGIN
DECLARE
	deleted_t_id int;
IF (OLD.t_id IS NOT NULL) THEN
	SET @deleted_t_id := OLD.t_id;
	DELETE FROM SECONDARY_PARTNERS_AND_TEAMS
	WHERE  pt_team_id=deleted_t_id;
END IF;
END$$
DELIMITER ;
