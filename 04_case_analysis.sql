
-- =====================================================
-- Project: Formula 1 Performance Analysis
-- Database: formula1_analysis
-- Analysis Period: 2015-2025
-- File: 04_case_analysis.sql
-- Purpose: Conditional logic using CASE
-- Questions: Q11-Q12
-- =====================================================


-- Q11: How many driver-result records fall into each
-- performance category between 2015 and 2025?

SELECT
    CASE
        WHEN results.positionOrder BETWEEN 1 AND 3
            THEN 'Podium'
        WHEN results.positionOrder BETWEEN 4 AND 10
            THEN 'Points Finish'
        ELSE 'Outside Points'
    END AS performance_category,
    COUNT(*) AS number_of_results
FROM formula1_analysis.results AS results
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
WHERE races.year BETWEEN 2015 AND 2025
GROUP BY performance_category;


-- Q12: Which constructors achieved the most podium finishes
-- between 2015 and 2025?

SELECT
    constructors.name AS constructor_name,
    SUM(
        CASE
            WHEN results.positionOrder BETWEEN 1 AND 3
                THEN 1
            ELSE 0
        END
    ) AS podium_finishes
FROM formula1_analysis.results AS results
JOIN formula1_analysis.constructors AS constructors
    ON results.constructorId = constructors.constructorId
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
WHERE races.year BETWEEN 2015 AND 2025
GROUP BY constructors.constructorId, constructors.name
ORDER BY podium_finishes DESC;
