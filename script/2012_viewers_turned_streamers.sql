/*

Title       : Viewers Turned Streamers
Link        : https://platform.stratascratch.com/coding/2012-viewers-turned-streamers?code_type=1
Difficulty  : Hard
Question    : From users who had their first session as a viewer, how many streamer sessions have they had? 
              Return the user id and number of sessions in descending order. 
              In case there are users with the same number of sessions, order them by ascending user id.
Tables      : twitch_sessions

<twitch_sessions>
user_id               int
session_start         datetime
session_end           datetime
session_id            int
session_type          varchar

*/


-- logic:
-- 1. rank each user_id session start and session end.
-- 2. find user_id is rank = 1 and session type is viewer.
-- 3. use #2 result to find which user_id are matched, and counts the number of session_type is 'streamer' for these user_id.


-- solution 1:
WITH rank_session AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY user_id ORDER BY session_start, session_end) AS rk
    FROM twitch_sessions
), first_viewer_userid AS (
    SELECT user_id
    FROM rank_session
    WHERE rk = 1 AND session_type = 'viewer'
)
SELECT user_id,
       COUNT(user_id) AS streamer_cnt
FROM twitch_sessions
WHERE user_id IN (SELECT user_id FROM first_viewer_userid)
    AND session_type = 'streamer'
GROUP BY user_id
ORDER BY streamer_cnt DESC, user_id ASC
