/*

Title       : Top Ranked Songs
Link        : https://platform.stratascratch.com/coding/9991-top-ranked-songs?code_type=1
Difficulty  : Medium
Question    : Find songs that have ranked in the top position. 
              Output the track name and the number of times it ranked at the top. 
              Sort your records by the number of times the song was in the top position in descending order.
Tables      : spotify_worldwide_daily_song_ranking

<spotify_worldwide_daily_song_ranking>
id                  int
position            int
trackname           varchar
artist              varchar
streams             int
url                 varchar
date                datetime
region              varchar

*/


-- note:
-- 1. use count(*) to count the rows. 
--    You might get a different number in the output if you use a column in the count() since there could be nulls. 
--    Will need to carefully select what column to count or to use a count(*) depending on what you find in the data.


-- solution 1:
SELECT trackname,
       COUNT(*) AS top_song_cnt
FROM spotify_worldwide_daily_song_ranking
WHERE position = 1
GROUP BY trackname
ORDER BY top_song_cnt DESC
