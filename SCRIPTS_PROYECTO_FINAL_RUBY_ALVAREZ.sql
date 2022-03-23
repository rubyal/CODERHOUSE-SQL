
## LINK-->https://github.com/rubyal/CODERHOUSE-SQL.git<--
#****** EN EL PDF SE DETALLA LA DESCRIPCIÓN DE LAS VISTAS, FUNCIONES, STORED PROCEDURES Y TRIGGERS.*****#


### DESCRIPCIÓN DE TABLAS ###
	## LINK-->https://github.com/rubyal/CODERHOUSE-SQL.git<--
		##CODERHOUSE-SQL/Desafío_Descripcióndetablas_RUBY_ALVAREZ_R.sql##

create database juegosolimpicos;
use juegosolimpicos;

create table athlete(
id_athlete int primary key not null, 
name varchar (50), 
sex varchar (10), 
age int,
height int,
weight int);

select * from athlete;

create table sport(
id_sport int primary key,
sport varchar (20),
id_athlete int,
foreign key (id_athlete) references athlete(id_athlete));

select * from sport;

create table event(
id_event int primary key,
event varchar (20),
id_sport int,
id_athlete int,
foreign key (id_sport) references sport(id_sport),
foreign key (id_athlete) references athlete(id_athlete));

select * from event;

create table NOC(
id_noc int primary key, 
noc varchar (10),
team varchar (20),
id_athlete int,
foreign key (id_athlete) references athlete(id_athlete));

select * from NOC;

create table season(
id_season int primary key,
season varchar (10));

select * from season;

create table year(
id_year int primary key,
year int);

select * from year;

create table games(
id_games int primary key,
id_year int,
id_season int,
id_athlete int,
foreign key (id_year) references year(id_year),
foreign key (id_season) references season(id_season),
foreign key (id_athlete) references athlete(id_athlete));

select * from games;


create table city(
id_city int primary key,
city varchar (20),
id_athlete int,
foreign key (id_athlete) references athlete(id_athlete));

select * from city;

create table medal(
id_medal int primary key,
medal varchar (10),
id_athlete int,
foreign key (id_athlete) references athlete(id_athlete));

select * from medal;



### SCRIPT DE INSERCIÓN DE DATOS ###
	## LINK-->https://github.com/rubyal/CODERHOUSE-SQL.git<--
		## --> CODERHOUSE-SQL/Script_de_inserción_de_datos_RUBY_ALVAREZ.sql <-- ##
        
create database juegosolimpicos;
use juegosolimpicos;

create table athlete(
id_athlete int not null auto_increment, 
name varchar (70), 
sex varchar (2), 
age int,
height int,
weight float,
PRIMARY KEY(id_athlete));

select * from athlete;

insert into athlete(name, sex, age, height, weight) values('A Dijiang', 'M', 24, 180, 80);
insert into athlete(name, sex, age, height, weight) values('A Lamusi', 'M', 23, 170, 60);
insert into athlete(name, sex, age, height, weight) values('Gunnar Nielsen Aaby', 'M', 24, 176, 70);
insert into athlete(name, sex, age, height, weight) values('Edgar Lindenau Aabye', 'M', 34, 176, 70);
insert into athlete(name, sex, age, height, weight) values('Christine Jacoba Aaftink', 'F', 21, 185, 82);

select * from athlete;

create table sport(
id_sport int,
sport varchar (60),
PRIMARY KEY (id_sport));

select * from sport;

create table event(
id_event int,
event varchar (60),
PRIMARY KEY (id_event));

select * from event;

create table NOC(
id_noc int, 
noc varchar (5),
PRIMARY KEY (id_noc));

select * from NOC;

create table season(
id_season int,
season varchar (20),
PRIMARY KEY (id_season));

select * from season;

create table year(
id_year int,
year int,
PRIMARY KEY (id_year));

select * from year;

create table games(
id_games int,
id_year int,
id_season int,
PRIMARY KEY (id_games),
FOREIGN KEY(id_year) REFERENCES year(id_year),
FOREIGN KEY(id_season) REFERENCES season(id_season));

select * from games;

create table city(
id_city int,
city varchar (45),
PRIMARY KEY (id_city)
);

select * from city;

create table medal(
id_medal int,
medal varchar (10),
PRIMARY KEY (id_medal)
);

select * from medal;

create table hechosathlete(
id_hechos int not null,
id_athlete int not null, 
id_year int,
id_season int,
id_noc int,
id_games int,
id_city int,
id_sport int,
id_event int,
id_medal int,
PRIMARY KEY(id_hechos),
FOREIGN KEY(id_athlete) REFERENCES athlete(id_athlete),
FOREIGN KEY(id_year) REFERENCES year(id_year),
FOREIGN KEY(id_season) REFERENCES season(id_season),
FOREIGN KEY(id_noc) REFERENCES NOC(id_noc),
FOREIGN KEY(id_games) REFERENCES games(id_games),
FOREIGN KEY(id_city) REFERENCES city(id_city),
FOREIGN KEY(id_sport) REFERENCES sport(id_sport),
FOREIGN KEY(id_event) REFERENCES event(id_event),
FOREIGN KEY(id_medal) REFERENCES medal(id_medal));

select * from hechosathlete;


### PRESENTACIÓN DE SCRIPT DE CREACIÓN DE VISTAS ###
	## LINK-->https://github.com/rubyal/CODERHOUSE-SQL.git<--
		## --> CODERHOUSE-SQL/Desafío_Presentación_de_script_de_creación_de_vistas_RUBY_ALVAREZ.sql <-- ##
	

USE juegosolimpicos;

CREATE VIEW medaloro_athlete AS select a.name as name, h.id_medal AS medal_oro FROM hechosathlete h 
LEFT JOIN athlete a ON h.id_athlete = a.id_athlete WHERE id_medal = 2;

SELECT * FROM medaloro_athlete;


CREATE VIEW MEDALOROCOUNT_ATHLETE AS SELECT A.NAME, A.AGE, COUNT(H.ID_MEDAL) AS COUNT_MEDAL_ORO FROM ATHLETE A 
LEFT JOIN HECHOSATHLETE H ON A.ID_ATHLETE=H.ID_ATHLETE WHERE ID_MEDAL=2 
GROUP BY H.ID_ATHLETE ORDER BY ID_MEDAL DESC LIMIT 10;

SELECT * FROM MEDALOROCOUNT_ATHLETE;

CREATE VIEW MEDALBRONZE_ATHLETE AS SELECT A.NAME, A.AGE, H.ID_MEDAL AS MEDAL FROM ATHLETE A 
LEFT JOIN HECHOSATHLETE H ON A.ID_ATHLETE=H.ID_ATHLETE 
WHERE AGE >= 25 AND ID_MEDAL = 3 GROUP BY H.ID_ATHLETE ORDER BY ID_MEDAL DESC LIMIT 5;

