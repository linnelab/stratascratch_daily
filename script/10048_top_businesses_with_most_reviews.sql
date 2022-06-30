/*

Title       : Top Businesses With Most Reviews
Link        : https://platform.stratascratch.com/coding/10048-top-businesses-with-most-reviews?code_type=1
Difficulty  : Medium
Question    : Find the top 5 businesses with most reviews. 
              Assume that each row has a unique business_id such that the total reviews for each business is listed on each row. 
              Output the business name along with the total number of reviews and order your results by the total reviews in descending order.
Tables      : yelp_business

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


-- solution 1:
SELECT name,
       review_count
FROM (
    SELECT name,
           review_count,
           DENSE_RANK() OVER (ORDER BY review_count DESC) AS rk
    FROM yelp_business
) AS t
WHERE rk < 6
