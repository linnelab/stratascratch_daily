/*

Title       : Number of violations
Link        : https://platform.stratascratch.com/coding/9728-inspections-that-resulted-in-violations?code_type=1
Difficulty  : Medium
Question    : You're given a dataset of health inspections. 
              Count the number of violation in an inspection in 'Roxanne Cafe' for each year. 
              If an inspection resulted in a violation, there will be a value in the 'violation_id' column. 
              Output the number of violations by year in ascending order.
Tables      : sf_restaurant_health_violations

<sf_restaurant_health_violations>
business_id                     int
business_name                   varchar
business_address                varchar
business_city                   varchar
business_state                  varchar
business_postal_code            float
business_latitude               float
business_longitude              float
business_location               varchar
business_phone_number           float
inspection_id                   varchar
inspection_date                 datetime
inspection_score                float
inspection_type                 varchar
violation_id                    varchar
violation_description           varchar
risk_category                   varchar

*/


-- note:
-- solution 1 ~ 3: use three different method to get year.


-- solution 1: use TO_CHAR()
SELECT TO_CHAR(inspection_date, 'YYYY') AS year,
       COUNT(violation_id) AS violation_cnt
FROM sf_restaurant_health_violations
WHERE business_name = 'Roxanne Cafe'
GROUP BY year
ORDER BY year


-- solution 2: use EXTRACT()
SELECT EXTRACT(YEAR FROM inspection_date) AS year,
       COUNT(violation_id) AS violation_cnt
FROM sf_restaurant_health_violations
WHERE business_name = 'Roxanne Cafe'
GROUP BY year
ORDER BY year


-- solution 3: use DATE_PART()
SELECT DATE_PART('year', inspection_date) AS year,
       COUNT(violation_id) AS violation_cnt
FROM sf_restaurant_health_violations
WHERE business_name = 'Roxanne Cafe'
GROUP BY year
ORDER BY year
