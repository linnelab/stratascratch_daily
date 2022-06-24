/*

Title       : Highest Energy Consumption
Link        : https://platform.stratascratch.com/coding/10064-highest-energy-consumption?code_type=1
Difficulty  : Medium
Question    : Find the date with the highest total energy consumption from the Meta/Facebook data centers. 
              Output the date along with the total energy consumption across all data centers.
Tables      : fb_eu_energy, fb_asia_energy, fb_na_energy

<fb_eu_energy>
date                 datetime
consumption          int

<fb_asia_energy>
date                 datetime
consumption          int

<fb_na_energy>
date                 datetime
consumption          int

*/


-- logic:
-- 1. union all energy tables
-- 2. sum total energy consumption per date
-- 3. find highest consumption


-- solution 1: use union all + sum + rank
WITH total_energy AS (
    SELECT *
    FROM fb_eu_energy
    UNION ALL
    SELECT *
    FROM fb_asia_energy
    UNION ALL
    SELECT *
    FROM fb_na_energy
), total_consumption AS (
    SELECT date, SUM(consumption) AS total_consumption
    FROM total_energy
    GROUP BY date
), rank_consumption AS (
    SELECT date, 
           total_consumption, 
           DENSE_RANK() OVER (ORDER BY total_consumption DESC) AS rk
    FROM total_consumption
)
SELECT date, total_consumption
FROM rank_consumption
WHERE rk = 1


-- solution 2: use union all + sum + max
WITH total_energy AS (
    SELECT *
    FROM fb_eu_energy
    UNION ALL
    SELECT *
    FROM fb_asia_energy
    UNION ALL
    SELECT *
    FROM fb_na_energy
), total_consumption AS (
    SELECT date, SUM(consumption) AS total_consumption
    FROM total_energy
    GROUP BY date
)
SELECT *
FROM total_consumption
WHERE total_consumption = (SELECT MAX(total_consumption) FROM total_consumption)
