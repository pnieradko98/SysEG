/*
Model: PostgreSQL 9.0
Database: PostgreSQL 9.0
*/

-- Create tables section -------------------------------------------------

-- Table dane_organizacyjne

CREATE TABLE dane_organizacyjne
(
  id Serial NOT NULL,
  uczelnia Character varying NOT NULL,
  jednostka_organizacyjna Character varying,
  kierunek Character varying NOT NULL,
  specjalnosc Character varying,
  forma_studiow Character varying NOT NULL,
  stopien_studiow Character varying NOT NULL,
  rok_rozpoczecia Character varying NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE dane_organizacyjne ADD CONSTRAINT PK_dane_organizacyjne PRIMARY KEY (id)
;
-- Table dane_egzaminu

CREATE TABLE dane_egzaminu
(
  id Serial NOT NULL,
  rok_akademicki Character varying(10) NOT NULL,
  semestr Character varying(2) NOT NULL,
  egzaminator Character varying NOT NULL,
  przedmiot Character varying NOT NULL,
  rodzaj_zajec Character varying(30) NOT NULL,
  forma_zaliczenia Character varying(15) NOT NULL,
  punkty_ects Character varying(2) NOT NULL,
  id_dane_organizacyjne Integer,
  data_egzaminu Date NOT NULL,
  nr_podejscia Integer NOT NULL,
  ilosc_zadan Integer NOT NULL,
  ilosc_odpowiedzi Integer NOT NULL,
  czas_trwania Time NOT NULL,
  pkt_dost Integer NOT NULL,
  pkt_dstplus Integer NOT NULL,
  pkt_db Integer NOT NULL,
  pkt_dbplus Integer NOT NULL,
  pkt_bdb Integer NOT NULL,
  pkt_zal Integer NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship41 ON dane_egzaminu (id_dane_organizacyjne)
;
ALTER TABLE dane_egzaminu ADD CONSTRAINT PK_dane_egzaminu PRIMARY KEY (id)
;
-- Table odpowiedzi

CREATE TABLE odpowiedzi
(
  id Serial NOT NULL,
  nr_pytania Integer NOT NULL,
  wartosc_odpowiedzi Boolean,
  czas_dodania Time NOT NULL,
  id_punkty Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship16 ON odpowiedzi (id_punkty)
;
ALTER TABLE odpowiedzi ADD CONSTRAINT PK_odpowiedzi PRIMARY KEY (id)
;
-- Table zestawy_zadan

CREATE TABLE zestawy_zadan
(
  id Serial NOT NULL,
  data_wygenerowania Date NOT NULL,
  godzina_wygenerowania Time NOT NULL,
  nr_zestawu Integer NOT NULL,
  id_dane_egzaminu Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship51 ON zestawy_zadan (id_dane_egzaminu)
;
ALTER TABLE zestawy_zadan ADD CONSTRAINT PK_zestawy_zadan PRIMARY KEY (id)
;
-- Table punkty

CREATE TABLE punkty
(
  id Serial NOT NULL,
  nr_zadania Integer NOT NULL,
  id_wyniki Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship18 ON punkty (id_wyniki)
;
ALTER TABLE punkty ADD CONSTRAINT PK_punkty PRIMARY KEY (id)
;
-- Table wyniki

CREATE TABLE wyniki
(
  id Serial NOT NULL,
  liczba_punktow Integer NOT NULL,
  komentarz Character varying,
  data_rozpoczecia Date,
  godz_rozpoczecia Time,
  godz_zakonczenia Time,
  punkty_dodatkowe Integer,
  komentarz_punkty Character varying,
  id_zestawy_zadan Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship66 ON wyniki (id_zestawy_zadan)
;
ALTER TABLE wyniki ADD CONSTRAINT PK_wyniki PRIMARY KEY (id)
;
-- Table protokol

CREATE TABLE protokol
(
  id Serial NOT NULL,
  termin Character varying(10) NOT NULL,
  ocena Character varying(3) NOT NULL,
  data_wpisu Date NOT NULL,
  ocena_przepisana Boolean,
  data_zaliczenia Date,
  id_student Integer,
  id_dane_egzaminu Integer,
  id_wyniki Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship12 ON protokol (id_student)
;
CREATE INDEX IX_Relationship30 ON protokol (id_dane_egzaminu)
;
CREATE INDEX IX_Relationship48 ON protokol (id_wyniki)
;
ALTER TABLE protokol ADD CONSTRAINT PK_protokol PRIMARY KEY (id)
;
-- Table pytania

CREATE TABLE pytania
(
  id Serial NOT NULL,
  tresc_odpowiedzi Character varying NOT NULL,
  wartosc_odpowiedzi Boolean NOT NULL,
  data_utworzenia Date NOT NULL,
  data_wygasniecia Date,
  id_zadania Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship33 ON pytania (id_zadania)
;
ALTER TABLE pytania ADD CONSTRAINT PK_pytania PRIMARY KEY (id)
;
-- Table zadania

CREATE TABLE zadania
(
  id Serial NOT NULL,
  tresc_zadania Character varying NOT NULL,
  data_utworzenia Date NOT NULL,
  data_wygasniecia Date,
  autor Character varying NOT NULL,
  id_podkategoria Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship26 ON zadania (id_podkategoria)
;
ALTER TABLE zadania ADD CONSTRAINT PK_zadania PRIMARY KEY (id)
;
-- Table podkategoria

CREATE TABLE podkategoria
(
  id Serial NOT NULL,
  nazwa_podkategorii Character varying,
  data_utworzenia Date,
  data_wygasniecia Date,
  id_kategoria Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship27 ON podkategoria (id_kategoria)
;
ALTER TABLE podkategoria ADD CONSTRAINT PK_podkategoria PRIMARY KEY (id)
;
-- Table kategoria

CREATE TABLE kategoria
(
  id Serial NOT NULL,
  nazwa_kategorii Character varying NOT NULL,
  data_utworzenia Date NOT NULL,
  data_wygasniecia Date,
  id_przedmiot Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship43 ON kategoria (id_przedmiot)
;
ALTER TABLE kategoria ADD CONSTRAINT PK_kategoria PRIMARY KEY (id)
;
-- Table przedmiot

CREATE TABLE przedmiot
(
  id Serial NOT NULL,
  nazwa_przedmiotu Character varying(50) NOT NULL,
  data_utworzenia Date NOT NULL,
  data_wygasniecia Date
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE przedmiot ADD CONSTRAINT PK_przedmiot PRIMARY KEY (id)
;
-- Table student

CREATE TABLE student
(
  id Serial NOT NULL,
  imie Character varying(20) NOT NULL,
  nazwisko Character varying(30) NOT NULL,
  nr_indeksu Character varying(8) NOT NULL,
  czy_studiuje Boolean NOT NULL,
  id_dane_organizacyjne Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship62 ON student (id_dane_organizacyjne)
;
ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id)
;
-- Table login_panel

CREATE TABLE login_panel
(
  id Serial NOT NULL,
  login Character varying(30) NOT NULL,
  haslo Character varying(30) NOT NULL,
  imie Character varying(20) NOT NULL,
  nazwisko Character varying(30) NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE login_panel ADD CONSTRAINT PK_login_panel PRIMARY KEY (id)
;
ALTER TABLE login_panel ADD CONSTRAINT login UNIQUE (login)
;
ALTER TABLE login_panel ADD CONSTRAINT haslo UNIQUE (haslo)
;
-- Table numery_zadan

CREATE TABLE numery_zadan
(
  id Serial NOT NULL,
  nr_zadania Integer NOT NULL,
  tresc_zadania Character varying NOT NULL,
  id_zestawy_zadan Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship63 ON numery_zadan (id_zestawy_zadan)
;
ALTER TABLE numery_zadan ADD CONSTRAINT PK_numery_zadan PRIMARY KEY (id)
;
-- Table numery_odpowiedzi

CREATE TABLE numery_odpowiedzi
(
  id Serial NOT NULL,
  nr_pytania Integer NOT NULL,
  tresc_pytania Character varying NOT NULL,
  wartosc_pytania Boolean NOT NULL,
  id_numery_zadan Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship53 ON numery_odpowiedzi (id_numery_zadan)
;
ALTER TABLE numery_odpowiedzi ADD CONSTRAINT PK_numery_odpowiedzi PRIMARY KEY (id)
;
-- Table zestaw_zadan_student

CREATE TABLE zestaw_zadan_student
(
  id Serial NOT NULL,
  id1 Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship60 ON zestaw_zadan_student (id1)
;
ALTER TABLE zestaw_zadan_student ADD CONSTRAINT PK_zestaw_zadan_student PRIMARY KEY (id)
;
-- Table zestawy_zadan_odpowiedzi

CREATE TABLE zestawy_zadan_odpowiedzi
(
  id Serial NOT NULL,
  nr_zadania Integer NOT NULL,
  wartosc_odpowiedzi Boolean,
  id1 Integer,
  id2 Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship59 ON zestawy_zadan_odpowiedzi (id1)
;
CREATE INDEX IX_Relationship61 ON zestawy_zadan_odpowiedzi (id2)
;
ALTER TABLE zestawy_zadan_odpowiedzi ADD CONSTRAINT PK_zestawy_zadan_odpowiedzi PRIMARY KEY (id)
;
-- Table student_zestaw

CREATE TABLE student_zestaw
(
  id Serial NOT NULL,
  status Character varying(1) NOT NULL,
  id_student Integer,
  id_zestawy_zadan Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship64 ON student_zestaw (id_student)
;
CREATE INDEX IX_Relationship65 ON student_zestaw (id_zestawy_zadan)
;
ALTER TABLE student_zestaw ADD CONSTRAINT PK_student_zestaw PRIMARY KEY (id)
;

-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE protokol ADD CONSTRAINT Relationship48 FOREIGN KEY (id_wyniki) REFERENCES wyniki (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE kategoria ADD CONSTRAINT Relationship43 FOREIGN KEY (id_przedmiot) REFERENCES przedmiot (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE dane_egzaminu ADD CONSTRAINT Relationship41 FOREIGN KEY (id_dane_organizacyjne) REFERENCES dane_organizacyjne (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE pytania ADD CONSTRAINT Relationship33 FOREIGN KEY (id_zadania) REFERENCES zadania (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE protokol ADD CONSTRAINT Relationship30 FOREIGN KEY (id_dane_egzaminu) REFERENCES dane_egzaminu (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE podkategoria ADD CONSTRAINT Relationship27 FOREIGN KEY (id_kategoria) REFERENCES kategoria (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE zadania ADD CONSTRAINT Relationship26 FOREIGN KEY (id_podkategoria) REFERENCES podkategoria (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE punkty ADD CONSTRAINT Relationship18 FOREIGN KEY (id_wyniki) REFERENCES wyniki (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE odpowiedzi ADD CONSTRAINT Relationship16 FOREIGN KEY (id_punkty) REFERENCES punkty (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE protokol ADD CONSTRAINT Relationship12 FOREIGN KEY (id_student) REFERENCES student (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE zestawy_zadan ADD CONSTRAINT Relationship51 FOREIGN KEY (id_dane_egzaminu) REFERENCES dane_egzaminu (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE numery_odpowiedzi ADD CONSTRAINT Relationship53 FOREIGN KEY (id_numery_zadan) REFERENCES numery_zadan (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE zestawy_zadan_odpowiedzi ADD CONSTRAINT Relationship59 FOREIGN KEY (id1) REFERENCES zestaw_zadan_student (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE zestaw_zadan_student ADD CONSTRAINT Relationship60 FOREIGN KEY (id1) REFERENCES zestawy_zadan (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE zestawy_zadan_odpowiedzi ADD CONSTRAINT Relationship61 FOREIGN KEY (id2) REFERENCES numery_odpowiedzi (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE student ADD CONSTRAINT Relationship62 FOREIGN KEY (id_dane_organizacyjne) REFERENCES dane_organizacyjne (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE numery_zadan ADD CONSTRAINT Relationship63 FOREIGN KEY (id_zestawy_zadan) REFERENCES zestawy_zadan (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE student_zestaw ADD CONSTRAINT Relationship64 FOREIGN KEY (id_student) REFERENCES student (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE student_zestaw ADD CONSTRAINT Relationship65 FOREIGN KEY (id_zestawy_zadan) REFERENCES zestawy_zadan (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;



ALTER TABLE wyniki ADD CONSTRAINT Relationship66 FOREIGN KEY (id_zestawy_zadan) REFERENCES zestawy_zadan (id) ON DELETE NO ACTION ON UPDATE NO ACTION
;





