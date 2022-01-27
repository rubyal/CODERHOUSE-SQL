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

create table NOC(
id_noc int primary key, 
noc varchar (10),
team varchar (20),
id_athlete int,
foreign key (id_athlete) references athlete(id_athlete));

select * from NOC;

create table event(
id_event int primary key,
event varchar (50),
id_athlete int,
foreign key (id_athlete) references athlete(id_athlete));

select * from event;

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

create table sport(
id_sport int primary key,
sport varchar (20),
id_athlete int,
foreign key (id_athlete) references athlete(id_athlete));

select * from sport;

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

select * from city;


