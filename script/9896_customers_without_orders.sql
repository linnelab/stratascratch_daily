/*

Title       : Customers Without Orders
Link        : https://platform.stratascratch.com/coding/9896-customers-without-orders?code_type=1
Difficulty  : Medium
Question    : Find customers who have never made an order.
              Output the first name of the customer.
Tables      : customers, orders

<customers>
id                    int
first_name            varchar
last_name             varchar
city                  varchar
address               varchar
phone_number          varchar

<orders>
id                    int
cust_id               int
order_date            datetime
order_details         varchar
total_order_cost      int

*/


-- logic: 
-- semi join
-- can use not in or use left join where cust_id on orders table is null (indicate customer is not order)


-- solution 1:
SELECT first_name
FROM customers
WHERE id NOT IN (
    SELECT cust_id
    FROM orders
)


-- solution 2:
SELECT DISTINCT c.first_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.cust_id
WHERE o.cust_id IS NULL
