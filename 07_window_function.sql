
-- =====================================================
-- Project: Formula 1 Performance Analysis
-- Database: formula1_analysis
-- Analysis Period: 2015-2025
-- File: 07_window_functions.sql
-- Purpose: Ranking and race-to-race analysis
-- Questions: Q17-Q19
-- =====================================================


-- Q17: Rank drivers by total points between 2015 and 2025

WITH drivers_rank AS (
    SELECT
        results.driverId,
        SUM(results.points) AS total_points
    FROM formula1_analysis.results AS results
    JOIN formula1_analysis.races AS races
        ON results.raceId = races.raceId
    WHERE races.year BETWEEN 2015 AND 2025
    GROUP BY results.driverId
),
ranked_drivers AS (
    SELECT
        driverId,
        total_points,
        DENSE_RANK() OVER (
            ORDER BY total_points DESC
        ) AS driver_rank
    FROM drivers_rank
)
SELECT
    driverId,
    total_points,
    driver_rank
FROM ranked_drivers
ORDER BY driver_rank
LIMIT 10;


-- Q18: Which constructors ranked in the top 3 by points
-- in each season between 2015 and 2025?

WITH great_constructor AS (
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
),
ranked_constructors_team AS (
    SELECT
        name,
        total_points,
        year,
        DENSE_RANK() OVER (
            PARTITION BY year
            ORDER BY total_points DESC
        ) AS ranked_constructors
    FROM great_constructor
)
SELECT
    name,
    year,
    total_points,
    ranked_constructors
FROM ranked_constructors_team
WHERE ranked_constructors <= 3
ORDER BY year, ranked_constructors;


-- Q19: How did Lewis Hamilton's finishing position change
-- from one race to the next between 2015 and 2025?

WITH driver_race_positions AS (
    SELECT
        drivers.driverId,
        CONCAT(
            drivers.forename, ' ', drivers.surname
        ) AS driver_name,
        races.name AS race_name,
        races.year AS race_year,
        races.date AS race_date,
        results.positionOrder AS finishing_position,
        LAG(results.positionOrder) OVER (
            ORDER BY races.date, races.raceId
        ) AS previous_finishing_position
    FROM formula1_analysis.results AS results
    JOIN formula1_analysis.races AS races
        ON results.raceId = races.raceId
    JOIN formula1_analysis.drivers AS drivers
        ON results.driverId = drivers.driverId
    WHERE drivers.driverId = 1
      AND races.year BETWEEN 2015 AND 2025
      AND results.positionOrder IS NOT NULL
)
SELECT
    driverId,
    driver_name,
    race_name,
    race_year,
    race_date,
    finishing_position,
    previous_finishing_position,
    previous_finishing_position - finishing_position
        AS position_change
FROM driver_race_positions
ORDER BY race_date, driverId;
