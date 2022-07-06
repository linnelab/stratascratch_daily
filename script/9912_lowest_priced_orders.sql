/*

Title       : Lowest Priced Orders
Link        : https://platform.stratascratch.com/coding/9912-lowest-priced-orders?code_type=1
Difficulty  : Medium
Question    : Find the lowest order cost of each customer.
              Output the customer id along with the first name and the lowest order price.
Tables      : customers, orders

<customers> 
id                      int
first_name              varchar
last_name               varchar
city                    varchar
address                 varchar
phone_number            varchar

<orders>
id                      int
cust_id                 int
order_date              datetime
order_details           varchar
total_order_cost        int

*/


-- solution 1:
SELECT c.id,
       c.first_name,
       MIN(o.total_order_cost) AS lowest_order_price
FROM customers AS c
INNER JOIN orders AS o
    ON c.id = o.cust_id
GROUP BY c.id,
         c.first_name
