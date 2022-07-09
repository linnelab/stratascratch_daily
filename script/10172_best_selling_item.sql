/*

Title       : Best Selling Item
Link        : https://platform.stratascratch.com/coding/10172-best-selling-item?code_type=1
Difficulty  : Hard
Question    : Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid. 
              The best selling item is calculated using the formula (unitprice * quantity). 
              Output the description of the item along with the amount paid.
Tables      : online_retail

<online_retail>
invoiceno         varchar
stockcode         varchar
description       varchar
quantity          int
invoicedate       datetime
unitprice         float
customerid        float
country           varchar

*/


-- logic:
-- 1. only extract month of invoice date, not to separate year.
-- 2. use formula to calculate best selling and sum best selling for each of month and description, then get total selling. 
-- 3. use ranking find each of month highest total selling.


-- note:
-- 1. extract invoice month not to separate year, so only partition month.
-- 2. extract month from invoice date method, can use EXTRACT() or DATE_PART()
-- 3. solution 1 and 2 different from DENSE_RANK(PARTITOIN BY ... ORDER BY ...) script,
--    solution 1 separate multiple cte, to get column name, and put this column name after PARTIOTN BY and ORDER BY, 
--    but solution 2 use one cte, put EXTRACT() invoice_month and best selling SUM() formula after PARTIOTN BY and ORDER BY,
--    then 2 solutions are same logic.


-- solution 1:
WITH total_selling_by_month AS (
    SELECT EXTRACT(MONTH FROM invoicedate) AS invoice_month,        --DATE_PART('month', invoicedate)
           description,
           SUM(unitprice * quantity) AS total_selling
    FROM online_retail
    GROUP BY invoice_month,
             description
), rank_selling_by_month AS (
SELECT invoice_month,
       description,
       total_selling,
       DENSE_RANK() OVER (PARTITION BY invoice_month ORDER BY total_selling DESC) AS rk
FROM total_selling_by_month
ORDER BY invoice_month
)
SELECT invoice_month,
       description,
       total_selling
FROM rank_selling_by_month
WHERE rk = 1


-- solution 2:
WITH total_selling_by_month AS (
    SELECT EXTRACT(MONTH FROM invoicedate) AS invoice_month,          --DATE_PART('month', invoicedate)
           description,
           SUM(unitprice * quantity) AS total_selling,
           DENSE_RANK() OVER (PARTITION BY EXTRACT(MONTH FROM invoicedate) ORDER BY SUM(unitprice * quantity) DESC) AS rk
    FROM online_retail
    GROUP BY invoice_month,
             description
)
SELECT invoice_month,
       description,
       total_selling
FROM total_selling_by_month
WHERE rk = 1
