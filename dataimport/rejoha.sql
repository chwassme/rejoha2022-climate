--connect to the DB. the password is on the yellow post-it
psql -d climate -U climate -h dedi964.your-server.de

--Michael has a view that depends on that
CREATE TABLE electricity (measure timestamp with time zone, load float, year int, month int, week int);
CREATE TABLE flights (day date, category varchar(50), passengers int, flights int);
CREATE TABLE bikes (bikes int, year int, month int, day int, hourfrom int, dayofyear int);
CREATE TABLE pedestrians (pedestrians int, year int, month int, day int, hourfrom varchar(20), dayofyear int);
CREATE TABLE public_transport (week_start_day date, riders int, calendarweek int);
CREATE TABLE trees (tree_species varchar(100), planting_date date, tree_age_total int, tree_age_planted int, protection_status varchar(50), location varchar(50), tree_group varchar(50), municipality varchar(20));
CREATE TABLE weather (year int, month int, temperature float, precipitation float);

\copy electricity FROM '/home/luca/Downloads/100233.csv' csv header;
\copy flights FROM '/home/luca/Downloads/100078.csv' csv header;
\copy bikes FROM '/home/luca/Downloads/100013-1.csv' csv header;
\copy pedestrians FROM '/home/luca/Downloads/100013.csv' csv header;
\copy public_transport FROM '/home/luca/Downloads/100075.csv' csv header;
\copy trees FROM '/home/luca/Downloads/100052.csv' csv header;
\copy weather FROM '/home/luca/Downloads/homog_mo_BAS.txt' csv header;

UPDATE trees SET tree_age_total = NULL WHERE tree_age_total < 0;
UPDATE trees SET tree_age_planted = NULL WHERE tree_age_planted < 0;

--only look at passenger travel.
--keeping both columns so that if we want, we can calculate passengers per flight averages
CREATE VIEW passenger_flights AS SELECT day, passengers, flights FROM flights WHERE category = 'Passagierverkehr';

--aggregate the hourly bike/pedestrian data per day
CREATE VIEW bikes_per_day AS SELECT SUM(bikes), year, month, day, dayofyear FROM bikes GROUP BY year, month, day, dayofyear;
CREATE VIEW pedestrians_per_day AS SELECT SUM(pedestrians), year, month, day, dayofyear FROM pedestrians GROUP BY year, month, day, dayofyear;

--for the trees, we guess that tree_age_total means the age since the tree was planted as a seed, and tree_age_planted means the age since the protected tree ("Baumschule") has been planted in the wild
