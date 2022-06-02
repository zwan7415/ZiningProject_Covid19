-- Aim: analysis Covid 19 data from 2020 - May 2022, and ready for tableau data visualization 
-- data is clearned provied by https://ourworldindata.org/coronavirus
--Query data, transfer result to excel

-- inspection data
select *
from ZiningProject..[covid-dataset]
order by 3,4

--Q1 calculate total case/ total death from day to day

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPrecentage
from ZiningProject..[covid-dataset]
where continent is not null
order by 1,2

--Q2 calculation infection rate % 

select location, date,  population,total_cases, (total_cases/population)*100 as InfectionPrecentage
from ZiningProject..[covid-dataset]
where continent is not null
order by 1,2

--Q3 find countries with highest infection rate% untill May 2022
select location, population, max(total_cases) as InfectionCount, max(total_cases/population)*100 as MaxInfectionPrecentage
from ZiningProject..[covid-dataset]
where continent is not null
group by location, population
order by MaxInfectionPrecentage desc

--Q4 find death rate% untill May 2022 for each countries
select location, population, max(total_cases) as InfectionCount, max(total_deaths) as DeathCount,max(total_cases/population)*100 as DeathPrecentage
from ZiningProject..[covid-dataset]
where continent is not null
group by location,population
order by DeathCount desc

--Q5 find Full_vaccination rate% untill 2022 for each country
create view Vaccinated_rate as
select continent, location, population, max(people_vaccinated)as Dose_administered, (max(people_vaccinated)/population)*100 as Dose_administered_rate, 
max(people_fully_vaccinated)as people_fully_vaccinated, (max(people_fully_vaccinated)/population)*100 as Full_vaccination_rate
from ZiningProject..[covid-dataset]
where continent is not null
group by continent, location,population
--order by 