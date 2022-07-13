/*

Title       : Median Price Of Wines
Link        : https://platform.stratascratch.com/coding/10043-median-price-of-wines?code_type=1
Difficulty  : Hard
Question    : Find the median price for each wine variety across both datasets. 
              Output distinct varieties along with the corresponding median price.
Tables      : winemag_p1, winemag_p2

<winemag_p1>
id                              int
country                         varchar
description                     varchar
designation                     varchar
points                          int
price                           float
province                        varchar
region_1                        varchar
region_2                        varchar
variety                         varchar
winery                          varchar

<winemag_p2>
id                              int
country                         varchar
description                     varchar
designation                     varchar
points                          int
price                           float
province                        varchar
region_1                        varchar
region_2                        varchar
taster_name                     varchar
taster_twitter_handle           varchar
title                           varchar
variety                         varchar
winery                          varchar

*/


-- logic:
-- 1. combine two table to get all variety price.
-- 2. calculate median for each variety.


-- solution 1:
WITH all_wine_price AS (
    SELECT variety, 
           price
    FROM winemag_p1
    UNION ALL
    SELECT variety, 
           price
    FROM winemag_p2
)
SELECT DISTINCT variety,
       PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY price)
FROM all_wine_price
GROUP BY variety
ORDER BY variety
