# Formula 1 Performance Analysis

## 1. Project Overview

- **Database:** formula1_analysis
- **Analysis Period:** 2015–2025
- **Tools:** MySQL, SQL, Power BI
- **Project Type:** Beginner SQL learning project

## 2. Key Findings

### Season Analysis
- The 2024 and 2025 seasons each had 24 races.
- The 2020 season had the fewest races, with 17.

### Driver Performance
- Driver  Lewis scored the highest total points: 3,469.5.
- Driver  Lewis recorded the most race wins: 72.

### Constructor Performance
- Mercedes scored 6,433.5 total points.
- Mercedes achieved 247 podium finishes.
- Mercedes' podium percentage of recorded result rows was 53.00%.
- Red Bull and Ferrari ranked second and third in total points.

### Constructor Rankings by Season
- Mercedes led the constructor points analysis from 2015 through 2021.
- Red Bull led in 2022.

## 3. SQL Concepts Practised

- SELECT, WHERE, ORDER BY and LIMIT
- Aggregate functions and GROUP BY
- HAVING and CASE
- INNER JOIN
- Subqueries and CTEs
- Window functions: DENSE_RANK() and LAG()
- Percentage calculations

## 4. Data Limitations

- Driver IDs in the results and drivers tables are inconsistent.
  Joining these tables may omit some records.
- Podium percentage is calculated from recorded driver-result rows,
  not unique Grand Prix events.
- Constructor names may change across seasons.

## 5. Learning Outcome

This project helped me practise SQL using Formula 1 data,
answer business-style questions, aggregate performance metrics,
compare constructors, and analyse race-to-race results.
