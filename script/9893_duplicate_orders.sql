/*

Title       : Duplicate Orders
Link        : https://platform.stratascratch.com/coding/9893-duplicate-orders?code_type=1
Difficulty  : Medium
Question    : Find customers who appear in the orders table more than three times.
Tables      : orders

<orders>
id                    int
cust_id               int
order_date            datetime
order_details         varchar
total_order_cost      int

*/


-- note: 
-- solution 2: great and simple solution


-- solution 1:
WITH appear_cnt AS (
    SELECT cust_id, 
           COUNT(cust_id) AS cnt
    FROM orders
    GROUP BY cust_id
)
SELECT cust_id
FROM appear_cnt
WHERE cnt > 3


-- solution 2:
SELECT cust_id
FROM orders
GROUP BY cust_id
HAVING COUNT(cust_id) > 3
