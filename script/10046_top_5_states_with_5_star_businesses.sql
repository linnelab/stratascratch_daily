/*

Title       : Top 5 States With 5 Star Businesses
Link        : https://platform.stratascratch.com/coding/10046-top-5-states-with-5-star-businesses?code_type=1
Difficulty  : Hard
Question    : Find the top 5 states with the most 5 star businesses. 
              Output the state name along with the number of 5-star businesses and 
              order records by the number of 5-star businesses in descending order. 
              In case there are ties in the number of businesses, return all the unique states. 
              If two states have the same result, sort them in alphabetical order.
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


-- logic: 
-- 1. calculate each of state contain the number of five stars. 
-- 2. ranking 1 result and getting top 5 (i.e rank < 6) records
-- 3. output state names and total five stars counts.
--    if diff state contains same the number of five stars, order ascending for state name and show in table result.


-- note:
-- With rank() solution has 6 states and with dense_rank() solution has 7 states and questions asking for 5 states. 
-- 6 instead of 5 because of there are ties in diff states have same the number of five stars.


-- solution 1:
WITH five_stars_state AS (
    SELECT state, 
           COUNT(stars) AS five_stars_cnt
    FROM yelp_business
    WHERE stars = 5
    GROUP BY state
), state_stars_rank AS (
SELECT state,
       five_stars_cnt,
       RANK() OVER (ORDER BY five_stars_cnt DESC) AS rk
FROM five_stars_state
)
SELECT *
FROM state_stars_rank
WHERE rk < 6
ORDER BY rk, state


-- solution 2:
SELECT state,
       five_stars_cnt
FROM (
    SELECT state,
           COUNT(stars) AS five_stars_cnt,
           RANK() OVER (ORDER BY COUNT(stars) DESC) AS rk
    FROM yelp_business 
    WHERE stars = 5
    GROUP BY state
    ORDER BY five_stars_cnt DESC, state
) AS t
WHERE rk < 6
