/*

Title       : Number of Streets Per Zip Code
Link        : https://platform.stratascratch.com/coding/10182-number-of-streets-per-zip-code?code_type=1
Difficulty  : Medium
Question    : Find the number of different street names for each postal code, for the given business dataset. 
              For simplicity, just count the first part of the name if the street name has multiple words.
              For example, East Broadway can be counted as East. East Main and East Broadly may be counted both as East, which is fine for this question.
              Counting street names should also be case insensitive, meaning FOLSOM should be counted the same as Folsom. Lastly, 
              consider that some street names have different structures. 
              For example, Pier 39 is the same street as 39 Pier,  your solution should count both situations as Pier street.
              Output the result along with the corresponding postal code. 
              Order the result based on the number of streets in descending order and based on the postal code in ascending order.
Tables      : sf_restaurant_health_violations

<sf_restaurant_health_violations>
business_id                   int
business_name                 varchar
business_address              varchar
business_city                 varchar
business_state                varchar
business_postal_code          float
business_latitude             float
business_longitude            float
business_location             varchar
business_phone_number         float
inspection_id                 varchar
inspection_date               datetime
inspection_score              float
inspection_type               varchar
violation_id                  varchar
violation_description         varchar
risk_category                 varchar

*/


-- logic and note:
-- 1. determine business_address first text is number, then get second text as stress keyword, 
--    if first text is not number, then get first text as stress keyword.
-- 2. remeber: change stress keyword to lower and distinct duplicate stess keyword records.
-- 3. count the number of this keyword.

-- split_part :
-- ref link : https://www.postgresqltutorial.com/postgresql-string-functions/postgresql-split_part/


-- solution 1:
WITH specified_street_element AS (
    SELECT business_postal_code,
           business_address,
           CASE 
                WHEN LEFT(business_address, 1) ~ '^[0-9]' THEN LOWER(SPLIT_PART(business_address, ' ', 2))
                ELSE LOWER(SPLIT_PART(business_address, ' ', 1))
           END AS street_element
    FROM sf_restaurant_health_violations
    WHERE business_postal_code IS NOT NULL
)
SELECT business_postal_code,
       COUNT(DISTINCT street_element) AS street_cnt
FROM specified_street_element
GROUP BY business_postal_code
ORDER BY street_cnt DESC
