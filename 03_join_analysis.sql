
-- =====================================================
-- Project: Formula 1 Performance Analysis
-- Database: formula1_analysis
-- Analysis Period: 2015-2025
-- File: 03_join_analysis.sql
-- Purpose: Multi-table analysis using JOINs
-- Questions: Q9-Q10
-- =====================================================


-- Q9: Which constructors scored the most total points
-- between 2015 and 2025?

SELECT
    constructors.name AS constructor_name,
    SUM(results.points) AS total_points
FROM formula1_analysis.results AS results
JOIN formula1_analysis.constructors AS constructors
    ON results.constructorId = constructors.constructorId
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
WHERE races.year BETWEEN 2015 AND 2025
GROUP BY constructors.constructorId, constructors.name
ORDER BY total_points DESC
LIMIT 5;

-- Q10: Which drivers improved their finishing position
-- compared with qualifying between 2015 and 2025?

SELECT
    results.driverId,
    COUNT(*) AS times_improved
FROM formula1_analysis.results AS results
JOIN formula1_analysis.qualifying AS qualifying
    ON results.raceId = qualifying.raceId
   AND results.driverId = qualifying.driverId
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
WHERE races.year BETWEEN 2015 AND 2025
  AND results.position IS NOT NULL
  AND qualifying.position IS NOT NULL
  AND results.position < qualifying.position
GROUP BY results.driverId
ORDER BY times_improved DESC;
