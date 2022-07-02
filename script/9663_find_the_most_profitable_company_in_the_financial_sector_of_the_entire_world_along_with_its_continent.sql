/*

Title       : Find the most profitable company in the financial sector of the entire world along with its continent
Link        : https://platform.stratascratch.com/coding/9663-find-the-most-profitable-company-in-the-financial-sector-of-the-entire-world-along-with-its-continent?code_type=1
Difficulty  : Easy
Question    : Find the most profitable company from the financial sector. Output the result along with the continent.
Tables      : forbes_global_2010_2014

<forbes_global_2010_2014>
company               varchar
sector                varchar
industry              varchar
continent             varchar
country               varchar
marketvalue           float
sales                 float
profits               float
assets                float
rank                  int
forbeswebpage         varchar

*/


-- note:
-- solution 2: when get max profit, need to limit sector is 'financials', it will confirm from financial sector getting max profit, not other sectors.


-- solution 1:
SELECT company, 
       continent
FROM forbes_global_2010_2014
WHERE sector = 'Financials'
    AND rank = 1


-- solution 2:
SELECT company, 
       continent
FROM forbes_global_2010_2014
WHERE sector = 'Financials'
    AND profits = (SELECT MAX(profits) FROM forbes_global_2010_2014 WHERE sector = 'Financials')
