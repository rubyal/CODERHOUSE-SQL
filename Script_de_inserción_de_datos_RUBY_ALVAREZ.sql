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
PRIMARY KEY (season));

select * from season;

create table year(
id_year int,
year int,
PRIMARY KEY (year));

select * from year;

create table games(
id_games int,
year int,
season varchar (20),
PRIMARY KEY (id_games),
foreign key (year) references year(year),
foreign key (season) references season(season)
);

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
year int,
season varchar (20),
id_noc int,
id_games int,
id_city int,
id_sport int,
id_event int,
id_medal int,
PRIMARY KEY(id_hechos),
FOREIGN KEY(id_athlete) REFERENCES athlete(id_athlete),
FOREIGN KEY(year) REFERENCES year(year),
FOREIGN KEY(season) REFERENCES season(season),
FOREIGN KEY(id_noc) REFERENCES NOC(id_noc),
FOREIGN KEY(id_games) REFERENCES games(id_games),
FOREIGN KEY(id_city) REFERENCES city(id_city),
FOREIGN KEY(id_sport) REFERENCES sport(id_sport),
FOREIGN KEY(id_event) REFERENCES event(id_event),
FOREIGN KEY(id_medal) REFERENCES medal(id_medal));

select * from hechosathlete;
