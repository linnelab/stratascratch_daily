/*

Title       : Most Profitable Companies
Link        : https://platform.stratascratch.com/coding/9680-most-profitable-companies?code_type=1
Difficulty  : Medium
Question    : Find the 3 most profitable companies in the entire world.
              Output the result along with the corresponding company name.
              Sort the result based on profits in descending order.
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
-- 1. use DENSE_RANK() and set ranking less than 4 will output all companies with the same profit.


-- solution 1:
SELECT company,
       profits
FROM (
    SELECT company,
           profits,
           DENSE_RANK() OVER (ORDER BY profits DESC) AS rk
    FROM forbes_global_2010_2014
    ORDER BY rk 
) AS t
WHERE rk < 4
