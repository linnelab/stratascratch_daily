/*

Title       : Reviews of Categories
Link        : https://platform.stratascratch.com/coding/10049-reviews-of-categories?code_type=1
Difficulty  : Medium
Question    : Find the top business categories based on the total number of reviews. 
              Output the category along with the total number of reviews. 
              Order by total reviews in descending order.
Tables      : yelp_reviews

<yelp_business>
business_id           varchar
name                  varchar
neighborhood          varchar
address               varchar
city                  varchar
state                 varchar
postal_code           varchar
latitude              float
longitude             float
stars                 float
review_count          int
is_open               int
categories            varchar

*/


-- logic: 
-- use ";" split categories string, will become mutliple sub-string elements into array. (method: use STRING_TO_ARRAY() function)
-- change each of elements on array to multiple rows. (method: use UNNEST() function)


-- note:
-- UNNEST(): This function is used to expand an array to a set of rows.
-- ref: https://www.w3resource.com/PostgreSQL/postgresql_unnest-function.php

-- STRING_TO_ARRAY(): This function is used to split a string into array elements using supplied delimiter and optional null string.
-- ref: https://www.w3resource.com/PostgreSQL/postgresql_string_to_array-function.php

-- UNNEST() + STRING_TO_ARRAY() example:
-- ref: https://ithelp.ithome.com.tw/articles/10222763


-- solution 1: 
SELECT UNNEST(STRING_TO_ARRAY(categories, ';')) AS category,
       SUM(review_count) AS total_review
FROM yelp_business
GROUP BY category
ORDER BY total_review DESC
