/*

Title       : Most Expensive And Cheapest Wine
Link        : https://platform.stratascratch.com/coding/10041-most-expensive-and-cheapest-wine?code_type=1
Difficulty  : Hard
Question    : Find the cheapest and the most expensive variety in each region. 
              Output the region along with the corresponding most expensive and the cheapest variety. 
              Be aware that there are 2 region columns, price from that row applies to both of them.
Tables      : winemag_p1

<winemag_p1>
id                int
country           varchar
description       varchar
designation       varchar
points            int
price             float
province          varchar
region_1          varchar
region_2          varchar
variety           varchar
winery            varchar

*/


-- logic:
-- 1. union region 1 and region 2 data to get all region. (need to exclude price is null and region is null data).
-- 2. ranking price by region to find expensive variety rank and cheapest variety rank.
-- 3. get rank=1 to find expensive variety and cheapest variety for each regions.


-- solution 1:
WITH region_variety AS (
    SELECT region_1 AS region,
           variety,
           price
    FROM winemag_p1
    WHERE price IS NOT NULL AND region_1 IS NOT NULL
    UNION ALL 
    SELECT region_2 AS region,
           variety,
           price
    FROM winemag_p1
    WHERE price IS NOT NULL AND region_2 IS NOT NULL
), rank_variety_price AS (
SELECT region,
       variety,
       DENSE_RANK() OVER (PARTITION BY region ORDER BY price DESC) AS expensive_rk,
       DENSE_RANK() OVER (PARTITION BY region ORDER BY price) AS cheap_rk
FROM region_variety
)
SELECT region,
       MAX(variety) FILTER (WHERE expensive_rk = 1) AS expensive_variety,
       MAX(variety) FILTER (WHERE cheap_rk = 1) AS expensive_variety
FROM rank_variety_price 
GROUP BY region
