/*

Title       : Popularity Percentage
Link        : https://platform.stratascratch.com/coding/10284-popularity-percentage?code_type=1
Difficulty  : Hard
Question    : Find the popularity percentage for each user on Meta/Facebook. 
              The popularity percentage is defined as the total number of friends the user has divided by the total number of users on the platform, 
              then converted into a percentage by multiplying by 100. 
              Output each user along with their popularity percentage. Order records in ascending order by user id.
              The 'user1' and 'user2' column are pairs of friends.
Tables      : facebook_friends

<facebook_friends>
user1             int
user2             int

*/


-- logic:
-- 1. union all platform users because user1 and user2 column are pairs of friends.
-- 2. count every user own friends numbers.
-- 3. calculate total user on the platform.
-- 4. calculate popularity percentage = (2/3) * 100

-- note:
-- need to convert data type from "int" to "float" or "decimal" when division operation.
-- sum() over()

-- solution 1: 
WITH friends_list AS (
    SELECT user1, user2
    FROM facebook_friends
    UNION
    SELECT user2, user1
    FROM facebook_friends
), friends_cnt AS (
    SELECT user1, COUNT(*) AS friends_cnt
    FROM friends_list
    GROUP BY user1
), total_users AS (
    SELECT COUNT(DISTINCT user1) AS total_user_cnt
    FROM friends_list
)
SELECT user1 AS user_id, 
       (friends_cnt / total_user_cnt::DECIMAL) * 100 AS popular_percentage
FROM friends_cnt, total_users
ORDER BY user1


-- solution 2: good solution
WITH friends_list AS (
    SELECT user1
    FROM facebook_friends
    UNION ALL
    SELECT user2
    FROM facebook_friends
)
SELECT user1,
       100 * COUNT(user1) / SUM(COUNT(DISTINCT(user1))) OVER()::DECIMAL AS popular_percentage
FROM friends_list
GROUP BY user1
ORDER BY user1
