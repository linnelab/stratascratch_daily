/*

Title       : Business Name Lengths
Link        : https://platform.stratascratch.com/coding/10131-business-name-lengths?code_type=1
Difficulty  : Hard
Question    : Find the number of words in each business name. 
              Avoid counting special symbols as words (e.g. &). 
              Output the business name and its count of words.
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


-- logic:
-- 1. replace symbol to empty string (i.e. "")
-- 2. use empty string to split business name and put array.
-- 3. calculate array length


-- note:
-- 1. REGEXP_REPLACE(): 
--    the 'g' flag repeats multiple matches on a string (not just the first).

-- 2. regular expressions descriptions: 
--    https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Guide/Regular_Expressions

-- 3. ARRAY_LENGTH(): 
--    https://docs.postgresql.tw/the-sql-language/data-types/arrays


-- solution 1:
WITH replace_symbol AS (
    SELECT DISTINCT business_name,
           REGEXP_REPLACE(business_name, '[^a-zA-Z0-9 ]', '', 'g') AS only_word
    FROM sf_restaurant_health_violations
)
SELECT business_name,
       ARRAY_LENGTH(REGEXP_SPLIT_TO_ARRAY(only_word, '\s+'), 1) AS word_cnt
FROM replace_symbol
