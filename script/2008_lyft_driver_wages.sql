/*

Title       : Lyft Driver Wages
Link        : https://platform.stratascratch.com/coding/10003-lyft-driver-wages?code_type=1
Difficulty  : Easy
Question    : Find all Lyft drivers who earn either equal to or less than 30k USD or equal to or more than 70k USD.
              Output all details related to retrieved records.
Tables      : lyft_drivers

<lyft_drivers>
index                 int
start_date            datetime
end_date              datetime
yearly_salary         int

*/


-- logic:
-- [solution 1]:
-- 1. find one stop flight cost.
-- 2. find two stop flight cost.
-- 3. find direct flight cost, and then union direct flight, one stop flight, and two stop flight data.
-- 4. rank #3 result to find cheapest flight cost.
-- 5. from rank = 1 to find cheapest flight cost.

-- [solution 2]:
-- 1. find direct flight cost, one stop flight cost, and two stop flight cost, and union these data.
-- 2. from #1 results find min cost.


-- note:
-- 1. join results maybe produce empty cost, so need to remember exclude this records.
-- 2. solution 1 can use inner join to replace left join, 
--    then determine total cost whether bigger than 0, this script can be omission. (e.g. WHERE (f1.cost + f2.cost) > 0)


-- solution 1:
WITH one_stage_flight AS (
    SELECT f1.origin,
           f2.destination,
           (f1.cost + f2.cost) AS total_cost
    FROM da_flights AS f1
    LEFT JOIN da_flights AS f2
        ON f1.destination = f2.origin
    WHERE (f1.cost + f2.cost) > 0
), two_stage_flight AS (
    SELECT f1.origin,
           f3.destination,
           (f1.cost + f2.cost + f3.cost) AS total_cost
    FROM da_flights AS f1
    LEFT JOIN da_flights AS f2
        ON f1.destination = f2.origin
    LEFT JOIN da_flights AS f3
        ON f2.destination = f3.origin
    WHERE (f1.cost + f2.cost + f3.cost) > 0
), all_flight_list AS (
    SELECT origin,
           destination,
           cost
    FROM da_flights
    UNION ALL
    SELECT *
    FROM one_stage_flight
    UNION ALL 
    SELECT *
    FROM two_stage_flight
), rank_all_flight AS (
SELECT origin,
       destination,
       cost,
       DENSE_RANK() OVER (PARTITION BY origin, destination ORDER BY cost) AS rk
FROM all_flight_list
)
SELECT origin,
       destination,
       cost
FROM rank_all_flight
WHERE rk = 1
ORDER BY origin, destination


-- solution 2:
WITH all_flight_list AS (
    SELECT origin,
           destination,
           cost
    FROM da_flights 
    
    UNION ALL 
    
    SELECT f1.origin,
           f2.destination,
           (f1.cost + f2.cost) AS total_cost
    FROM da_flights AS f1
    INNER JOIN da_flights AS f2
        ON f1.destination = f2.origin

    UNION ALL
    
    SELECT f1.origin,
           f3.destination,
           (f1.cost + f2.cost + f3.cost) AS total_cost
    FROM da_flights AS f1
    INNER JOIN da_flights AS f2
        ON f1.destination = f2.origin
    INNER JOIN da_flights AS f3
        ON f2.destination = f3.origin
)
SELECT origin,
       destination,
       MIN(cost) AS cheapest_cost
FROM all_flight_list
GROUP BY origin,
         destination
ORDER BY origin,
         destination
