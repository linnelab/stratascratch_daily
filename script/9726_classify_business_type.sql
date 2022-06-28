/*

Title       : Classify Business Type
Link        : https://platform.stratascratch.com/coding/9726-classify-business-type?code_type=1
Difficulty  : Medium
Question    : Classify each business as either a restaurant, cafe, school, or other. 
              A restaurant should have the word 'restaurant' in the business name. 
              For cafes, either 'cafe', 'café', or 'coffee' can be in the business name. 
              'School' should be in the business name for schools. 
              All other businesses should be classified as 'other'. 
              Output the business name and the calculated classification.
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


-- logic :
-- Classify each of business type according keywords like 'shool', 'restaurant', and 'cafe'...etc. 


-- note :
-- ILIKE : 
-- ignore case when matching value
-- ref link: https://mode.com/sql-tutorial/sql-like/#wildcards-and-ilike

-- ILIKE ANY (ARRAY[]) : 
-- ignore case when matching value and value is match any array element
-- ref link: https://sqlserverguides.com/postgresql-like/


-- solution 1: use LOWER + LIKE
SELECT DISTINCT business_name,
       CASE 
            WHEN LOWER(business_name) LIKE '%restaurant%' THEN 'restaurant'
            WHEN LOWER(business_name) LIKE '%cafe%' 
                OR LOWER(business_name) LIKE '%coffee%' 
                OR LOWER(business_name) LIKE '%café%' THEN 'cafe'
            WHEN LOWER(business_name) LIKE '%school%' THEN 'school'
            ELSE 'other'
       END AS business_type
FROM sf_restaurant_health_violations


-- solution 2: use ILIKE
SELECT DISTINCT business_name,
       CASE 
            WHEN business_name ILIKE '%restaurant%' THEN 'restaurant'
            WHEN business_name ILIKE '%cafe%'
                OR business_name ILIKE '%coffee%' 
                OR business_name ILIKE '%café%' THEN 'cafe'
            WHEN business_name ILIKE '%school%' THEN 'school'
            ELSE 'other'
        END AS business_type
FROM sf_restaurant_health_violations


-- solution 3: use ILIKE ANY ARRAY
SELECT DISTINCT business_name,
        CASE
            WHEN business_name ILIKE ANY(ARRAY['%restaurant%']) THEN 'restaurant'
            WHEN business_name ILIKE ANY(ARRAY['%cafe%', '%coffee%', '%café%']) THEN 'cafe'
            WHEN business_name ILIKE ANY(ARRAY['%school%']) THEN 'school'
            ELSE 'other'
        END AS business_type
FROM sf_restaurant_health_violations
