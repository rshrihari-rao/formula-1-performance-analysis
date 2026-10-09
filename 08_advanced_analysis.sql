
-- =====================================================
-- Project: Formula 1 Performance Analysis
-- Database: formula1_analysis
-- Analysis Period: 2015-2025
-- File: 08_advanced_analysis.sql
-- Purpose: Combined constructor performance metrics
-- Question: Q20
-- =====================================================

-- Q20: Which constructors had the highest total points,
-- how many podium finishes did they achieve, and what
-- percentage of recorded results were podium finishes?

SELECT
    constructors.constructorId,
    constructors.name,
    SUM(results.points) AS total_points,

    SUM(
        CASE
            WHEN results.positionOrder BETWEEN 1 AND 3
                THEN 1
            ELSE 0
        END
    ) AS podium_finishes,

    COUNT(*) AS total_results,

    ROUND(
        SUM(
            CASE
                WHEN results.positionOrder BETWEEN 1 AND 3
                    THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS podium_percentage
FROM formula1_analysis.results AS results
JOIN formula1_analysis.constructors AS constructors
    ON results.constructorId = constructors.constructorId
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
WHERE races.year BETWEEN 2015 AND 2025
GROUP BY
    constructors.constructorId,
    constructors.name
ORDER BY total_points DESC;
