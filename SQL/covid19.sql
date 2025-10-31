create table covid(
Country VARCHAR(100),
Continent VARCHAR(100),
Population NUMERIC,
TotalCases NUMERIC,
NewCases NUMERIC,
TotalDeaths NUMERIC,
NewDeaths NUMERIC,
TotalRecovered NUMERIC,
NewRecovered NUMERIC,
ActiveCases NUMERIC,
Serious_Critical NUMERIC,
Tot_Cases_per_1M NUMERIC,
Deaths_per_1M_pop NUMERIC,
TotalTests NUMERIC,
Tests_per_1M_pop NUMERIC,
WHO_Region NUMERIC
);
alter table covid
alter column WHO_Region type VARCHAR(100); 

COPY covid(Country,Continent,Population,TotalCases,NewCases,TotalDeaths,NewDeaths,TotalRecovered,NewRecovered,ActiveCases,Serious_Critical,Tot_Cases_per_1M ,Deaths_per_1M_pop,TotalTests,Tests_per_1M_pop,WHO_Region) 
FROM 'C:\Users\Nyla Majid\Downloads\worldometer_data.csv' 
CSV HEADER;

SELECT COUNT(*) FROM covid;

--Total Global Cases & Deaths
SELECT
    ROUND(SUM(TotalCases)) AS global_cases,
	ROUND(SUM(TotalDeaths)) AS global_deaths,
	ROUND((SUM(TotalDeaths)/SUM(TotalCases))*100,2) AS GLobal_Death_rate 
FROM covid;

--Top 10 Countries by Total Cases
SELECT 
 Country,Continent ,TotalCases
FROM covid
ORDER BY TotalCases desc
LIMIT 10;


--Top 10 countries with Active cases
SELECT Country,Continent, ActiveCases
FROM covid
WHERE ActiveCases is not null
ORDER BY ActiveCases DESC
LIMIT 10;


--Top10 countries by death rates
Select
 Country,Continent,
 ROUND(((COALESCE(TotalDeaths,0)/COALESCE(TotalCases,1))*100),2) AS Death_rate
From covid
ORDER BY Death_rate DESC
LIMIT 10;


--Top10 countries by Recovery rates
Select
 Country,Continent,
 ROUND(((COALESCE(TotalRecovered,0)/COALESCE(TotalCases,1))*100),2) AS Recovery_rate
From covid
ORDER BY Recovery_rate DESC
LIMIT 10;

--Active Case Percentage

Select
 Country,Continent,
 ROUND(((COALESCE(ActiveCases,0)/COALESCE(TotalCases,1))*100),2) AS Active_Cases
From covid
ORDER BY Active_Cases DESC
LIMIT 10;

--Cases per million population
SELECT Country,Tot_Cases_per_1M
FROM covid
WHERE Tot_Cases_per_1M is not null
ORDER BY Tot_Cases_per_1M DESC 
LIMIT 10;

--Serious/Critical cases
SELECT Country,Continent,Serious_Critical
FROM covid
WHERE Serious_Critical is not null
ORDER BY Serious_Critical DESC 
LIMIT 10;



--Continent Wise summary

SELECT Continent,
       SUM(TotalCases) AS total_cases,
       SUM(TotalDeaths) AS total_deaths,
       ROUND((SUM(TotalDeaths)/SUM(TotalCases))*100,2) AS death_rate
FROM covid
WHERE Continent IS NOT NULL
GROUP BY Continent
ORDER BY total_cases DESC;

--Highest Testing Rate Countries
Select
 Country,Continent,
 ROUND(((COALESCE(TotalTests,0)/COALESCE(Population,1))*100),2) AS Testing_rate
From covid
ORDER BY Testing_rate DESC
LIMIT 10;

----deaths vs Testing Correlation Preview
Select
 Country,Continent,
 ROUND(((COALESCE(TotalDeaths,0)/COALESCE(TotalCases,1))*100),2) AS Death_rate,
 ROUND(((COALESCE(TotalTests,0)/COALESCE(Population,1))*100),2) AS Testing_rate,
 ROUND(((COALESCE(TotalRecovered,0)/COALESCE(TotalCases,1))*100),2) AS Recovery_rate
From covid
ORDER BY Testing_rate DESC
LIMIT 10;









