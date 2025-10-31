# COVID-19-Global-Data-Analysis-SQL-Power-BI

##  Project Overview
This project analyzes **global COVID-19 data** using **SQL** and visualizes the results in **Power BI**.  
It provides insights into worldwide cases, deaths, recoveries, testing rates, and regional comparisons.  

The dataset was sourced from **Worldometer COVID-19 Statistics** and processed using **PostgreSQL** before visualization.

##  Objectives
- Analyze the global impact of COVID-19 by country and continent.  
- Compare total, active, and recovered cases.  
- Identify countries with the highest testing and recovery rates.  
- Evaluate death-to-case ratios across continents.  
- Create a Power BI dashboard for clear, interactive visualization.

---

##  Data Details
- **Source:** Worldometer (2023 snapshot)  
- **Format:** CSV file  
- **Rows:** ~230 countries  
- **Columns:**  
  `Country`, `Continent`, `Population`, `TotalCases`, `TotalDeaths`, `TotalRecovered`, `ActiveCases`, `Serious_Critical`,  
  `Tot_Cases_per_1M`, `Deaths_per_1M_pop`, `TotalTests`, `Tests_per_1M_pop`, `WHO_Region`

---

##  Data Analysis (SQL)

**Tool:** PostgreSQL  

### Database Setup
```sql
CREATE TABLE covid (
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
    WHO_Region VARCHAR(100)
);
```
## Key Queries
1 Total Global Cases and Deaths
```
SELECT
    ROUND(SUM(TotalCases)) AS global_cases,
    ROUND(SUM(TotalDeaths)) AS global_deaths,
    ROUND((SUM(TotalDeaths)/SUM(TotalCases))*100,2) AS Global_Death_rate
FROM covid;
```
2️ Top 10 Countries by Cases
```
SELECT Country, Continent, TotalCases
FROM covid
ORDER BY TotalCases DESC
LIMIT 10;
```
3️  Continent-Wise Summary
```
SELECT Continent,
       SUM(TotalCases) AS total_cases,
       SUM(TotalDeaths) AS total_deaths,
       ROUND((SUM(TotalDeaths)/SUM(TotalCases))*100,2) AS death_rate
FROM covid
WHERE Continent IS NOT NULL
GROUP BY Continent
ORDER BY total_cases DESC;
```
4️  Highest Recovery Rates
```
SELECT Country, Continent,
       ROUND(((COALESCE(TotalRecovered,0)/COALESCE(TotalCases,1))*100),2) AS Recovery_rate
FROM covid
ORDER BY Recovery_rate DESC
LIMIT 10;
```

**SQL Script:**[covid19.sql](SQL/covid19.sql)

###  Visualization (Power BI)

**Tool:** Power BI Desktop
**File: **[covid19.pbix](Dashboard/covid19.pbix)

Dashboard Highlights
KPI	Value (approx.)
- Total Cases	762 Million
- Total Deaths	6.9 Million
- Total Recovered	740 Million
- Total Tests Conducted	13.4 Billion
- Continents Covered	6

## Key Visuals
- Global Overview Cards (Total Cases, Deaths, Recovered)
- Top 10 Countries by Cases and Deaths
- Active vs Recovered Case Comparison
- Continent-wise Death Rate Chart
- Testing Rate vs Death Rate Correlation
- Serious/Critical Case Distribution

**Report:**[ covid19.pdf](Report/covid19.pdf)

** Dashboard Preview**
<p align="center"> <img src="Images/covid_dashboard_main.png" width="700"><br> <em>COVID-19 Global Overview Dashboard</em> </p> <p align="center"> <img src="Images/covid_top10.png" width="700"><br> <em>Top 10 Countries by Cases and Deaths</em> </p> <p align="center"> <img src="Images/covid_continent_summary.png" width="700"><br> <em>Continent-wise Case Distribution</em> </p>

**Key Insights**

- USA, India, and France record the highest total cases globally.
- Asia and Europe have the largest case volumes, but Europe shows higher mortality rates.
- Recovery rate globally is over 96%, indicating improved healthcare responses.
- Testing rates are highest in developed countries like the USA and UK.
- Africa and Oceania show lower total cases and fatalities due to population density and containment measures.

## Tools & Technologies

**PostgreSQL**	Data extraction and aggregation
**Power BI**	Visualization and interactive dashboard
**Excel/CSV	**Data source format
**DAX	**Calculated fields and measures
Data Storytelling	Turning analysis into insights

## Learnings
- Designed and implemented SQL analytical queries for large datasets.
- Built interactive dashboards combining metrics and visuals.
- Strengthened understanding of global pandemic data trends and analytics workflow.

## Future Improvements
- Automate daily COVID-19 data updates via Power BI API refresh.
- Integrate vaccination and hospitalization data for deeper insights.
- Add forecast models using Python and integrate with Power BI.
-
- ## Author
Insherah Majid
 B.Tech in Information Technology
 Data Analyst | SQL | Power BI | Data Storytelling
 Srinagar, Kashmir

🔗 LinkedIn
 (www.linkedin.com/in/insherah-majid-146496317)
 insherahmajid81@gmail.com
 

 Feedback

If you found this project helpful or interesting, please ⭐ star the repository and connect with me on LinkedIn!







