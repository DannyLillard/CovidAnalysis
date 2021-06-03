/*
 *	Author: Danny Lillard
 *	Date: 5/26/2021
 *	Desc: Queries for covid data analysis project.
 */

--basic get all
SELECT * 
FROM covid_data 
LIMIT 100;

----------------------------------------------------
--breaking down by country 
-- ensure that sql keywords are not used for column names for future projects...
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM covid_data;

-- death rate US
SELECT location, date, total_cases, total_deaths, 
(total_deaths/total_cases)*100 AS death_percent_rate
FROM covid_data
WHERE location = 'United States';

--total cases vs population, US
SELECT location, date, total_cases, population, 
(total_cases/population)*100 AS infection_rate
FROM covid_data
WHERE location = 'United States';

--highest infection rates
SELECT location, MAX(total_cases), population, 
(MAX(total_cases)/population)*100 AS infection_rate
FROM covid_data
GROUP BY location ORDER BY infection_rate DESC;

--highest death rates
SELECT location, MAX(total_deaths), MAX(total_cases), 
(MAX(total_deaths)/MAX(total_cases))*100 AS death_rate
FROM covid_data
GROUP BY location ORDER BY death_rate DESC;

--Contries with the best vaccination rate, as a note, 
-- total_vaccinations == Total number of COVID-19 vaccination doses administered
--So we cannot use it to get the rate of vaccinated people.
SELECT location, MAX(people_vaccinated), population, 
(MAX(people_vaccinated)/population)*100 AS vaccination_rate
FROM covid_data
GROUP BY location ORDER BY vaccination_rate DESC;

SELECT location, MAX(people_fully_vaccinated), population, 
(MAX(people_fully_vaccinated)/population)*100 AS full_vaccination_rate
FROM covid_data
GROUP BY location ORDER BY full_vaccination_rate DESC;

--population infected per country
SELECT location, population, MAX(total_cases), 
MAX((total_cases)/population)*100 AS infection_rate
FROM covid_data
GROUP BY location
ORDER BY infection_rate DESC;
-------------------------------------------------------------------------------
--Breaking this down by continents

--Death rate
SELECT location, MAX(Total_deaths) AS continent_deaths, population, 
(MAX(total_deaths)/population)*100 AS death_rate
FROM covid_data
WHERE continent = ''
GROUP BY location ORDER BY continent_deaths DESC;

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

-----------------------------------------------------------------
--Global numbers
--Alex here does not use the 'World' Location, I do
SELECT location, date, total_cases, total_deaths, 
(total_deaths/total_cases)*100 AS daily_global_death_rate
FROM covid_data
WHERE location = 'World';

--getting average death rate for world.
SELECT location, AVG(total_cases), AVG(total_deaths), 
(AVG(total_deaths)/AVG(total_cases))*100 AS average_daily_global_death_rate
FROM covid_data
WHERE location = 'World';

--getting max death rate for world.
SELECT location, MAX(total_cases), MAX(total_deaths), 
(MAX(total_deaths)/MAX(total_cases))*100 AS average_daily_global_death_rate
FROM covid_data
WHERE location = 'World';

--World vaccinations
SELECT location, total_vaccinations
FROM covid_data
WHERE location = 'World';

--sums vaccines rolling for each country.
Select continent, location, date, population, new_vaccinations
, SUM(new_vaccinations) OVER (Partition by Location Order by location, Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From covid_data
where continent is not null;

-----------------------------------------------------------------------------------
--Views
CREATE VIEW CountryVaccinations AS
SELECT location, MAX(people_fully_vaccinated), population, 
(MAX(people_fully_vaccinated)/population)*100 AS full_vaccination_rate
FROM covid_data
GROUP BY location ORDER BY full_vaccination_rate DESC;
-----------------------------------------------------------------------------------
-- Own work from here on.
--Specifically looking at income v.s. death, infection, etc.

--highest infection rates vs gdp
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

--highest infection rates vs gdp in Europe
SELECT location, MAX(total_cases), population, 
(MAX(total_cases)/population)*100 AS infection_rate,
gdp_per_capita
FROM covid_data
WHERE continent = 'Europe'
GROUP BY location ORDER BY gdp_per_capita DESC;

--highest death rates vs gdp in Europe
SELECT location, MAX(total_deaths), MAX(total_cases), 
(MAX(total_deaths)/MAX(total_cases))*100 AS death_rate,
gdp_per_capita
FROM covid_data
WHERE continent = 'Europe'
GROUP BY location ORDER BY gdp_per_capita DESC;

--highest infection rates vs hdi
SELECT location, MAX(total_cases), population, 
(MAX(total_cases)/population)*100 AS infection_rate,
human_development_index
FROM covid_data
GROUP BY location ORDER BY human_development_index DESC;

--highest death rates vs hdi
SELECT location, MAX(total_deaths), MAX(total_cases), 
(MAX(total_deaths)/MAX(total_cases))*100 AS death_rate,
human_development_index
FROM covid_data
GROUP BY location ORDER BY human_development_index DESC;

--highest infection rates vs extreme poverty
SELECT location, MAX(total_cases), population, 
(MAX(total_cases)/population)*100 AS infection_rate,
extreme_poverty
FROM covid_data
GROUP BY location ORDER BY extreme_poverty DESC;

--highest death rates vs extreme poverty
SELECT location, MAX(total_deaths), MAX(total_cases), 
(MAX(total_deaths)/MAX(total_cases))*100 AS death_rate,
extreme_poverty
FROM covid_data
GROUP BY location ORDER BY extreme_poverty DESC;


--checking if stringency_index has correlation with infection rates.
SELECT location, MAX(total_cases), population, 
(MAX(total_cases)/population)*100 AS infection_rate,
stringency_index
FROM covid_data
GROUP BY location ORDER BY stringency_index DESC;

--Checking infection rates based on population density and gdp
SELECT location, MAX(total_cases), population, 
(MAX(total_cases)/population)*100 AS infection_rate,
population_density/gdp_per_capita*100 AS density_gdp
FROM covid_data
WHERE continent != ''
GROUP BY location ORDER BY density_gdp DESC;