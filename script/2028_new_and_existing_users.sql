/*

Title       : New And Existing Users
Link        : https://platform.stratascratch.com/coding/2028-new-and-existing-users?code_type=1
Difficulty  : Hard
Question    : Calculate the share of new and existing users for each month in the table. 
              Output the month, share of new users, and share of existing users as a ratio.
              New users are defined as users who started using services in the current month (there is no usage history in previous months). 
              Existing users are users who used services in current month, but they also used services in any previous month.
              Assume that the dates are all from the year 2020.
Tables      : fact_events

<fact_events>
id                int
time_id           datetime
user_id           varchar
customer_id       varchar
client_id         varchar
event_type        varchar
event_id          int

*/


-- logic:
-- 1. calculate each month user counts.
-- 2. find user have min time list.
-- 3. use #2 result to calculate new user counts.
-- 4. calculate new user ratio: new user count / total user count (remember change data type to decimal).
-- 5. calculate existing user ratio = 1 - new user ratio (remember change data type to decimal).


-- note:
-- 1. question description made some confuse.
-- 2. when count user_id need to remember distinct duplicate rows.


-- solution 1:
WITH all_user_cnt AS (
    SELECT EXTRACT(MONTH FROM time_id) AS month,
           COUNT(DISTINCT user_id) AS total_user_cnt
    FROM fact_events
    GROUP BY month
), min_time_userid AS (
    SELECT user_id,
           MIN(time_id) AS min_timeid
    FROM fact_events
    GROUP BY user_id
), new_user_cnt AS (
    SELECT EXTRACT(MONTH FROM min_timeid) AS month,
           COUNT(DISTINCT user_id) AS total_user_cnt
    FROM min_time_userid
    GROUP BY month
    ORDER BY month
)
SELECT a.month,
       (n.total_user_cnt / a.total_user_cnt::DECIMAL) AS share_new_users,
       1-(n.total_user_cnt / a.total_user_cnt::DECIMAL) AS share_existing_users
FROM all_user_cnt AS a
INNER JOIN new_user_cnt AS n
    ON a.month = n.month
