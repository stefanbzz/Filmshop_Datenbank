  drop database if exists videothek;
  create database videothek;
  use videothek;



  create table Geschlecht (
    geschlecht_id serial,
    geschlecht_name varchar(255) not null,

    primary key(geschlecht_id)
  );

  create table Nationalitaet (
    nationalitaet_id serial,
    country varchar(255) not null,

    primary key(nationalitaet_id)
  );

  create table Ort (
    ort_id serial,
    plz smallint(4) unsigned not null,
    ort varchar(255) not null,

    primary key(ort_id),
    unique(plz, ort)
  );

  create table Kunde (
    kunde_id serial,
    vorname varchar(255) not null,
    nachname varchar(255) not null,
    strasse varchar(255) not null,
    telefonnummer bigint(10) not null,
    age smallint(4) unsigned not null,

    nationalitaet_id bigint unsigned not null,
    ort_id bigint unsigned not null,
    geschlecht_id bigint unsigned not null,

    primary key(kunde_id),
    foreign key(nationalitaet_id) references Nationalitaet(nationalitaet_id) on update cascade on delete cascade,
    foreign key(ort_id) references Ort(ort_id) on update cascade on delete cascade,
    foreign key(geschlecht_id) references Geschlecht(geschlecht_id) on update cascade on delete cascade
  );

create table Schauspieler(
  schauspieler_id serial,
  nationalitaet_id bigint unsigned not null,
  geschlecht_id bigint unsigned not null,
  vorname varchar(255) not null,
  nachname varchar(255) not null,

  primary key(schauspieler_id),
  foreign key(nationalitaet_id) references Nationalitaet(nationalitaet_id) on update cascade on delete cascade,
  foreign key(geschlecht_id) references Geschlecht(geschlecht_id) on update cascade on delete cascade
);

create table Regisseur(
  regisseur_id serial,
  nationalitaet_id bigint unsigned not null,
  geschlecht_id bigint unsigned not null,
  vorname varchar(255) not null,
  nachname varchar(255) not null,

  primary key(regisseur_id),
  foreign key(nationalitaet_id) references Nationalitaet(nationalitaet_id) on update cascade on delete cascade,
  foreign key(geschlecht_id) references Geschlecht(geschlecht_id) on update cascade on delete cascade
);

create table Mitarbeiter(
  mitarbeiter_id serial,
  vorname varchar(255) not null,
  nachname varchar(255) not null,
  mitarbeiternr int not null,

  primary key(mitarbeiter_id)
);

create table Medientypen(
  medientyp_id serial,
  typ varchar(255),

  primary key(medientyp_id)
);

create table Kategorie(
  kategorie_id serial,
  kategorie_name varchar(255),

  primary key(kategorie_id)
);

create table Film(
  film_id serial,
  regisseur_id bigint unsigned not null,
  kategorie_id bigint unsigned not null,
  name varchar(255) not null,
  film_preis float(25) not null,
  veroeffentlichungsdatum smallint(4) not null,

  medientyp_id bigint unsigned not null,

  primary key(film_id),
  foreign key (regisseur_id) references Regisseur(regisseur_id) on update cascade on delete cascade,
  foreign key (medientyp_id) references Medientypen(medientyp_id) on update cascade on delete cascade,
  foreign key (kategorie_id) references Kategorie(kategorie_id) on update cascade on delete cascade
);

create table Schauspieler_Film(
  schauspieler_film_id serial,
  schauspieler_id bigint unsigned not null,
  film_id bigint unsigned not null,

  primary key(schauspieler_film_id),
  foreign key(schauspieler_id) references Schauspieler(schauspieler_id) on update cascade on delete cascade,
  foreign key(film_id) references Film(film_id) on update cascade on delete cascade
);

create table Laden(
  laden_id serial,
  name varchar(255) not null,

  ort_id bigint unsigned not null,

  primary key(laden_id),
  foreign key(ort_id) references Ort(ort_id) on update cascade on delete cascade
);

