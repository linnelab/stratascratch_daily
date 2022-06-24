/*
Title       : Customer Details
Link        : https://platform.stratascratch.com/coding/9891-customer-details?code_type=1
Difficulty  : Easy
Question    : Find the details of each customer regardless of whether the customer made an order. 
              Output the customer's first name, last name, and the city along with the order details.
              You may have duplicate rows in your results due to a customer ordering several of the same items. 
              Sort records based on the customer's first name and the order details in ascending order.
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

-- logic: use custumer id join two tables and find customer detail order


-- solution 1: 
SELECT c.first_name, 
       c.last_name, 
       c.city, 
       o.order_details
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.cust_id
ORDER BY c.first_name, o.order_details
