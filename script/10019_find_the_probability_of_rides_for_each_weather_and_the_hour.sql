/*

Title       : Find the probability of rides for each weather and the hour
Link        : https://platform.stratascratch.com/coding/10019-find-the-probability-of-ordering-a-ride-based-on-the-weather-and-the-hour?code_type=1
Difficulty  : Hard
Question    : Find the probability of total rides each weather-hour combination constitutes
              Output the weather, hour along with the corresponding probability.
              Sort records by the weather and the hour in ascending order.
Tables      : lyft_rides

<lyft_rides>
index                 int
weather               varchar
hour                  int
travel_distance       float
gasoline_cost         float

*/


-- logic:
-- 1. calculate lyft rides all records.
-- 2. calculate each of the number of weather and hour.  
-- 3. calculate probability = use #2 result / #1 result to get each wheather and hour ratio.


-- solution 1:
WITH all_count AS (
    SELECT COUNT(*) AS cnt
    FROM lyft_rides
), each_count AS (
    SELECT weather,
           hour,
           COUNT(*) AS cnt
    FROM lyft_rides
    GROUP BY 1, 2
)
SELECT e.weather,
       e.hour,
       (e.cnt / a.cnt::float) AS probability
FROM all_count AS a, each_count AS e
ORDER BY 1, 2
