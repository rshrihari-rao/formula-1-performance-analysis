
-- =====================================================
-- Project: Formula 1 Performance Analysis
-- Database: formula1_analysis
-- Analysis Period: 2015-2025
-- File: 02_group_by_analysis.sql
-- Purpose: Aggregations and grouped analysis
-- Questions: Q4-Q8
-- =====================================================

-- Q4: Which drivers scored the most total points
-- between 2015 and 2025?

SELECT
    results.driverId,
    COUNT(*) AS races_participated,
    SUM(results.points) AS total_points
FROM formula1_analysis.results AS results
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
WHERE races.year BETWEEN 2015 AND 2025
GROUP BY results.driverId
ORDER BY total_points DESC;


-- Q5: What is the average finishing position per driver
-- between 2015 and 2025?

SELECT
    results.driverId,
    AVG(results.position) AS average_position
FROM formula1_analysis.results AS results
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
WHERE races.year BETWEEN 2015 AND 2025
  AND results.position IS NOT NULL
GROUP BY results.driverId
ORDER BY average_position ASC;


-- Q6: Which drivers won the most races
-- between 2015 and 2025?

SELECT
    results.driverId,
    COUNT(results.position) AS wins
FROM formula1_analysis.results AS results
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
WHERE races.year BETWEEN 2015 AND 2025
  AND results.position = 1
GROUP BY results.driverId
ORDER BY wins DESC
LIMIT 10;


-- Q7: Which drivers won at least 5 races
-- between 2015 and 2025?

SELECT
    results.driverId,
    COUNT(*) AS wins
FROM formula1_analysis.results AS results
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
WHERE races.year BETWEEN 2015 AND 2025
  AND results.position = 1
GROUP BY results.driverId
HAVING COUNT(*) >= 5
ORDER BY wins DESC;


-- Q8: Which races had the highest number of classified
-- finishers between 2015 and 2025?

SELECT
    races.raceId,
    races.name,
    races.year,
    COUNT(results.positionText) AS finishers
FROM formula1_analysis.results AS results
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
WHERE races.year BETWEEN 2015 AND 2025
  AND results.positionText REGEXP '^[0-9]+$'
GROUP BY
    races.raceId,
    races.name,
    races.year
ORDER BY finishers DESC
LIMIT 10;