SELECT * FROM MEDALBRONZE_ATHLETE;

CREATE VIEW CITYLONDON_ATHLETE AS SELECT A.NAME, S.SPORT, C.CITY, H.ID_MEDAL AS MEDAL, N.NOC FROM HECHOSATHLETE H 
LEFT JOIN ATHLETE A ON H.ID_ATHLETE=A.ID_ATHLETE 
LEFT JOIN SPORT S ON H.ID_SPORT= S.ID_SPORT
LEFT JOIN CITY C ON H.ID_CITY=C.ID_CITY
LEFT JOIN NOC N ON H.ID_NOC=N.ID_NOC
WHERE CITY LIKE 'LONDON'GROUP BY H.ID_ATHLETE LIMIT 3;

SELECT * FROM CITYLONDON_ATHLETE;

CREATE VIEW HOCKEY_ATHLETE AS SELECT A.NAME, S.SPORT, Y.YEAR, SE.SEASON, H.ID_MEDAL, M.MEDAL FROM HECHOSATHLETE H 
LEFT JOIN ATHLETE A ON H.ID_ATHLETE=A.ID_ATHLETE
LEFT JOIN  SEASON SE ON H.ID_SEASON=SE.ID_SEASON
LEFT JOIN YEAR Y ON H.ID_YEAR=Y.ID_YEAR
LEFT JOIN SPORT S ON H.ID_SPORT=S.ID_SPORT
LEFT JOIN MEDAL M ON H.ID_MEDAL=M.ID_MEDAL
WHERE SPORT LIKE 'HOCKEY';

SELECT * FROM HOCKEY_ATHLETE;

CREATE VIEW GAMESSUMMER_ATHLETE AS SELECT DISTINCT A.NAME, SE.SEASON, Y.YEAR FROM HECHOSATHLETE H 
LEFT JOIN ATHLETE A ON H.ID_ATHLETE=A.ID_ATHLETE
LEFT JOIN  SEASON SE ON H.ID_SEASON=SE.ID_SEASON
LEFT JOIN YEAR Y ON H.ID_YEAR=Y.ID_YEAR
WHERE SE.SEASON LIKE 'SUMMER' GROUP BY H.ID_ATHLETE ORDER BY YEAR;

SELECT * FROM GAMESSUMMER_ATHLETE;

### PRESENTAR EN FORMATO SQL ###
	## LINK-->https://github.com/rubyal/CODERHOUSE-SQL.git<--
			## --> CODERHOUSE-SQL/Desafío_Presentar_en_formato_SQL_RUBY_ALVAREZ.sql <-- ##
	
USE JUEGOSOLIMPICOS;


SELECT * FROM HECHOSATHLETE;
SELECT * FROM ATHLETE;
SELECT * FROM MEDAL;


DELIMITER #
CREATE FUNCTION GET_MEDAL_AHTLETE(PARAM_ATHLETE INT)
RETURNS CHAR(50)
READS SQL DATA
DETERMINISTIC
BEGIN 
	DECLARE MEDAL_ATHLETE CHAR(50);
    SELECT M.MEDAL INTO MEDAL_ATHLETE
    FROM MEDAL M
    WHERE ID_MEDAL=PARAM_ATHLETE;
RETURN MEDAL_ATHLETE;
END #
DELIMITER ;


DROP FUNCTION GET_MEDAL_AHTLETE;


SELECT H.ID_ATHLETE, GET_MEDAL_AHTLETE(ID_MEDAL) AS NAMEMEDAL FROM HECHOSATHLETE H;
SELECT H.ID_ATHLETE, H.ID_MEDAL, GET_MEDAL_AHTLETE(ID_MEDAL) AS NAMEMEDAL FROM HECHOSATHLETE H;




DELIMITER #
CREATE FUNCTION GET_MEDAL_AHTLETE1(PARAM_ATHLETE INT)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN 
	DECLARE MEDAL_ATHLETE INT;
    SELECT COUNT(ID_MEDAL) INTO MEDAL_ATHLETE
    FROM HECHOSATHLETE
    WHERE ID_MEDAL=PARAM_ATHLETE;
RETURN MEDAL_ATHLETE;
END #
DELIMITER ;

DROP FUNCTION GET_MEDAL_AHTLETE1;

SELECT GET_MEDAL_AHTLETE1(1) AS MEDAL_NA;
SELECT GET_MEDAL_AHTLETE1(2) AS MEDAL_GOLD;
SELECT GET_MEDAL_AHTLETE1(3) AS MEDAL_BRONZE;
SELECT GET_MEDAL_AHTLETE1(4) AS MEDAL_SILVER;


### SCRIPT DE CREACIÓN DE STORED PROCEDURES ###
## LINK-->https://github.com/rubyal/CODERHOUSE-SQL.git<--
			## --> CODERHOUSE-SQL/Desafío_Script_de_creación_de_stored_procedures_RUBY_ALVAREZz.sql <-- ##


DELIMITER ##
CREATE PROCEDURE ORDENAMIENTO_RANGO_EDAD1 (IN CANT_EDAD INT, IN CANT_EDAD2 INT, IN ORDEN BOOLEAN)
BEGIN 
	SET @CANTIDAD_AGE = (SELECT COUNT(*) FROM ATHLETE WHERE AGE BETWEEN CANT_EDAD AND CANT_EDAD2);
	IF@CANTIDAD_AGE <> ''  AND ORDEN = 1 THEN 
		SELECT * FROM ATHLETE WHERE AGE BETWEEN CANT_EDAD AND CANT_EDAD2 ORDER BY AGE ASC;
	ELSEIF @CANTIDAD_AGE <> ''  AND ORDEN = 0 THEN 
		SELECT * FROM ATHLETE WHERE AGE BETWEEN CANT_EDAD AND CANT_EDAD2 ORDER BY AGE DESC;
	ELSEIF @CANTIDAD_AGE <> '' AND orden NOT IN (0,1) THEN
		SET @ordenar = 'No válido';
		SELECT 'Parámetro de ordenamiento ingresado no válido' AS Mensaje;
	ELSEIF @CANTIDAD_AGE = 0 THEN
         SELECT 'NO EXISTE' AS MENSAJE;
		END IF;
    
END ##
DELIMITER ;

CALL ORDENAMIENTO_RANGO_EDAD1(20, 40, 1);
CALL ORDENAMIENTO_RANGO_EDAD1(20, 40, 0);
CALL ORDENAMIENTO_RANGO_EDAD1(1, 4, 0);
CALL ORDENAMIENTO_RANGO_EDAD1(22, 40, 5);