create table Lager(
  lager_id serial,
  laden_id bigint unsigned not null,
  lager_name varchar(255) not null,
  primary key(lager_id),
    foreign key(laden_id) references Laden(laden_id) on update cascade on delete cascade
);

create table Lager_Film(
  Lager_Film_id serial,
  lager_id bigint unsigned not null,
  film_id bigint unsigned not null,

  primary key(Lager_Film_id),
  foreign key(lager_id) references Lager(lager_id) on update cascade on delete cascade,
  foreign key(film_id) references Film(film_id) on update cascade on delete cascade
);


create table Nominierung(
  nominierung_id serial,
  nominierungs_name VARCHAR(255),

  primary key(nominierung_id)
);

create table Nominierung_Film(
  nominierung_film_id serial,
  film_id bigint unsigned not null,
  nominierung_id bigint unsigned not null,

  primary key(nominierung_film_id),
  foreign key(film_id) references Film(film_id) on update cascade on delete restrict,
  foreign key(nominierung_id) references Nominierung(nominierung_id) on update cascade on delete restrict
);


create table Kategorie_Film(
  kategorie_film_id serial,
  kategorie_id bigint unsigned not null,
  film_id bigint unsigned not null,

  primary key(kategorie_film_id),
  foreign key(kategorie_id) references Kategorie(kategorie_id) on update cascade on delete restrict,
  foreign key(film_id) references Film(film_id) on update cascade on delete restrict
);

create table ausleihen(
  ausleih_id serial,
  film_id bigint unsigned not null,
  lager_id bigint unsigned not null,
  laden_id bigint unsigned not null,
  kunde_id bigint unsigned not null,
  ausleihe_preis float(25) not null,
  ausleih_datum date,
  rueckgabe_datum date,

  primary key(ausleih_id),
    foreign key(film_id) references Film(film_id) on update cascade on delete restrict,
  foreign key(lager_id) references Lager(lager_id) on update cascade on delete restrict,
  foreign key(laden_id) references Laden(laden_id) on update cascade on delete restrict,
  foreign key(kunde_id) references Kunde(kunde_id) on update cascade on delete restrict
);

begin;

insert into Geschlecht(geschlecht_name) values
  ('Maennlich'),
  ('Weiblich'),
  ('Andere');

insert into Nationalitaet(country) values
  ('Schweiz'),
  ('USA'),
  ('Indien'),
  ('Deutschland'),
  ('Frankreich');

insert into Ort(plz, ort) values
  (8001, 'Zuerich'),
  (9500, 'Wil'),
  (9000, 'St.Gallen'),
  (8302, 'Kloten'),
  (7000, 'Chur'),
  (1000, 'Lausanne'),
  (1400, 'Yverdon-les-Bains'),
  (3004, 'Bern'),
  (3038, 'Wolfhalden'),
  (8320, 'Fehraltorf'),
  (9032, 'Engelburg'),
  (8305, 'Dietlikon'),
  (8134, 'Adliswil');

