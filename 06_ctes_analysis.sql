
-- =====================================================
-- Project: Formula 1 Performance Analysis
-- Database: formula1_analysis
-- Analysis Period: 2015-2025
-- File: 06_ctes.sql
-- Purpose: Analysis using Common Table Expressions
-- Questions: Q14-Q16
-- =====================================================

-- Q14: Which races had more pit stops than the average
-- number of pit stops per race between 2015 and 2025?

WITH pit_stops_total AS (
    SELECT
        races.raceId,
        races.year,
        races.name,
        COUNT(*) AS total_count
    FROM formula1_analysis.races AS races
    JOIN formula1_analysis.pit_stops AS pit_stops
        ON races.raceId = pit_stops.raceId
    WHERE races.year BETWEEN 2015 AND 2025
    GROUP BY races.raceId, races.year, races.name
)
SELECT
    raceId,
    year,
    name,
    total_count
FROM pit_stops_total
WHERE total_count > (
    SELECT AVG(total_count)
    FROM pit_stops_total
)
ORDER BY total_count DESC;

-- Q15: Which drivers averaged more than 10 points per
-- recorded result, with at least 20 recorded results,
-- between 2015 and 2025?

WITH drivers_total AS (
    SELECT
        results.driverId,
        SUM(results.points) AS total_points,
        COUNT(*) AS races_participated,
        AVG(results.points) AS average_points_per_race
    FROM formula1_analysis.results AS results
    JOIN formula1_analysis.races AS races
        ON results.raceId = races.raceId
    WHERE races.year BETWEEN 2015 AND 2025
    GROUP BY results.driverId
)
SELECT
    driverId,
    total_points,
    races_participated,
    average_points_per_race
FROM drivers_total
WHERE races_participated >= 20
  AND average_points_per_race > 10
ORDER BY average_points_per_race DESC;

-- Q16: Which constructors scored more than 100 points
-- in at least 5 seasons between 2015 and 2025?

WITH constructors_points AS (
    SELECT
        constructors.name,
        races.year,
        SUM(results.points) AS total_points
    FROM formula1_analysis.results AS results
    JOIN formula1_analysis.constructors AS constructors
        ON results.constructorId = constructors.constructorId
    JOIN formula1_analysis.races AS races
        ON results.raceId = races.raceId
    WHERE races.year BETWEEN 2015 AND 2025
    GROUP BY constructors.name, races.year
)
SELECT
    name,
    COUNT(*) AS great_season
FROM constructors_points
WHERE total_points > 100
GROUP BY name
HAVING COUNT(*) >= 5
ORDER BY great_season DESC;
