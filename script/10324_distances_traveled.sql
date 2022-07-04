/*

Title       : Distances Traveled
Link        : https://platform.stratascratch.com/coding/10324-distances-traveled?code_type=1
Difficulty  : Medium
Question    : Find the top 10 users that have traveled the greatest distance. 
              Output their id, name and a total distance traveled.
Tables      : lyft_rides_log, lyft_users

<lyft_rides_log>
id              int
user_id         int
distance        int

<lyft_users>
id              int
name            varchar

*/


-- solution 1:
WITH users_rk AS ( 
    SELECT l.user_id,
           u.name,
           SUM(l.distance) AS total_dist,
           RANK() OVER (ORDER BY SUM(l.distance) DESC) AS rk
    FROM lyft_rides_log AS l
    INNER JOIN lyft_users AS u
        ON l.user_id = u.id
    GROUP BY l.user_id,
             u.name
)
SELECT user_id,
       name,
       total_dist
FROM users_rk
WHERE rk < 11