insert into Kunde(vorname, nachname, strasse, telefonnummer, age, nationalitaet_id, ort_id, geschlecht_id) values
  ('Pascal', 'Thuma', 'Stockerstrasse 51', 0784203258, 17, 2, 10, 3 ),
  ('Ivan', 'Gotovcevic', 'Berghaldenweg 2', 0782341234, 19, 3, 3, 1 ),
  ('Stefan', 'Thomsen', 'Kirchweg 14', 0783512394, 18, 2, 1, 1),
  ('Eliana', 'Schenker', 'Zugerstrasse 23', 0773245124, 16, 1, 5, 2 ),
  ('Fritz', 'Halden', 'Ackerstrasse 69', 0795642345, 32, 5, 7, 1),
  ('Hans', 'Von Acker', 'Graesslistrasse 420', 0764203258, 42, 4, 8, 1),
  ('Sairam', 'Vijayakumar', 'Currystrasse 69', 0764206969, 19, 3, 9, 1),
  ('Stevania', 'Tompsona', 'Bruhstreet 23', 0791234432, 12, 5, 12, 2),
  ('Noemi', 'Mahler', 'Strasse 12', 0573677598, 28, 4, 12, 2),
  ('Leana', 'Kovacevic', 'Strasse 6', 0573175598, 34, 5,  5, 2),
  ('Manon', 'Cavar', 'Strasse 34', 0789230359, 32, 5,  6, 1),
  ('Sara', 'Smith', 'Strasse 23', 0573175543, 56, 1,  8, 2),
  ('Daria', 'Maertl', 'Strasse 54', 0573176890, 43, 2,  6, 2),
  ('Hans', 'Zimmermann', 'Strasse 87', 0573245980, 46, 3,  13, 1),
  ('Elias', 'Sarfraz', 'Strasse 23', 0573165980, 51, 1, 10, 3),
  ('Martin', 'Duepi', 'Strasse 54', 0573754980, 47, 5, 10, 1),
  ('Marko', 'Joksimovic', 'Strasse 76', 0447355980, 30, 3, 9, 1),
  ('Marco', 'Weiss', 'Strasse 13', 0731754380, 21, 4, 1, 1),
  ('Eliot', 'Meer', 'Strasse 5', 0731755956, 26, 2, 2, 2),
  ('Ludovic', 'Sarafan', 'Strasse 76',0731865980, 23, 1, 3, 1),
  ('Markus', 'Wildhaber', 'Strasse 28', 0731735980, 22, 1, 4, 1),
  ('Patrick', 'Shanmuganathan', 'Strasse 34', 0733255980, 14, 2, 7, 1),
  ('Laurenz', 'Mueller', 'Strasse 27', 0731755320, 20, 2, 8, 1),
  ('Lorent', 'Ullate', 'Strasse 62', 0571754380, 25, 3, 11, 1),
  ('Matteo', 'Cavar', 'Strasse 72', 0531755980, 44, 1, 12, 1),
  ('Martin', 'Silva', 'Strasse 64', 0573175598, 39, 3, 5, 1),
  ('Naomi', 'Rachell', 'Strasse 98', 0573175598, 41, 4, 6, 2),
  ('Juerg', 'Fischbacher', 'Strasse 98', 0573175598, 41, 5, 6, 2);

insert into Schauspieler(nationalitaet_id, geschlecht_id, vorname, nachname) values
  (2, 1, 'Johnny', 'Depp'),
  (2, 1, 'Will', 'Smith'),
  (2, 1, 'Brad', 'Pitt'),
  (2, 2, 'Scarlett', 'Johansson'),
  (2, 2, 'Jennifer', 'Lawrence'),
  (2, 2, 'Julia', 'Roberts'),
  (2, 1, 'Harrison', 'Ford'),
  (2, 1, 'Leonardo', 'DiCaprio'),
  (2, 1, 'Tom', 'Cruise'),
  (2, 1, 'Sylvester', 'Stallone'),
  (2, 1, 'Morgan', 'Freeman');


insert into Regisseur(nationalitaet_id, geschlecht_id, vorname, nachname) values
  (2,1,'Martin', 'Scorsese'),
  (2,1,'Steven', 'Spielberg'),
  (3,1,'Anurag', 'Kashyap'),
  (2,1,'Wes', 'Anderson'),
  (2,1,'Tim', 'Burton'),
  (5,1,'Luc', 'Besson'),
  (2,2,'Claire', 'Denis'),
  (2,1,'George', 'Lucas');


insert into Mitarbeiter(vorname, nachname, mitarbeiternr) values
  ('Juerg', 'Strasser', 1),
  ('David', 'Hubner', 2),
  ('Jonas', 'Baerli', 3),
  ('Madeleine', 'Von Arx', 1),
  ('Stefan', 'Bachmann', 2),
  ('Ruedi', 'Hofmann', 3);

