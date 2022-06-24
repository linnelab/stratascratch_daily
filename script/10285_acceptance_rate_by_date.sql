/*

Title       : Acceptance Rate By Date
Link        : https://platform.stratascratch.com/coding/10285-acceptance-rate-by-date?code_type=1
Difficulty  : Medium
Question    : What is the overall friend acceptance rate by date? Your output should have the rate of acceptances by the date the request was sent. 
              Order by the earliest date to latest.
              Assume that each friend request starts by a user sending (i.e., user_id_sender) a friend request to another user (i.e., user_id_receiver) 
              that's logged in the table with action = 'sent'. If the request is accepted, the table logs action = 'accepted'. 
              If the request is not accepted, no record of action = 'accepted' is logged.
Tables      : fb_friend_requests

<fb_friend_requests>
user_id_sender           varchar
user_id_receiver         varchar
date                     datetime
action                   varchar

*/


-- logic:
-- 1. get user sent data.
-- 2. get user accepted data.
-- 3. join, when sent user and accepted user equal, will get sent date and accepted date on one raw.
-- 4. calulate recive 


-- solution 1: 
WITH get_send_data AS (
    SELECT user_id_sender, user_id_receiver, date AS sent_date
    FROM fb_friend_requests
    WHERE action = 'sent'
), get_accepted_data AS (
    SELECT user_id_sender, user_id_receiver, date AS accepted_date
    FROM fb_friend_requests
    WHERE action = 'accepted'
)
SELECT s.sent_date, 
       COUNT(a.user_id_receiver) / CAST(COUNT(s.user_id_sender) AS DECIMAL) AS percentage_acceptance
FROM get_send_data AS s
LEFT JOIN get_accepted_data AS a
    ON s.user_id_sender = a.user_id_sender
    AND s.user_id_receiver = a.user_id_receiver
GROUP BY s.sent_date