##DROP PROCEDURE IF EXISTS DELET_HECHO;
SELECT * FROM hechosathlete;

DELIMITER ##
CREATE PROCEDURE INSE_HECHO (IN PARAM_ID_HECHO INT, IN PARAM_ID_ATHLETE INT, IN PARAM_ID_YEAR INT, IN PARAM_ID_SEASON INT, IN PARAM_ID_NOC INT, IN PARAM_ID_GAMES INT, IN PARAM_ID_CITY INT, IN PARAM_ID_SPORT INT, IN PARAM_ID_EVENT INT, IN PARAM_ID_MEDAL INT)
BEGIN 
	 INSERT INTO HECHOSATHLETE(ID_HECHOS, ID_ATHLETE, ID_YEAR, ID_SEASON, ID_NOC, ID_GAMES, ID_CITY, ID_SPORT, ID_EVENT, ID_MEDAL) values(PARAM_ID_HECHO, PARAM_ID_ATHLETE, PARAM_ID_YEAR, PARAM_ID_SEASON, PARAM_ID_NOC, PARAM_ID_GAMES, PARAM_ID_CITY, PARAM_ID_SPORT, PARAM_ID_EVENT, PARAM_ID_MEDAL);
END ##
DELIMITER ;
CALL INSE_HECHO (100, 2, 32, 1, 1, 34, 1, 3, 1, 1);

SELECT * FROM hechosathlete;

DELIMITER ## 
CREATE PROCEDURE DELET_HECHO (IN PARAM_ID_REG INT)
BEGIN 
	DELETE FROM HECHOSATHLETE WHERE ID_HECHOS = PARAM_ID_REG;
END ##
DELIMITER ;

CALL DELET_HECHO (100);

SELECT * FROM hechosathlete;


### SCRIPT DE CREACIÓN DE TRIGGERS ###
	## LINK-->https://github.com/rubyal/CODERHOUSE-SQL.git<--
			## --> CODERHOUSE-SQL/Desafío_Script_de_creación_de_triggers_RUBY_ALVAREZz.sql <-- ##
            
            
USE juegosolimpicos;

SELECT * FROM hechosathlete;
DESCRIBE ATHLETE;


DROP TABLE IF EXISTS LOG_INSERCION_ATHLETE;
CREATE TABLE LOG_INSERCION_ATHLETE
(id_log INT PRIMARY KEY AUTO_INCREMENT,
id_athlete INT NOT NULL,
name varchar(70),
sex varchar(2),
age int, 
height int,
weight float,
usuario VARCHAR (60),
fecha_hora DATETIME
);



DROP TRIGGER IF EXISTS  LOG_INSERCION_ATHLETE;
CREATE TRIGGER LOG_INSERCION_ATHLETE
AFTER INSERT ON athlete 
FOR EACH ROW
INSERT INTO LOG_INSERCION_ATHLETE VALUES 
(DEFAULT, new.id_athlete, new.name, new.sex, new.age, new.height, new.weight, USER(), NOW());
SELECT * FROM LOG_INSERCION_ATHLETE;
INSERT INTO ATHLETE VALUES (DEFAULT, 'HOLA', 'M', 70, 180, 80);
SELECT * FROM LOG_INSERCION_ATHLETE;
SELECT * FROM ATHLETE;



DROP TABLE IF EXISTS LOG_MODIFICACION_ATHLETE;
CREATE TABLE LOG_MODIFICACION_ATHLETE_NAME(
id_log INT PRIMARY KEY AUTO_INCREMENT,
id_athlete INT NOT NULL,
viejo_name VARCHAR(70),
nuevo_name VARCHAR(70),
usuario VARCHAR (60),
fecha_hora DATETIME
);

DROP TRIGGER IF EXISTS  LOG_MODIFICACION_ATHLETE;
CREATE TRIGGER LOG_MODIFICACION_ATHLETE_NAME
AFTER UPDATE ON ATHLETE
FOR EACH ROW
INSERT INTO LOG_MODIFICACION_ATHLETE_NAME VALUES (DEFAULT, old.id_athlete, old.name, new.name, USER(), NOW());


SELECT * FROM LOG_MODIFICACION_ATHLETE_NAME;
UPDATE ATHLETE SET name='love' where id_athlete=101;
UPDATE ATHLETE SET name='love2'  where id_athlete=101;
SELECT * FROM LOG_MODIFICACION_ATHLETE_NAME;

DROP TABLE IF EXISTS LOG_DELETE_ATHLETE_NAME;
CREATE TABLE LOG_DELETE_ATHLETE_NAME(
id_log INT PRIMARY KEY AUTO_INCREMENT,
id_athlete INT NOT NULL,
name varchar(70),
sex varchar(2),
age int, 
height int,
weight float,
usuario VARCHAR (60),
fecha_hora DATETIME
);

DROP TRIGGER IF EXISTS LOG_DELETE_ATHLETE_NAME;
CREATE TRIGGER LOG_DELETE_ATHLETE_NAME
AFTER DELETE ON ATHLETE
FOR EACH ROW 
INSERT INTO LOG_DELETE_ATHLETE_NAME VALUES(DEFAULT, old.id_athlete, old.name, old.sex, old.age, old.height, old.weight, USER(), NOW());

SELECT * FROM LOG_DELETE_ATHLETE_NAME;
DELETE FROM ATHLETE WHERE ID_ATHLETE >= 101;
SELECT * FROM LOG_DELETE_ATHLETE_NAME;

SELECT * FROM ATHLETE;


SELECT * FROM HECHOSATHLETE;


DROP TABLE IF EXISTS LOG_INSERCION_HECHOSATHLETE;
CREATE TABLE LOG_INSERCION_HECHOSATHLETE
(id_log INT PRIMARY KEY AUTO_INCREMENT,
id_hechos INT NOT NULL,
id_athlete INT NOT NULL,
id_year INT,
id_season INT,
id_noc INT, 
id_games INT,
id_city INT,
id_sport INT,
id_event INT,
id_medal INT,
usuario VARCHAR (60),
fecha_hora DATETIME
);


DROP TRIGGER IF EXISTS  LOG_INSERCION_HECHOSATHLETE;
CREATE TRIGGER LOG_INSERCION_HECHOSATHLETE
AFTER INSERT ON hechosathlete 
FOR EACH ROW
INSERT INTO LOG_INSERCION_HECHOSATHLETE VALUES 
(DEFAULT, new.id_hechos, new.id_athlete, new.id_year, new.id_season, new.id_noc, new.id_games, new.id_city,  new.id_sport,  new.id_event,  new.id_medal, USER(), NOW());
SELECT * FROM LOG_INSERCION_HECHOSATHLETE;
INSERT INTO HECHOSATHLETE VALUES (102, 1, 1, 1, 1, 1, 1, 1, 1, 1);
SELECT * FROM LOG_INSERCION_HECHOSATHLETE;
SELECT * FROM HECHOSATHLETE;
DESCRIBE HECHOSATHLETE;