insert into Medientypen(typ) values
  ('Blue Ray'),
  ('Digital'),
  ('DVD');

  insert into Kategorie(kategorie_name) values
    ("Drama"),
    ("Action"),
    ("Horror"),
    ("Mystery"),
    ("Fantasy"),
    ("Thriller"),
    ("Western"),
    ("Sci-Fi"),
    ("Documentary"),
    ("Romance"),
    ("Pornofilm");



insert into Film (kategorie_id, regisseur_id, name, veroeffentlichungsdatum, medientyp_id, film_preis) values
  (2,1,'Star Wars I', 1976, 1, 5.90),
  (5,1,'Harry Potter I', 1999, 1, 15),
  (2,2,'Ready Player One', 2018, 1, 10),
  (7,3,'Star Trek Discovery', 2017, 1, 5),
  (2,1,"Thoroughbreds Don't Cry", 2008, 2, 20),
  (1,2,"Search for the Beast", 1956, 3, 16),
  (6,3,"Baby of Macon, The (a.k.a. The Baby of Macon)", 2002, 1, 13),
  (3,4,"Bugsy Malone", 2010, 1, 13),
  (2,5,"Labyrinth of Passion (Laberinto de Pasiones)", 2007, 3, 15),
  (6,6,"White Dwarf, The (Valkoinen)", 2012, 3, 4),
  (4,8,"Donner Party, The", 2004, 2, 8),
  (8,5,"Eye, The (Gin gwai) (Jian gui)", 1992, 1, 10),
  (1,4,"1987", 1986, 1, 15),
  (2,5,"All Things to All Men", 1986, 2, 10);

insert into Schauspieler_Film(schauspieler_id, film_id) values
  (1, 1),
  (1, 2),
  (1, 3),
  (1, 4),
  (1, 5),
  (1, 6),
  (1, 7),
  (1, 8),
  (1, 9),
  (1, 10),
  (1, 11),
  (1, 12),
  (1, 13),
  (1, 14),
  (2, 1),
  (2, 2),
  (2, 3),
  (2, 4),
  (2, 5),
  (2, 6),
  (2, 7),
  (2, 8),
  (2, 9),
  (2, 10),
  (2, 11),
  (2, 12),
  (2, 13),
  (2, 14),
  (3, 1),
  (3, 2),
  (3, 3),
  (3, 4),
  (3, 5),
  (3, 6),
  (3, 7),
  (3, 8),
  (3, 9),
  (3, 10),
  (3, 11),
  (3, 12),
  (3, 13),
  (3, 14),
  (4, 1),
  (4, 2),
  (4, 3),
  (4, 4),
  (4, 5),
  (4, 6),
  (4, 7),
  (4, 8),
  (4, 9),
  (4, 10),
  (4, 11),
  (4, 12),
  (4, 13),
  (4, 14),
  (5, 1),
  (5, 2),
  (5, 3),
  (5, 4),
  (5, 5),
  (5, 6),
  (5, 7),
  (5, 8),
  (5, 9),
  (5, 10),
  (5, 11),
  (5, 12),
  (5, 13),
  (5, 14),
  (6, 1),
  (6, 2),
  (6, 3),
  (6, 4),
  (6, 5),
  (6, 6),
  (6, 7),
  (6, 8),
  (6, 9),
  (6, 10),
  (6, 11),
  (6, 12),
  (6, 13),
  (6, 14),
  (7, 1),
  (7, 2),
  (7, 3),
  (7, 4),
  (7, 5),
  (7, 6),
  (7, 7),
  (7, 8),
  (7, 9),
  (7, 10),
  (7, 11),
  (7, 12),
  (7, 13),
  (7, 14),
  (8, 1),
  (8, 2),
  (8, 3),
  (8, 4),
  (8, 5),
  (8, 6),
  (8, 7),
  (8, 8),
  (8, 9),
  (8, 10),
  (8, 11),
  (8, 12),
  (8, 13),
  (8, 14),
  (9, 1),
  (9, 2),
  (9, 3),
  (9, 4),
  (9, 5),
  (9, 6),
  (9, 7),
  (9, 8),
  (9, 9),
  (9, 10),
  (9, 11),
  (9, 12),
  (9, 13),
  (9, 14),
  (10, 1),
  (10, 2),
  (10, 3),
  (10, 4),
  (10, 5),
  (10, 6),
  (10, 7),
  (10, 8),
  (10, 9),
  (10, 10),
  (10, 11),
  (10, 12),
  (10, 13),
  (10, 14),
  (11, 1),
  (11, 2),
  (11, 3),
  (11, 4),
  (11, 5),
  (11, 6),
  (11, 7),
  (11, 8),
  (11, 9),
  (11, 10),
  (11, 11),
  (11, 12),
  (11, 13),
  (11, 14);



