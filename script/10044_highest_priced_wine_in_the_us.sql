/*

Title       : Highest Priced Wine In The US
Link        : https://platform.stratascratch.com/coding/10044-highest-priced-wine-in-the-us?code_type=1
Difficulty  : Medium
Question    : Find the highest price in US country for each variety produced in English speaking regions, but not in Spanish speaking regions, 
              with taking into consideration varieties that have earned a minimum of 90 points for every country they're produced in.
              Output both the variety and the corresponding highest price.
              Let's assume the US is the only English speaking region in the dataset, 
              and Spain, Argentina are the only Spanish speaking regions in the dataset. 
              Let's also assume that the same variety might be listed under several countries 
              so you'll need to remove varieties that show up in both the US and in Spanish speaking countries.
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
-- 1. find country of wine variety are not in US.
-- 2. then find country of wine variety are in US, but variety not exists #1 lists. 
--    (because need to remove variety that show up in both the US and other speaking countries)
-- 3. then find max price and filter points bigger and equal then 90


-- solution 1:
WITH other_country_variety AS (
    SELECT DISTINCT variety 
    FROM winemag_p1 
    WHERE country <> 'US'
)
SELECT variety,
       max(price) AS highest_price
FROM winemag_p1
WHERE country = 'US' 
    AND variety NOT IN (SELECT variety FROM other_country_variety)
    AND points >= 90
GROUP BY variety
