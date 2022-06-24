/*

Title       : Highest Cost Orders
Link        : https://platform.stratascratch.com/coding/9915-highest-cost-orders?code_type=1
Difficulty  : Medium
Question    : Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. 
              If customer had more than one order on a certain day, sum the order costs on daily basis. 
              Output customer's first name, total cost of their items, and the date.
              For simplicity, you can assume that every first name in the dataset is unique.
Tables      : customers, orders

<customers>
id                  int
first_name          varchar
last_name           varchar
city                varchar
address             varchar
phone_number        varchar

<orders>
id                  int
cust_id             int
order_date          datetime
order_details       varchar
total_order_cost    int

*/


-- solution : 
WITH cost_orders AS (
    SELECT first_name, SUM(total_order_cost) AS total_order_cost, order_date
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.id = o.cust_id
    WHERE o.order_date BETWEEN '2019-02-01' AND '2019-05-01'
    GROUP BY first_name, order_date
)
SELECT *
FROM cost_orders
WHERE total_order_cost = (SELECT MAX(total_order_cost) FROM cost_orders)
