/*

Title       : Customer Revenue In March
Link        : https://platform.stratascratch.com/coding/9782-customer-revenue-in-march?code_type=1
Difficulty  : Medium
Question    : Calculate the total revenue from each customer in March 2019. 
              Include only customers who were active in March 2019. 
              Output the revenue along with the customer id and sort the results based on the revenue in descending order.
Tables      : orders

<orders>
id                     int
cust_id                int
order_date             datetime
order_details          varchar
total_order_cost       int

*/


-- solution 1: 
SELECT cust_id, SUM(total_order_cost) AS revenue
FROM orders
WHERE TO_CHAR(order_date, 'YYYY-MM') = '2019-03'
GROUP BY cust_id
ORDER BY revenue DESC
