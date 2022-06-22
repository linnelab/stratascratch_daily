/*
Title       : Finding User Purchases
Link        : https://platform.stratascratch.com/coding/10322-finding-user-purchases?code_type=1
Difficulty  : Medium
Question    : Write a query that'll identify returning active users. 
              A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. 
              Output a list of user_ids of these returning active users.
Tables      : amazon_transactions

<amazon_transactions>
id              int
user_id         int
item            varchar
created_at      datetime
revenue         int
*/

-- note:
-- a1.id <> a2.id : self-join table produce same shop id to need exclude.


-- solution 1: 
SELECT DISTINCT a1.user_id
FROM amazon_transactions AS a1
INNER JOIN amazon_transactions AS a2
    ON a1.user_id = a2.user_id
WHERE (a1.created_at - a2.created_at) BETWEEN 0 AND 7
    AND a1.id <> a2.id


-- solution 2: 
SELECT DISTINCT a1.user_id
FROM amazon_transactions AS a1
INNER JOIN amazon_transactions AS a2
    ON a1.user_id = a2.user_id
    AND (a1.created_at - a2.created_at) BETWEEN 0 AND 7
    AND a1.id <> a2.id
