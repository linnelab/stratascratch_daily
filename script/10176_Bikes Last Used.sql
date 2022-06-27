/*

Title       : Bikes Last Used
Link        : https://platform.stratascratch.com/coding/10176-bikes-last-used?code_type=1
Difficulty  : Easy
Question    : Find the last time each bike was in use. 
              Output both the bike number and the date-timestamp of the bike's last use (i.e., the date-time the bike was returned). 
              Order the results by bikes that were most recently used.
Tables      : dc_bikeshare_q1_2012

<dc_bikeshare_q1_2012>
duration                 varchar
duration_seconds         int
start_time               datetime
start_station            varchar
start_terminal           int
end_time                 datetime
end_station              varchar
end_terminal             int
bike_number              varchar
rider_type               varchar
id                       int

*/


-- logic : 
-- 1. find each of bike_number use bike end time.
-- 2. order by latest bike use time.


-- solution 1: 
SELECT bike_number,
       MAX(end_time) AS last_time
FROM dc_bikeshare_q1_2012
GROUP BY bike_number
ORDER BY last_time DESC
