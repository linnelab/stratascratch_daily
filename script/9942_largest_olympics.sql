/*

Title       : Largest Olympics
Link        : https://platform.stratascratch.com/coding/9942-largest-olympics?code_type=1
Difficulty  : Medium
Question    : Find the Olympics with the highest number of athletes. 
              The Olympics game is a combination of the year and the season, and is found in the 'games' column. 
              Output the Olympics along with the corresponding number of athletes.
Tables      : olympics_athletes_events

<olympics_athletes_events>
id              int
name            varchar
sex             varchar
age             float
height          float
weight          datetime
team            varchar
noc             varchar
games           varchar
year            int
season          varchar
city            varchar
sport           varchar
event           varchar
medal           varchar

*/


-- note:
-- 1. source data have duplicate rows, so need to distinct. 
--    use query to view duplicate rows : (when name = 'Mario Lertora' or name = 'Pierre Tolar')
      SELECT *
      FROM olympics_athletes_events
      WHERE games = '1924 Summer' AND name = 'Mario Lertora'    -- name can change 'Pierre Tolar'
      
-- 2. not suggest using "limit 1" query to get the largest records, 
--    because maybe owning multiple the largest records on the result table.
--    if limit 1, other match records will be missed.


-- solution 1:
WITH game_cnt_rk AS (
    SELECT games,
           COUNT(DISTINCT name) AS athletes_cnt,
           DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT name) DESC) AS rk
    FROM olympics_athletes_events
    GROUP BY games
    ORDER BY rk 
)
SELECT games,
       athletes_cnt
FROM game_cnt_rk
WHERE rk = 1