insert into Laden(name, ort_id) values
  ('LesVideos', 1),
  ('BratwurstFilme', 3),
  ('LesFilmesFrancaise', 7),
  ('BaerenFilme', 8),
  ('TheHOODVerleih', 13);




insert into Lager(laden_id, lager_name) values
  (1, 'Lager 1'),
  (2, 'Lager 1'),
  (3, 'Lager 1'),
  (4, 'Lager 1'),
  (5, 'Lager 1');

insert into Lager_Film(lager_id, film_id) values
  (1, 1),
  (1, 2),
  (1, 3),
  (1, 4),
  (1, 5),
  (1, 6),
  (1, 7),
  (1, 8),
  (1, 9),
  (1, 10),
  (1, 11),
  (1, 12),
  (1, 13),
  (2, 1),
  (2, 2),
  (2, 3),
  (2, 4),
  (2, 5),
  (2, 6),
  (2, 7),
  (2, 8),
  (2, 9),
  (2, 10),
  (2, 11),
  (2, 12),
  (2, 13),
  (3, 1),
  (3, 2),
  (3, 3),
  (3, 4),
  (3, 5),
  (3, 6),
  (3, 7),
  (3, 8),
  (3, 9),
  (3, 10),
  (3, 11),
  (3, 12),
  (3, 13);


insert into Kategorie(kategorie_name) values
  ("Drama"),
  ("Action"),
  ("Horror"),
  ("Mystery"),
  ("Fantasy"),
  ("Thriller"),
  ("Western"),
  ("Sci-Fi"),
  ("Documentary"),
  ("Romance");

insert into Nominierung(nominierungs_name) values
  ("Best Film 2009"),
  ("Best Film 2010"),
  ("Best Film 2011"),
  ("Best Film 2012"),
  ("Best Film 2013"),
  ("Oscar"),
  ("Golden Globe Award"),
  ("Golden Raspberry Award"),
  ("European Film Award"),
  ("German Film Award");

insert into Nominierung_Film(film_id, nominierung_id) values
  (1,6),
  (2,1),
  (2,6),
  (3,2),
  (7,7),
  (8,3),
  (9,4),
  (10,5),
  (13,8);

