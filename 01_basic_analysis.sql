-- =====================================================
-- Project: Formula 1 Performance Analysis
-- Database: formula1_analysis
-- Analysis Period: 2015–2025
-- File: 01_basic_analysis.sql
-- Purpose: Basic SQL analysis and aggregations
-- =====================================================

-- Q1: Which F1 seasons had the highest number of races
-- between 2015 and 2025?

SELECT
    year,
    COUNT(*) AS number_of_races
FROM formula1_analysis.races
WHERE year BETWEEN 2015 AND 2025
GROUP BY year
ORDER BY number_of_races DESC;

-- Q2: Which Grand Prix names occurred most frequently
-- between 2015 and 2025?

SELECT
    name,
    COUNT(*) AS number_of_races
FROM formula1_analysis.races
WHERE year BETWEEN 2015 AND 2025
GROUP BY name
ORDER BY number_of_races DESC;


-- Q3: Which drivers participated in the most races
-- between 2015 and 2025?

SELECT
    CONCAT(drivers.forename, ' ', drivers.surname) AS driver_name,
    COUNT(*) AS races_participated
FROM formula1_analysis.results AS results
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
JOIN formula1_analysis.drivers AS drivers
    ON results.driverId = drivers.driverId
WHERE races.year BETWEEN 2015 AND 2025
GROUP BY
    drivers.driverId,
    drivers.forename,
    drivers.surname
ORDER BY races_participated DESC;

