
-- Q13: Which drivers scored above the average total
-- points per driver between 2015 and 2025?

SELECT
    results.driverId,
    SUM(results.points) AS total_points
FROM formula1_analysis.results AS results
JOIN formula1_analysis.races AS races
    ON results.raceId = races.raceId
WHERE races.year BETWEEN 2015 AND 2025
GROUP BY results.driverId
HAVING SUM(results.points) > (
    SELECT AVG(total_points)
    FROM (
        SELECT
            results.driverId,
            SUM(results.points) AS total_points
        FROM formula1_analysis.results AS results
        JOIN formula1_analysis.races AS races
            ON results.raceId = races.raceId
        WHERE races.year BETWEEN 2015 AND 2025
        GROUP BY results.driverId
    ) AS drivers_total
)
ORDER BY total_points DESC;