DROP TABLE IF EXISTS LOG_DELETE_ATHLETE;
CREATE TABLE LOG_DELETE_HECHOSATHLETE(
id_log INT PRIMARY KEY AUTO_INCREMENT,
id_hecho INT NOT NULL,
id_athlete INT NOT NULL,
id_year INT,
id_season INT,
id_noc INT, 
id_games INT,
id_city INT,
id_sport INT,
id_event INT,
id_medal INT,
usuario VARCHAR (60),
fecha_hora DATETIME
);


DROP TRIGGER IF EXISTS  LOG_DELETE_HECHOSATHLETE;
CREATE TRIGGER LOG_DELETE_HECHOSATHLETE
AFTER DELETE ON HECHOSATHLETE
FOR EACH ROW
INSERT INTO LOG_DELETE_HECHOSATHLETE VALUES 
(DEFAULT, old.id_hechos, old.id_athlete, old.id_year, old.id_season, old.id_noc, old.id_games, old.id_city, old.id_sport,  old.id_event,  old.id_medal, USER(), NOW());


SELECT * FROM LOG_DELETE_HECHOSATHLETE;
DELETE FROM HECHOSATHLETE WHERE ID_HECHOS >=102;
SELECT * FROM LOG_DELETE_HECHOSATHLETE;

SELECT * FROM HECHOSATHLETE;


### IMPLEMENTACIÓN DE SENTENCIAS DCL ###
	## LINK-->https://github.com/rubyal/CODERHOUSE-SQL.git<--
			## --> CODERHOUSE-SQL/Desafío_Implementación_de_sentencias_RUBY_ALVAREZ.sql <-- ##


use mysql;
show tables;
select * from user;

CREATE USER 'usuario_lectura'@'localhost' identified by '1234';
CREATE USER 'usuario_lim'@'localhost' identified by '9876';

#DROP USER 'usuario_lectura'@'localhost';
#DROP USER 'usuario_lim'@'localhost'
ALTER USER 'usuario_lectura'@'localhost' identified by '9876';

SHOW GRANTS FOR 'usuario_lectura'@'localhost';
SHOW GRANTS FOR 'usuario_lim'@'localhost';


GRANT SELECT ON juegosolimpicos.* TO 'usuario_lectura'@'localhost'; 

GRANT SELECT, INSERT, UPDATE ON juegosolimpicos.* TO 'usuario_lim'@'localhost';


### SENTENCIAS DEL SUBLENGUAJE TCL ###
	## LINK-->https://github.com/rubyal/CODERHOUSE-SQL.git<--
			## --> CODERHOUSE-SQL/Desafío_Sentencias_del _sublenguaje_TCL_RUBY_ALVAREZ.sql <-- ##
            
USE juegosolimpicos;


SELECT * FROM city;


START TRANSACTION;
INSERT INTO CITY VALUE(43, 'Colombia');
INSERT INTO CITY VALUE(44, 'Argentina');
INSERT INTO CITY VALUE(45, 'Mexico');
ROLLBACK;
COMMIT;


START TRANSACTION;
DELETE FROM CITY WHERE id_city=43;
DELETE FROM CITY WHERE id_city=44;
DELETE FROM CITY WHERE id_city=45;
ROLLBACK;
COMMIT;


SELECT * FROM athlete;
START TRANSACTION;
INSERT INTO athlete VALUES (DEFAULT, 'ana', 'F', 31, 160, 48);
INSERT INTO athlete VALUES (DEFAULT, 'pedro', 'M', 41, 190, 88);
INSERT INTO athlete VALUES (DEFAULT, 'sara', 'F', 21, 189, 68);
INSERT INTO athlete VALUES (DEFAULT, 'ana', 'F', 31, 160, 48);
SAVEPOINT INSERCION_1_4;
INSERT INTO athlete VALUES (DEFAULT, 'angie', 'F', 41, 190, 88);
INSERT INTO athlete VALUES (DEFAULT, 'natalia', 'F', 21, 189, 68);
INSERT INTO athlete VALUES (DEFAULT, 'leonardo', 'M', 41, 190, 88);
INSERT INTO athlete VALUES (DEFAULT, 'juliana', 'F', 21, 189, 68);
SAVEPOINT INSERCION_5_8;
##ROLLBACK;
-- RELEASE SAVEPOINT INSERCION_1_4;
##COMMIT;


### BACKUP DE LA BASE DE DATOS ###
	## LINK-->https://github.com/rubyal/CODERHOUSE-SQL.git<--
			## --> CODERHOUSE-SQL/Desafío_Backup_de_la_base_de_datos_RUBY_ALVAREZ.sql <-- ##
            
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: juegosolimpicos
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `athlete`
--

