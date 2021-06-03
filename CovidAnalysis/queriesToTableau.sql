/*
 *	Author: Danny Lillard
 *	Date: 5/31/2021
 *	Desc: Queries for covid data analysis project, these ones go into tableau.
 */



--getting current death rate for world.
SELECT location, MAX(total_cases), MAX(total_deaths), 
(MAX(total_deaths)/MAX(total_cases))*100 AS average_daily_global_death_rate
FROM covid_data
WHERE location = 'World';

--continent deaths
--Here is another solution.
--Uses a with statement.
WITH location_dead AS ( 
    SELECT continent, location, MAX(Total_deaths) AS location_deaths
    FROM covid_data
    GROUP BY location
)
SELECT continent, SUM(location_dead.location_deaths) 
FROM location_dead
WHERE continent != ''
GROUP BY continent;

--population infected per country
SELECT location, population, MAX(total_cases), 
MAX((total_cases)/population)*100 AS infection_rate
FROM covid_data
GROUP BY location
ORDER BY infection_rate DESC;

--population infected per country, with date
SELECT location, date, population, MAX(total_cases), 
MAX((total_cases)/population)*100 AS infection_rate
FROM covid_data
GROUP BY location
ORDER BY infection_rate DESC;


---------------------------------------------------------
--Own work from here on.

--infection rate v.s. gdp
SELECT location, MAX(total_cases), population, 
(MAX(total_cases)/population)*100 AS infection_rate,
gdp_per_capita
FROM covid_data
GROUP BY location ORDER BY gdp_per_capita DESC;

--highest death rates vs gdp
SELECT location, MAX(total_deaths), MAX(total_cases), 
(MAX(total_deaths)/MAX(total_cases))*100 AS death_rate,
gdp_per_capita
FROM covid_data
GROUP BY location ORDER BY gdp_per_capita DESC;

--Checking infection rates based on population density and gdp
SELECT location, MAX(total_cases), population, 
(MAX(total_cases)/population)*100 AS infection_rate,
population_density/gdp_per_capita*100 AS density_gdp
FROM covid_data
WHERE continent != ''
GROUP BY location ORDER BY density_gdp DESC;

--highest death rates vs extreme poverty
SELECT location, MAX(total_deaths), MAX(total_cases), 
(MAX(total_deaths)/MAX(total_cases))*100 AS death_rate,
extreme_poverty
FROM covid_data
GROUP BY location ORDER BY extreme_poverty DESC;