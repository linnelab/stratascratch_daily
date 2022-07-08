/*

Title       : Percentage Of Total Spend
Link        : https://platform.stratascratch.com/coding/9899-percentage-of-total-spend?code_type=1
Difficulty  : Medium
Question    : Calculate the percentage of the total spend a customer spent on each order. 
              Output the customer’s first name, order details, and percentage of the order cost to their total spend across all orders.
              Assume each customer has a unique first name 
              (i.e., there is only 1 customer named Karen in the dataset) and that customers place at most only 1 order a day.
              Percentages should be represented as decimals
Tables      : orders, customers

<orders>
id                      int
cust_id                 int
order_date              datetime
order_details           varchar
total_order_cost        int

<customers>
id                      int
first_name              varchar
last_name               varchar
city                    varchar
address                 varchar
phone_number            varchar

*/


-- logic:
-- use cust_id column do partition and sum every partition range total order cost, then divide every order cost.


-- solution 1:
SELECT c.first_name,
       o.order_details,
       o.total_order_cost / SUM(o.total_order_cost) OVER (PARTITION BY o.cust_id)::DECIMAL AS percentage_total_cost
FROM orders AS o
INNER JOIN customers AS c
    ON o.cust_id = c.id
