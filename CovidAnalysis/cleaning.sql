/*
 *	Author: Danny Lillard
 *	Date: 6/1/2021
 *	Desc: Data cleaning and manipulation for the covid dataset.
 */
-----------------------------------------------
--Filling in empty gdp data

--getting all empty gdp's
SELECT location, gdp_per_capita
FROM covid_data
WHERE gdp_per_capita = ''
GROUP BY location;

--setting the andorra gdp per capita
UPDATE covid_data
SET gdp_per_capita = 40886.39
WHERE location = 'Andorra';

--Bonaire Sint Eustatius and Sab(a)
UPDATE covid_data
SET gdp_per_capita = 19000.00
WHERE location = 'Bonaire Sint Eustatius and Sab';

--Cuba
UPDATE covid_data
SET gdp_per_capita = 8821.82
WHERE location = 'Cuba';

--Curacao
UPDATE covid_data
SET gdp_per_capita = 19689.14
WHERE location = 'Curacao';

--Faeroe Islands
UPDATE covid_data
SET gdp_per_capita = 64269.70
WHERE location = 'Faeroe Islands';

--Falkland Islands
UPDATE covid_data
SET gdp_per_capita = 77692.00
WHERE location = 'Falkland Islands';

--French Polynesia
UPDATE covid_data
SET gdp_per_capita = 14323.82
WHERE location = 'French Polynesia';

--Gibraltar
UPDATE covid_data
SET gdp_per_capita = 92843.00
WHERE location = 'Gibraltar';

--Greenland
UPDATE covid_data
SET gdp_per_capita = 54470.96
WHERE location = 'Greenland';

--Guernsey
UPDATE covid_data
SET gdp_per_capita = 42037.16
WHERE location = 'Guernsey';

--Isle of Man
UPDATE covid_data
SET gdp_per_capita = 89108.43
WHERE location = 'Isle of Man';

--Jersey
UPDATE covid_data
SET gdp_per_capita = 55324
WHERE location = 'Jersey';

--Monaco
UPDATE covid_data
SET gdp_per_capita = 185829.02
WHERE location = 'Monaco';

--Liechtenstein
UPDATE covid_data
SET gdp_per_capita = 181402.83
WHERE location = 'Liechtenstein';

--Montserrat
UPDATE covid_data
SET gdp_per_capita = 11340
WHERE location = 'Montserrat';

--New Caledonia
UPDATE covid_data
SET gdp_per_capita = 12579.60
WHERE location = 'New Caledonia';

--Northern Cyprus
UPDATE covid_data
SET gdp_per_capita = 14942
WHERE location = 'Northern Cyprus';

--Oceania
UPDATE covid_data
SET gdp_per_capita = 22647
WHERE location = 'Oceania';

--Saint Helena
UPDATE covid_data
SET gdp_per_capita = 12230
WHERE location = 'Saint Helena';

--Somalia
UPDATE covid_data
SET gdp_per_capita = 126.92
WHERE location = 'Somalia';

--Syria
UPDATE covid_data
SET gdp_per_capita = 2032.62
WHERE location = 'Syria';

--Taiwan
UPDATE covid_data
SET gdp_per_capita = 25873
WHERE location = 'Taiwan';

--Turks and Caicos Islands
UPDATE covid_data
SET gdp_per_capita = 31353.33
WHERE location = 'Turks and Caicos Islands';

--Vatican
UPDATE covid_data
SET gdp_per_capita = 21198
WHERE location = 'Vatican';

--Wallis and Futuna
UPDATE covid_data
SET gdp_per_capita = 3800
WHERE location = 'Wallis and Futuna';