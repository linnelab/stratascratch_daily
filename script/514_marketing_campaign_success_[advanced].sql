/*

Title       : Marketing Campaign Success [Advanced]
Link        : https://platform.stratascratch.com/coding/514-marketing-campaign-success-advanced?code_type=1
Difficulty  : Hard
Question    : You have a table of in-app purchases by user. 
              Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases. 
              Find the number of users that made additional in-app purchases due to the success of the marketing campaign.
              The marketing campaign doesn't start until one day after the initial in-app purchase 
              so users that only made one or multiple purchases on the first day do not count, 
              nor do we count users that over time purchase only the products they purchased on the first day.
Tables      : marketing_campaign

<marketing_campaign>
user_id            int
created_at         datetime
product_id         int
quantity           int
price              int

*/


-- logic:
-- Solution 1:
-- 1. Use first cte query to except cases as below: (use COUNT(DISTINCT created_at) > 1 and COUNT(DISTINCT product_id) > 1).
--    a. purchase days only one date however purchase item is one or more.
--    b. Many days purchase same product items.
-- 2. Use second cte query to partition each of user_id and rank purchase date(i.e. created_at). 
--    And concate user_id and purchase_id are called "user_product_id" as one column.
--    We can use "user_product_id" to determine which product_id records not same as frist day (i.e. rank - 1), then need to count how much user_id?

-- Solution 2:
-- 1. partition by user_id then get first purchase date as "first_purchase_date" column.
-- 2. partition by user_id and product_id, when other date purchase item equal first date, then get min date as "first_product_purchase_date" column.
--    (so if get min date represent other date will purchase same product as frist date)
-- 3. calculate user count.


-- solution 1: 
WITH purchase_many_days AS (
    SELECT user_id, 
           COUNT(DISTINCT created_at) AS purchase_day, 
           COUNT(DISTINCT product_id) AS product_cnt
    FROM marketing_campaign
    GROUP BY user_id
    HAVING COUNT(DISTINCT created_at) > 1
        AND COUNT(DISTINCT product_id) > 1      -- continue purchase same product on many days
    ORDER BY user_id
), rank_purchase_record AS (
    SELECT *,
           RANK() OVER (PARTITION BY user_id ORDER BY created_at) AS rk,
           CONCAT(user_id, '_', product_id) AS user_product_id
    FROM marketing_campaign
) 
SELECT COUNT(DISTINCT user_id) AS user_cnt
FROM marketing_campaign
WHERE user_id IN (SELECT user_id FROM purchase_many_days)
    AND CONCAT(user_id, '_', product_id)
        NOT IN (SELECT user_product_id FROM rank_purchase_record WHERE rk = 1)
        

-- solution 2:
WITH marketing_list AS (
    SELECT user_id,
           MIN(created_at) OVER (PARTITION BY user_id) AS first_purchase_date,
           MIN(created_at) OVER (PARTITION BY user_id, product_id) AS first_product_purchase_date
    FROM marketing_campaign
)
SELECT COUNT(DISTINCT user_id)
FROM marketing_list
WHERE first_purchase_date <> first_product_purchase_date
