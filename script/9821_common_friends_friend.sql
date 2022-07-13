/*

Title       : Common Friends Friend
Link        : https://platform.stratascratch.com/coding/9821-common-friends-friend?code_type=1
Difficulty  : Hard
Question    : Find the number of a user's friends' friend who are also the user's friend. 
              Output the user id along with the count.
Tables      : google_friends_network

<google_friends_network>
user_id         int
friend_id       int

*/


-- logic:
-- 1. because friend_id and user_id each other are friends, so need translate friend_id and user_id column, then combine with original table,
--    to get all friends and user mapping list.
-- 2. because want to get user's friends's friends, so join A friend_id and B user_id columns to get the result.
--    result descriptions : user_id = A, A friend is B, and B friend is C. (A -> B -> C),
-- 3. want to determine C and A are friends, so inner join again, then determine C friend_id equal to A user_id column.
--    result descriptions : user_id = A, A friend is B, B friend is C, then C and A are friends. (A -> B -> C -> A).
-- 4. count #3 result for each user_id.


-- solution 1:
WITH all_user_friends_list AS (
    SELECT user_id,
           friend_id
    FROM google_friends_network
    UNION 
    SELECT friend_id,
           user_id
    FROM google_friends_network
), friend_relationship AS (
    SELECT DISTINCT a.user_id,
                    c.user_id AS friend
    FROM all_user_friends_list AS a
    INNER JOIN all_user_friends_list AS b
        ON a.friend_id = b.user_id
    INNER JOIN all_user_friends_list AS c
        ON b.friend_id = c.user_id
        AND c.friend_id = a.user_id
)
SELECT user_id,
       COUNT(DISTINCT friend) AS friend_cnt
FROM friend_relationship
GROUP BY user_id
ORDER BY user_id
