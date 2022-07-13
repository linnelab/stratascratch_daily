/*

Title       : The Most Popular Client_Id Among Users Using Video and Voice Calls
Link        : https://platform.stratascratch.com/coding/2029-the-most-popular-client_id-among-users-using-video-and-voice-calls?code_type=1
Difficulty  : Hard
Question    : Select the most popular client_id based on a count of the number of users 
              who have at least 50% of their events from the following list: 
              'video call received', 'video call sent', 'voice call received', 'voice call sent'.
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
-- [solution 1]:
-- 1. find special four event_type total records.
-- 2. find each of the number of client id.
-- 3. calculate avg user #1 result to divide #2 result, and get each of client id ratio, then determine this ratio whether bigger than 0.5 (i.e. 50%).

-- [solution 2]:
-- 1. In special four event type, find client id and user id have avg value bigger than 0.5 records.
-- 2. calculate each client id counts and ranking by counts.
-- 3. find rank = 1 to get the highest use client id.


-- solution 1:
WITH all_cnt AS (
    SELECT COUNT(*) AS total_cnt
    FROM fact_events
    WHERE event_type IN ('video call received', 'video call sent', 'voice call received', 'voice call sent')
), each_cnt AS (
    SELECT client_id,
           COUNT(*) AS each_clientid_cnt
    FROM fact_events
    WHERE event_type IN ('video call received', 'video call sent', 'voice call received', 'voice call sent')
    GROUP BY client_id
)
SELECT e.client_id
FROM all_cnt AS a, each_cnt AS e
WHERE (e.each_clientid_cnt / a.total_cnt::FLOAT) > 0.5


-- solution 2:
WITH each_cnt_list AS (
    SELECT client_id, 
           user_id
    FROM fact_events
    GROUP BY client_id, 
             user_id
    HAVING AVG(CASE WHEN event_type IN ('video call received', 'video call sent', 'voice call received', 'voice call sent') THEN 1 ELSE 0 END) > 0.5
), client_id_cnt AS (
    SELECT client_id,
           COUNT(*) AS cnt,
           DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rk
    FROM each_cnt_list
    GROUP BY client_id
)
SELECT client_id
FROM client_id_cnt
WHERE rk = 1