insert into ausleihen(film_id, lager_id, laden_id, kunde_id, ausleih_datum, rueckgabe_datum, ausleihe_preis) values
    (1, 1, 1, 1, '2020-09-02', '2020-09-05', 5.90),
    (1, 1, 1, 1, '2020-09-02', '2020-09-05', 5.90),
    (2, 5 ,5 ,2 ,'2018-09-23', '2018-09-23', 5.90),
    (2, 2 ,2 ,26 ,'2021-02-16', '2021-02-18', 15),
    (3, 2 ,2 ,26 ,'2021-02-16', '2021-02-18', 10),
    (4, 5 ,5 ,7 ,'1999-03-27', '2021-05-31', 2069.00),
    (4, 2 ,2 ,26 ,'2021-02-16', '2021-02-18', 5),
    (5, 2 ,2 ,13 ,'2021-02-14', '2020-02-20', 7.90),
    (6, 3 ,3 ,16 ,'2011-04-10', '2011-04-14', 9.80),
    (7, 4 ,4 ,8 ,'2019-10-01', '2019-10-02', 8.20),
    (8, 5 ,5 ,4 ,'2020-05-13', '2020-05-15', 3.90),
    (9, 1 ,1 ,6 ,'2015-11-23', '2015-11-25', 15),
    (10, 1 ,1 ,6 ,'2015-11-23', '2015-11-25', 4),
    (11, 1 ,1 ,6 ,'2015-11-23', '2015-11-25', 8),
    (13, 3 ,3 ,3 ,'2020-09-02', '2020-09-05', 10.00),
    (10, 2, 2,	11, '2018-11-02', '2020-09-05',8.9),
    (9,	3, 3,	17, '2019-05-22','2021-03-31',10),
    (5,	1, 1,	23, '2018-08-04', '2020-10-20',12),
    (10, 2,	2, 2, '2019-07-20', '2021-02-21',5.9),
    (4,	3, 3,	23, '2019-01-20', '2021-02-14',7.9),
    (2,	3,	3, 10, '2019-05-12', '2019-11-25',15),
    (14, 1,	1, 3, '2019-02-07', '2020-11-01',12),
    (14, 1,	1, 6, '2018-08-16', '2019-10-20',11.5),
    (12, 2,	2, 18, '2018-11-14', '2019-08-28',10),
    (9,	2, 2,	5, '2020-09-02', '2020-09-05',6.8),
    (13, 3,	2, 7, '2019-01-08', '2019-08-28',10),
    (2,	2, 2,	23, '2020-01-08', '2021-01-30',23),
    (7,	3, 3,	9, '2021-01-08', '2021-01-30',11),
    (7,	3, 3,	3, '2020-04-14', '2021-01-20',14),
    (4,	2, 2,	3, '2019-04-14', '2019-04-20',6),
    (13, 2, 2, 10, '2019-04-11', '2020-06-05',4.5),
    (2,	1, 1,	16, '2020-11-23', '2021-05-20',9.9),
    (1,	3,3, 16, '2020-10-23', '2021-02-20',8.9),
    (4,	2, 2,	23, '2020-09-23', '2021-01-20',10.9),
    (10, 2, 2, 12, '2020-08-23', '2021-01-28',7.8),
    (7,	1, 1,	21, '2019-12-23', '2020-01-28',8.9),
    (12,3, 3,	27, '2019-11-23', '2020-01-01',10.0),
    (12, 2, 2, 22, '2020-03-23', '2020-04-01',11.0),
    (13, 1, 1, 22, '2020-04-23', '2021-01-01',12.0),
    (5,	1, 1,	14, '2020-05-23', '2021-01-01',8.9),
    (14, 2, 2, 7, '2020-06-23', '2021-01-01',7.9),
    (5,	2, 2,	26, '2020-07-23', '2021-01-01',8.9),
    (7,	1, 1,	24, '2020-07-28', '2021-02-01',10.9),
    (8,	2, 2,	13, '2020-09-30', '2021-03-01',10),
    (7,	1, 1,	20, '2020-10-12', '2021-03-01',11),
    (7,	1, 1,	14, '2020-11-12', '2021-03-01',8),
    (12, 2, 2, 16, '2020-12-12', '2021-04-01',6),
    (11, 1, 1, 12, '2019-12-12', '2021-04-01',12),
    (13, 3, 3,21, '2018-11-12', '2018-12-01',23),
    (13, 1, 1, 28, '2020-04-23', '2021-01-01',12.0),
    (6,	2, 2,	3, '2018-12-12', '2019-01-12',10);

