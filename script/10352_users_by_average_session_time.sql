/*

Title       : Users By Average Session Time
Link        : https://platform.stratascratch.com/coding/10352-users-by-avg-session-time?code_type=1
Difficulty  : Medium
Question    : Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. 
              For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, 
              consider only the latest page_load and earliest page_exit. Output the user_id and their average session time.
Tables      : facebook_web_log

<facebook_web_log>
user_id                int
timestamp              datetime
action                 varchar

*/

-- note: 
-- DATE(timestamp) : change timestamp column to date as action date (i.e. load date or exit date..etc).

-- logic:
-- Use max load time subtract min exit time as session duration, then calculate average session time per user.


-- solution 1: advance method
WITH daily_session_duration AS (
    SELECT load.user_id,
           DATE(load.timestamp) AS date,
           MIN(exit.timestamp) - MAX(load.timestamp) AS session_duration
    FROM facebook_web_log AS load
    INNER JOIN facebook_web_log AS exit
        ON load.user_id = exit.user_id
    WHERE load.action = 'page_load'
        AND exit.action = 'page_exit'
        AND exit.timestamp > load.timestamp
    GROUP BY load.user_id, date
)
SELECT user_id,
       AVG(session_duration)
FROM daily_session_duration
GROUP BY user_id


-- solution 2: intuitive method
WITH load AS (
    SELECT user_id,
           DATE(timestamp) AS date,
           MAX(timestamp) AS max_time
    FROM facebook_web_log
    WHERE action = 'page_load'
    GROUP BY user_id, date
), exit AS (
    SELECT user_id,
           DATE(timestamp) AS date,
           MIN(timestamp) AS min_time
    FROM facebook_web_log
    WHERE action = 'page_exit'
    GROUP BY user_id, date
)
SELECT e.user_id,
       AVG(e.min_time - l.max_time) AS avg_session_time
FROM exit AS e
INNER JOIN load AS l
    ON e.user_id = l.user_id
GROUP BY e.user_id