LOCK TABLES `athlete` WRITE;
/*!40000 ALTER TABLE `athlete` DISABLE KEYS */;
INSERT INTO `athlete` VALUES (1,'A Dijiang','M',24,180,80),(2,'A Lamusi','M',23,170,60),(3,'Gunnar Nielsen Aaby','M',24,176,70),(4,'Edgar Lindenau Aabye','M',34,176,70),(5,'Christine Jacoba Aaftink','F',21,185,82),(6,'Per Knut Aaland','M',31,188,75),(7,'John Aalberg','M',31,183,72),(8,'Cornelia \"Cor\"\" Aalten (-Strannood)\"','F',18,168,70),(9,'Antti Sami Aalto','M',26,186,96),(10,'Einar Ferdinand \"Einari\"\" Aalto\"','M',26,176,70),(11,'Jorma Ilmari Aalto','M',22,182,76.5),(12,'Jyri Tapani Aalto','M',31,172,70),(13,'Minna Maarit Aalto','F',30,159,55.5),(14,'Pirjo Hannele Aalto (Mattila-)','F',32,171,65),(15,'Arvo Ossian Aaltonen','M',22,176,70),(16,'Juhamatti Tapio Aaltonen','M',28,184,85),(17,'Paavo Johannes Aaltonen','M',28,175,64),(18,'Timo Antero Aaltonen','M',31,189,130),(19,'Win Valdemar Aaltonen','M',54,176,70),(20,'Kjetil Andr Aamodt','M',20,176,85),(21,'Ragnhild Margrethe Aamodt','F',27,163,70),(22,'Andreea Aanei','F',22,170,125),(23,'Fritz Aanes','M',22,187,89),(24,'Nils Egil Aaness','M',24,176,70),(25,'Alf Lied Aanning','M',24,176,70),(26,'Agnes Erika Aanonsen (-Eyde)','F',17,169,65),(27,'Johan Aantjes','M',26,176,70),(28,'Jan-Erik Aarberg','M',43,170,77),(29,'Willemien Aardenburg','F',22,176,70),(30,'Pepijn Aardewijn','M',26,189,72),(31,'Evald rma (rman-)','M',24,174,70),(32,'Olav Augunson Aarnes','M',23,176,70),(33,'Mika Lauri Aarnikka','M',24,187,76),(34,'Jamale (Djamel-) Aarrass (Ahrass-)','M',30,187,76),(35,'Dagfinn Sverre Aarskog','M',24,190,98),(36,'Stefan Remco Aartsen','M',21,194,78),(37,'Ann Kristin Aarnes','F',23,182,64),(38,'Karl Jan Aas','M',20,176,70),(39,'Lars Thorlaksn Aas','M',33,176,70),(40,'Roald Edgar Aas','M',23,176,70),(41,'Rolf Aas','M',28,176,70),(42,'Thomas Valentin Aas','M',25,176,70),(43,'Morten Gjerdrum Aasen','M',34,185,75),(44,'Meelis Aasme','M',25,182,73),(45,'Hakon Aasns','M',41,176,70),(46,'Hans Aasns','M',33,194,93),(47,'Erling Rudolf Aastad','M',22,177,74),(48,'Abdelhak Aatakni','M',24,176,64),(49,'Moonika Aava','F',24,168,65),(50,'Arvi Aavik','M',22,185,106),(51,'Nstor Abad Sanjun','M',23,167,64),(52,'Patrick Abada','M',22,189,80),(53,'Talaat Abada','M',24,172,58),(54,'Mohamed Jamshid Abadi','M',23,176,70),(55,'Antonio Abadia Beci','M',26,170,65),(56,'Ren Abadie','M',21,176,70),(57,'Borislav Abadzhiev','M',24,176,66),(58,'Georgi Abadzhiev','M',23,176,70),(59,'Ivan Nikolov Abadzhiev','M',24,164,71),(60,'Mikhail Abadzhiev','M',24,172,75),(61,'Stefan Abadzhiev','M',26,175,72),(62,'Giovanni Abagnale','M',21,198,90),(63,'Jos Luis Abajo Gmez','M',30,194,87),(64,'M\'Bairo Abakar','M',31,176,70),(65,'Patimat Abakarova','F',21,165,49),(66,'Mohamed Abakkar','M',23,156,48),(67,'Mariya Vasilyevna Abakumova (-Tarabina)','F',22,179,80),(68,'Pablo Martn Abal','M',23,178,76),(69,'Tamara Abalde Daz','F',19,185,72),(70,'Jess Iory Aball Martnez','M',26,167,65),(71,'Juan Antonio Aball Delgado','M',27,172,82),(72,'Aleksey Aleksandrovich Abalmasov','M',24,180,83),(73,'Luc Abalo','M',23,182,86),(74,'Mara Laura Abalo','F',30,182,73),(75,'Giorgos Abalof','M',22,178,70),(76,'Jouan Patrice Abanda Etong','M',22,185,82),(77,'Antoine Abang','M',27,166,75),(78,'Salim Abanoz','M',26,176,70),(79,'Carlos Abarca Gonzlez','M',23,176,70),(80,'Jos Mara Abarca Plotas','M',22,186,83),(81,'Georgios Abaris','M',22,190,77),(82,'Enrique Abaroa Martnez','M',26,183,75),(83,'Carlos Arturo Abarza Chavez','M',22,176,70),(84,'Stephen Anthony Abas','M',26,165,55),(85,'Alejandro Abascal Garca','M',24,181,82),(86,'Jos Manuel Abascal Gmez','M',22,182,67),(87,'Rost\'om Omeris dze Abashidze','M',29,188,97),(88,'Nunu Dzhansuhivna Abashydze (-Myslaieva)','F',25,168,105),(89,'Rodrigo Abasolo','M',21,176,70),(90,'Tamila Rashidovna Abasova','F',21,163,60),(91,'Emanuele Abate','M',27,190,80),(92,'Ignazio Abate','M',21,180,73),(93,'Jol Marc Abati','M',34,190,85),(94,'Ral Abatte','M',38,176,70),(95,'Georgia Abatzidou','F',35,155,43),(96,'Carlos Rodolfo Abaunza Balladares','M',18,168,60),(97,'Carlos Alberto Abaunza','M',16,180,70),(98,'Hctor Abaunza','M',30,169,75),(99,'Pter Abay','M',30,181,79),(100,'Oszkr Abay-Nemes','M',22,176,70);
/*!40000 ALTER TABLE `athlete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Barcelona'),(2,'London'),(3,'Antwerpen'),(4,'Paris'),(5,'Calgary'),(6,'Albertville'),(7,'Lillehammer'),(8,'Los Angeles'),(9,'Salt Lake City'),(10,'Helsinki'),(11,'Lake Placid'),(12,'Sydney'),(13,'Atlanta'),(14,'Stockholm'),(15,'Sochi'),(16,'Nagano'),(17,'Torino'),(18,'Beijing'),(19,'Rio de Janeiro'),(20,'Athina'),(21,'Squaw Valley'),(22,'Innsbruck'),(23,'Sarajevo'),(24,'Mexico City'),(25,'Munich'),(26,'Seoul'),(27,'Berlin'),(28,'Oslo'),(29,'Cortina d\'Ampezzo'),(30,'Melbourne'),(31,'Roma'),(32,'Amsterdam'),(33,'Montreal'),(34,'Moskva'),(35,'Tokyo'),(36,'Vancouver'),(37,'Grenoble'),(38,'Sapporo'),(39,'Chamonix'),(40,'St. Louis'),(41,'Sankt Moritz'),(42,'Garmisch-Partenkirchen');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Basketball Men\'s Basketball'),(2,'Judo Men\'s Extra-Lightweight'),(3,'Football Men\'s Football'),(4,'Tug-Of-War Men\'s Tug-Of-War'),(5,'Speed Skating Women\'s 500 metres'),(6,'Speed Skating Women\'s 1,000 metres'),(7,'Cross Country Skiing Men\'s 10 kilometres'),(8,'Cross Country Skiing Men\'s 50 kilometres'),(9,'Cross Country Skiing Men\'s 10/15 kilometres Pursuit'),(10,'Cross Country Skiing Men\'s 4 x 10 kilometres Relay'),(11,'Cross Country Skiing Men\'s 30 kilometres'),(12,'Athletics Women\'s 100 metres'),(13,'Athletics Women\'s 4 x 100 metres Relay'),(14,'Ice Hockey Men\'s Ice Hockey'),(15,'Swimming Men\'s 400 metres Freestyle'),(16,'Badminton Men\'s Singles'),(17,'Sailing Women\'s Windsurfer'),(18,'Biathlon Women\'s 7.5 kilometres Sprint'),(19,'Swimming Men\'s 200 metres Breaststroke'),(20,'Swimming Men\'s 400 metres Breaststroke'),(21,'Gymnastics Men\'s Individual All-Around'),(22,'Gymnastics Men\'s Team All-Around'),(23,'Gymnastics Men\'s Floor Exercise'),(24,'Gymnastics Men\'s Horse Vault'),(25,'Gymnastics Men\'s Parallel Bars'),(26,'Gymnastics Men\'s Horizontal Bar'),(27,'Gymnastics Men\'s Rings'),(28,'Gymnastics Men\'s Pommelled Horse'),(29,'Athletics Men\'s Shot Put'),(30,'Art Competitions Mixed Sculpturing, Unknown Event'),(31,'Alpine Skiing Men\'s Downhill'),(32,'Alpine Skiing Men\'s Super G'),(33,'Alpine Skiing Men\'s Giant Slalom'),(34,'Alpine Skiing Men\'s Slalom'),(35,'Alpine Skiing Men\'s Combined'),(36,'Handball Women\'s Handball'),(37,'Weightlifting Women\'s Super-Heavyweight'),(38,'Wrestling Men\'s Light-Heavyweight, Greco-Roman'),(39,'Speed Skating Men\'s 500 metres'),(40,'Speed Skating Men\'s 1,500 metres'),(41,'Gymnastics Men\'s Team All-Around, Free System'),(42,'Luge Women\'s Singles'),(43,'Water Polo Men\'s Water Polo'),(44,'Sailing Mixed Three Person Keelboat'),(45,'Hockey Women\'s Hockey'),(46,'Rowing Men\'s Lightweight Double Sculls'),(47,'Athletics Men\'s Pole Vault'),(48,'Athletics Men\'s High Jump'),(49,'Sailing Men\'s Two Person Dinghy'),(50,'Athletics Men\'s 1,500 metres'),(51,'Bobsleigh Men\'s Four'),(52,'Swimming Men\'s 100 metres Butterfly'),(53,'Swimming Men\'s 200 metres Butterfly'),(54,'Swimming Men\'s 4 x 100 metres Medley Relay'),(55,'Football Women\'s Football'),(56,'Fencing Men\'s Foil, Individual'),(57,'Fencing Men\'s epee, Individual'),(58,'Fencing Men\'s epee, Team'),(59,'Speed Skating Men\'s 5,000 metres'),(60,'Speed Skating Men\'s 10,000 metres'),(61,'Sailing Mixed 8 metres'),(62,'Equestrianism Mixed Jumping, Individual'),(63,'Cross Country Skiing Men\'s 15 kilometres'),(64,'Shooting Men\'s Small-Bore Rifle, Prone, 50 metres'),(65,'Shooting Men\'s Rapid-Fire Pistol, 25 metres'),(66,'Shooting Men\'s Trap'),(67,'Athletics Men\'s 4 x 100 metres Relay'),(68,'Athletics Men\'s Long Jump'),(69,'Boxing Men\'s Light-Welterweight'),(70,'Athletics Women\'s Javelin Throw'),(71,'Wrestling Men\'s Heavyweight, Freestyle'),(72,'Taekwondo Men\'s Flyweight'),(73,'Boxing Men\'s Heavyweight'),(74,'Athletics Men\'s 5,000 metres'),(75,'Cycling Men\'s Road Race, Individual'),(76,'Cycling Men\'s Road Race, Team'),(77,'Weightlifting Men\'s Lightweight'),(78,'Weightlifting Men\'s Middleweight'),(79,'Rowing Men\'s Coxless Pairs'),(80,'Judo Men\'s Half-Middleweight'),(81,'Taekwondo Women\'s Flyweight'),(82,'Boxing Men\'s Flyweight'),(83,'Basketball Women\'s Basketball'),(84,'Diving Men\'s Platform'),(85,'Canoeing Men\'s Canadian Doubles, 500 metres'),(86,'Canoeing Men\'s Canadian Doubles, 1,000 metres'),(87,'Canoeing Men\'s Kayak Fours, 1,000 metres'),(88,'Handball Men\'s Handball'),(89,'Rowing Women\'s Coxless Pairs'),(90,'Boxing Men\'s Middleweight'),(91,'Judo Men\'s Lightweight'),(92,'Boxing Men\'s Featherweight'),(93,'Tennis Men\'s Doubles'),(94,'Shooting Mixed Skeet'),(95,'Wrestling Men\'s Featherweight, Freestyle'),(96,'Sailing Mixed Two Person Heavyweight Dinghy'),(97,'Athletics Women\'s Shot Put'),(98,'Rowing Men\'s Coxed Eights'),(99,'Cycling Women\'s Sprint'),(100,'Cycling Women\'s 500 metres Time Trial');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),(6,6,1),(7,7,1),(8,8,1),(9,8,2),(10,9,1),(11,9,2),(12,10,1),(13,10,2),(14,11,1),(15,11,2),(16,12,1),(17,12,2),(18,13,1),(19,13,2),(20,14,1),(21,14,2),(22,15,1),(23,15,2),(24,16,1),(25,16,2),(26,17,1),(27,17,2),(28,18,1),(29,18,2),(30,19,1),(31,19,2),(32,20,1),(33,20,2),(34,21,1),(35,21,2),(36,22,1),(37,22,2),(38,23,1),(39,23,2),(40,24,2),(41,25,1),(42,26,2),(43,27,1),(44,28,2),(45,29,1),(46,30,2),(47,31,1),(48,32,2),(49,33,1),(50,34,2),(51,35,1);
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `hechosathlete`
--

LOCK TABLES `hechosathlete` WRITE;
/*!40000 ALTER TABLE `hechosathlete` DISABLE KEYS */;
INSERT INTO `hechosathlete` VALUES (1,1,23,1,1,38,1,1,1,1),(2,2,33,1,1,49,2,2,2,1),(3,3,7,1,2,7,3,3,3,1),(4,4,2,1,2,2,4,4,4,2),(5,5,22,2,3,37,5,5,5,1),(6,5,22,2,3,37,5,5,6,1),(7,5,23,2,3,39,6,5,5,1),(8,5,23,2,3,39,6,5,6,1),(9,5,24,2,3,40,7,5,5,1),(10,5,24,2,3,40,7,5,6,1),(11,6,23,2,4,39,6,6,7,1),(12,6,23,2,4,39,6,6,8,1),(13,6,23,2,4,39,6,6,9,1),(14,6,23,2,4,39,6,6,10,1),(15,6,24,2,4,40,7,6,7,1),(16,6,24,2,4,40,7,6,11,1),(17,6,24,2,4,40,7,6,9,1),(18,6,24,2,4,40,7,6,10,1),(19,7,23,2,4,39,6,6,7,1),(20,7,23,2,4,39,6,6,8,1),(21,7,23,2,4,39,6,6,9,1),(22,7,23,2,4,39,6,6,10,1),(23,7,24,2,4,40,7,6,7,1),(24,7,24,2,4,40,7,6,11,1),(25,7,24,2,4,40,7,6,9,1),(26,7,24,2,4,40,7,6,10,1),(27,8,10,1,3,12,8,7,12,1),(28,8,10,1,3,12,8,7,13,1),(29,9,28,2,5,44,9,8,14,1),(30,10,13,1,5,18,10,9,15,1),(31,11,20,2,5,33,11,6,11,1),(32,12,27,1,5,43,12,10,16,1),(33,13,25,1,5,41,13,11,17,1),(34,13,27,1,5,43,12,11,17,1),(35,14,24,2,5,40,7,12,18,1),(36,15,6,1,5,6,14,9,19,1),(37,15,6,1,5,6,14,9,20,1),(38,15,7,1,5,7,3,9,19,3),(39,15,7,1,5,7,3,9,20,3),(40,15,8,1,5,8,4,9,19,1),(41,16,34,2,5,50,15,8,14,3),(42,17,12,1,5,16,2,13,21,3),(43,17,12,1,5,16,2,13,22,2),(44,17,12,1,5,16,2,13,23,1),(45,17,12,1,5,16,2,13,24,2),(46,17,12,1,5,16,2,13,25,1),(47,17,12,1,5,16,2,13,26,1),(48,17,12,1,5,16,2,13,27,1),(49,17,12,1,5,16,2,13,28,2),(50,17,13,1,5,18,10,13,21,1),(51,17,13,1,5,18,10,13,22,3),(52,17,13,1,5,18,10,13,23,1),(53,17,13,1,5,18,10,13,24,1),(54,17,13,1,5,18,10,13,25,1),(55,17,13,1,5,18,10,13,26,1),(56,17,13,1,5,18,10,13,27,1),(57,17,13,1,5,18,10,13,28,1),(58,18,27,1,5,43,12,7,29,1),(59,19,12,1,5,16,2,14,30,1),(60,20,23,2,6,39,6,15,31,1),(61,20,23,2,6,39,6,15,32,2),(62,20,23,2,6,39,6,15,33,3),(63,20,23,2,6,39,6,15,34,1),(64,20,24,2,6,40,7,15,31,4),(65,20,24,2,6,40,7,15,32,3),(66,20,24,2,6,40,7,15,33,1),(67,20,24,2,6,40,7,15,34,1),(68,20,24,2,6,40,7,15,35,4),(69,20,26,2,6,42,16,15,31,1),(70,20,26,2,6,42,16,15,32,1),(71,20,26,2,6,42,16,15,33,1),(72,20,26,2,6,42,16,15,35,1),(73,20,28,2,6,44,9,15,31,1),(74,20,28,2,6,44,9,15,32,2),(75,20,28,2,6,44,9,15,33,1),(76,20,28,2,6,44,9,15,34,1),(77,20,28,2,6,44,9,15,35,2),(78,20,30,2,6,46,17,15,31,1),(79,20,30,2,6,46,17,15,32,2),(80,21,31,1,6,47,18,16,36,2),(81,22,35,1,7,51,19,17,37,1),(82,23,27,1,6,43,12,18,38,1),(83,23,29,1,6,45,20,18,38,1),(84,24,15,2,6,23,21,5,39,1),(85,24,15,2,6,23,21,5,40,1),(86,24,16,2,6,25,22,5,40,1),(87,25,7,1,6,7,3,13,41,4),(88,26,21,2,6,35,23,19,42,1),(89,27,21,1,3,34,8,20,43,1),(90,28,17,1,6,26,24,11,44,1),(91,28,18,1,6,28,25,11,44,1),(92,29,22,1,3,36,26,21,45,3),(93,30,25,1,3,41,13,22,46,4),(94,30,27,1,3,43,12,22,46,1),(95,31,11,1,8,14,27,7,47,1),(96,32,6,1,6,6,14,7,48,1),(97,33,23,1,5,38,1,11,49,1),(98,33,25,1,5,41,13,11,49,1),(99,34,33,1,9,49,2,7,50,1),(100,2,2,1,1,1,1,1,1,1),(101,10,2,1,1,1,1,1,1,1);
/*!40000 ALTER TABLE `hechosathlete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_delete_athlete_name`
--

LOCK TABLES `log_delete_athlete_name` WRITE;
/*!40000 ALTER TABLE `log_delete_athlete_name` DISABLE KEYS */;
INSERT INTO `log_delete_athlete_name` VALUES (1,101,'love2','M',70,180,80,'root@localhost','2022-03-02 21:44:57'),(2,102,'HOLA','M',70,180,80,'root@localhost','2022-03-02 21:44:57'),(3,103,'HOLA','M',70,180,80,'root@localhost','2022-03-02 21:44:57'),(4,104,'HOLA','M',70,180,80,'root@localhost','2022-03-02 21:44:57'),(5,121,'HOLA','M',70,180,80,'root@localhost','2022-03-02 21:44:57'),(6,122,'HOLA','M',70,180,80,'root@localhost','2022-03-02 21:44:57'),(7,123,'HOLA','M',70,180,80,'root@localhost','2022-03-02 21:44:57');
/*!40000 ALTER TABLE `log_delete_athlete_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_delete_hechosathlete`
--

LOCK TABLES `log_delete_hechosathlete` WRITE;
/*!40000 ALTER TABLE `log_delete_hechosathlete` DISABLE KEYS */;
INSERT INTO `log_delete_hechosathlete` VALUES (1,102,2,2,1,1,1,1,1,1,1,'root@localhost','2022-03-02 21:46:16'),(2,103,1,1,1,1,1,1,1,1,1,'root@localhost','2022-03-02 21:46:16');
/*!40000 ALTER TABLE `log_delete_hechosathlete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_insercion_athlete`
--

LOCK TABLES `log_insercion_athlete` WRITE;
/*!40000 ALTER TABLE `log_insercion_athlete` DISABLE KEYS */;
INSERT INTO `log_insercion_athlete` VALUES (1,123,'HOLA','M',70,180,80,'root@localhost','2022-03-02 21:44:57');
/*!40000 ALTER TABLE `log_insercion_athlete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_insercion_hechosathlete`
--

LOCK TABLES `log_insercion_hechosathlete` WRITE;
/*!40000 ALTER TABLE `log_insercion_hechosathlete` DISABLE KEYS */;
INSERT INTO `log_insercion_hechosathlete` VALUES (1,103,1,1,1,1,1,1,1,1,1,'root@localhost','2022-03-02 21:45:59');
/*!40000 ALTER TABLE `log_insercion_hechosathlete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_modificacion_athlete_name`
--

LOCK TABLES `log_modificacion_athlete_name` WRITE;
/*!40000 ALTER TABLE `log_modificacion_athlete_name` DISABLE KEYS */;
INSERT INTO `log_modificacion_athlete_name` VALUES (1,101,'HOLA','love','root@localhost','2022-03-02 21:44:57'),(2,101,'love','love2','root@localhost','2022-03-02 21:44:57');
/*!40000 ALTER TABLE `log_modificacion_athlete_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_modificacion_hechosathlete`
--

LOCK TABLES `log_modificacion_hechosathlete` WRITE;
/*!40000 ALTER TABLE `log_modificacion_hechosathlete` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_modificacion_hechosathlete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `medal`
--

LOCK TABLES `medal` WRITE;
/*!40000 ALTER TABLE `medal` DISABLE KEYS */;
INSERT INTO `medal` VALUES (1,'NA'),(2,'Gold'),(3,'Bronze'),(4,'Silver');
/*!40000 ALTER TABLE `medal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `noc`
--

LOCK TABLES `noc` WRITE;
/*!40000 ALTER TABLE `noc` DISABLE KEYS */;
INSERT INTO `noc` VALUES (1,'CHN'),(2,'DEN'),(3,'NED'),(4,'USA'),(5,'FIN'),(6,'NOR'),(7,'ROU'),(8,'EST'),(9,'FRA'),(10,'MAR'),(11,'ESP'),(12,'EGY'),(13,'IRI'),(14,'BUL'),(15,'ITA'),(16,'CHA'),(17,'AZE'),(18,'SUD'),(19,'RUS'),(20,'ARG'),(21,'CUB'),(22,'BLR'),(23,'GRE'),(24,'CMR'),(25,'TUR'),(26,'CHI'),(27,'MEX'),(28,'URS'),(29,'NCA'),(30,'HUN'),(31,'NGR'),(32,'ALG'),(33,'KUW'),(34,'BRN'),(35,'PAK'),(36,'IRQ'),(37,'UAR'),(38,'LIB'),(39,'QAT'),(40,'MAS'),(41,'GER'),(42,'CAN'),(43,'IRL'),(44,'AUS'),(45,'RSA'),(46,'ERI'),(47,'TAN'),(48,'JOR'),(49,'TUN'),(50,'LBA'),(51,'BEL'),(52,'DJI'),(53,'PLE'),(54,'COM'),(55,'KAZ'),(56,'BRU'),(57,'IND'),(58,'KSA'),(59,'SYR'),(60,'MDV'),(61,'ETH'),(62,'UAE'),(63,'YAR'),(64,'INA'),(65,'PHI'),(66,'SGP'),(67,'UZB'),(68,'KGZ'),(69,'TJK'),(70,'EUN'),(71,'JPN'),(72,'CGO'),(73,'SUI'),(74,'BRA'),(75,'FRG'),(76,'GDR'),(77,'MON'),(78,'ISR'),(79,'URU'),(80,'SWE'),(81,'ISV'),(82,'SRI'),(83,'ARM'),(84,'CIV'),(85,'KEN'),(86,'BEN'),(87,'UKR'),(88,'GBR'),(89,'GHA'),(90,'SOM'),(91,'LAT'),(92,'NIG'),(93,'MLI'),(94,'AFG'),(95,'POL'),(96,'CRC'),(97,'PAN'),(98,'GEO'),(99,'SLO'),(100,'CRO');
/*!40000 ALTER TABLE `noc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `season`
--

LOCK TABLES `season` WRITE;
/*!40000 ALTER TABLE `season` DISABLE KEYS */;
INSERT INTO `season` VALUES (1,'Summer'),(2,'Winter');
/*!40000 ALTER TABLE `season` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sport`
--

LOCK TABLES `sport` WRITE;
/*!40000 ALTER TABLE `sport` DISABLE KEYS */;
INSERT INTO `sport` VALUES (1,'Basketball'),(2,'Judo'),(3,'Football'),(4,'Tug-Of-War'),(5,'Speed Skating'),(6,'Cross Country Skiing'),(7,'Athletics'),(8,'Ice Hockey'),(9,'Swimming'),(10,'Badminton'),(11,'Sailing'),(12,'Biathlon'),(13,'Gymnastics'),(14,'Art Competitions'),(15,'Alpine Skiing'),(16,'Handball'),(17,'Weightlifting'),(18,'Wrestling'),(19,'Luge'),(20,'Water Polo'),(21,'Hockey'),(22,'Rowing'),(23,'Bobsleigh'),(24,'Fencing'),(25,'Equestrianism'),(26,'Shooting'),(27,'Boxing'),(28,'Taekwondo'),(29,'Cycling'),(30,'Diving'),(31,'Canoeing'),(32,'Tennis'),(33,'Modern Pentathlon'),(34,'Figure Skating'),(35,'Golf'),(36,'Softball'),(37,'Archery'),(38,'Volleyball'),(39,'Synchronized Swimming'),(40,'Table Tennis'),(41,'Nordic Combined'),(42,'Baseball'),(43,'Rhythmic Gymnastics'),(44,'Freestyle Skiing'),(45,'Rugby Sevens'),(46,'Trampolining'),(47,'Beach Volleyball'),(48,'Triathlon'),(49,'Ski Jumping'),(50,'Curling'),(51,'Snowboarding'),(52,'Rugby'),(53,'Short Track Speed Skating'),(54,'Skeleton'),(55,'Lacrosse'),(56,'Polo'),(57,'Cricket'),(58,'Racquets'),(59,'Motorboating'),(60,'Military Ski Patrol'),(61,'Croquet'),(62,'Jeu De Paume'),(63,'Roque'),(64,'Alpinism'),(65,'Basque Pelota'),(66,'Aeronautics');
/*!40000 ALTER TABLE `sport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `year`
--

LOCK TABLES `year` WRITE;
/*!40000 ALTER TABLE `year` DISABLE KEYS */;
INSERT INTO `year` VALUES (1,1896),(2,1900),(3,1904),(4,1906),(5,1908),(6,1912),(7,1920),(8,1924),(9,1928),(10,1932),(11,1936),(12,1948),(13,1952),(14,1956),(15,1960),(16,1964),(17,1968),(18,1972),(19,1976),(20,1980),(21,1984),(22,1988),(23,1992),(24,1994),(25,1996),(26,1998),(27,2000),(28,2002),(29,2004),(30,2006),(31,2008),(32,2010),(33,2012),(34,2014),(35,2016);
/*!40000 ALTER TABLE `year` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-02 22:00:33