(select Film.name'Anzahl Ausleihen eines <Films> pro Land', Nationalitaet.country as Land, count(ausleihen.ausleih_id) as Ausleihen
  from
  Nationalitaet
  join Kunde on Nationalitaet.nationalitaet_id = Kunde.nationalitaet_id
  join ausleihen on Kunde.kunde_id = ausleihen.kunde_id
  join Film on ausleihen.film_id = Film.film_id
  group by Film.name, Nationalitaet.country
  order by count(ausleihen.ausleih_id) desc);

  select Film.name'Umsatz im Jahr', ROUND(sum(ausleihen.ausleihe_preis), 2)'2021'
        from
        ausleihen
        join Film on ausleihen.film_id = Film.film_id
        where ausleihen.rueckgabe_datum > DATE_SUB(now(), INTERVAL 12 MONTH)
        group by Film.film_id

  union all

  select '---------------------------------------------', '--------------------'

  union all

  select 'Umsatz im Jahr', '2020'

  union all

  select '---------------------------------------------', '--------------------'

  union all

  select Film.name'Umsatz im Jahr', ROUND(sum(ausleihen.ausleihe_preis), 2)'2021'
      from
      ausleihen
      join Film on ausleihen.film_id = Film.film_id
      where ausleihen.rueckgabe_datum < DATE_SUB(now(), INTERVAL 12 MONTH)
      AND
      ausleihen.rueckgabe_datum > DATE_SUB(now(), INTERVAL 24 MONTH)
      group by Film.film_id

  union all

  select '---------------------------------------------', '--------------------'

  union all

  select 'Umsatz im Jahr', '2019'

  union all

  select '---------------------------------------------', '--------------------'

  union all

  select Film.name'Umsatz im Jar', ROUND(sum(ausleihen.ausleihe_preis), 2)'2021'
      from
      ausleihen
      join Film on ausleihen.film_id = Film.film_id
      where ausleihen.rueckgabe_datum < DATE_SUB(now(), INTERVAL 24 MONTH)
      AND
      ausleihen.rueckgabe_datum > DATE_SUB(now(), INTERVAL 36 MONTH)
      group by Film.film_id;


      (SELECT kunde.vorname'Ummsatz', kunde.nachname'2021', SUM(ausleihen.ausleihe_preis) AS Umsatz_Kunde
          FROM kunde
          JOIN ausleihen ON kunde.kunde_id = ausleihen.kunde_id
          WHERE YEAR(ausleihen.rueckgabe_datum) = 2021
          GROUP BY kunde.kunde_id
          ORDER BY Umsatz_Kunde DESC
          LIMIT 10)

      union all

      select '--------', '---------------', '-------------'
      union all
      select 'Umsatz', '2020', ''
      union all
      select '--------', '---------------', '-------------'

      union all

      (SELECT kunde.vorname, kunde.nachname, SUM(ausleihen.ausleihe_preis) AS Umsatz_Kunde
          FROM kunde
          JOIN ausleihen ON kunde.kunde_id = ausleihen.kunde_id
          WHERE YEAR(ausleihen.rueckgabe_datum) = 2020
          GROUP BY kunde.kunde_id
          ORDER BY Umsatz_Kunde DESC
          LIMIT 10)

      union all

      select '--------', '---------------', '-------------'
      union all
      select 'Umsatz', '2019', ''
      union all
      select '--------', '---------------', '-------------'

      union all

      (SELECT kunde.vorname, kunde.nachname, SUM(ausleihen.ausleihe_preis) AS Umsatz_Kunde
      FROM kunde
      JOIN ausleihen ON kunde.kunde_id = ausleihen.kunde_id
      WHERE YEAR(ausleihen.rueckgabe_datum) = 2019
      GROUP BY kunde.kunde_id
      ORDER BY Umsatz_Kunde DESC
      LIMIT 10);


      select
        Kategorie.kategorie_name'Anzahl Filme pro Kategorie', count(Film.kategorie_id)''
      from
       Film
        inner join Kategorie on Film.kategorie_id = Kategorie.kategorie_id
        group by Kategorie.kategorie_id

      union all

      select '-----------------------------------------------', '--------------------'

      union all

      select 'Anzahl Ausleihen pro Kategorie', ' '

      union all

      select '-----------------------------------------------', '--------------------'

      union all
          select
            Kategorie.kategorie_name, count(ausleihen.ausleih_id)
          from
          ausleihen
            right join Film on ausleihen.film_id = Film.film_id
            left join Kategorie on Film.kategorie_id = Kategorie.kategorie_id
            group by Kategorie.kategorie_id;
