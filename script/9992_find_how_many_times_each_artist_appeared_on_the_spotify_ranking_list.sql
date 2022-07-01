/*

Title       : Find how many times each artist appeared on the Spotify ranking list
Link        : https://platform.stratascratch.com/coding/9992-find-artists-that-have-been-on-spotify-the-most-number-of-times?code_type=1
Difficulty  : Easy
Question    : Find how many times each artist appeared on the Spotify ranking list
              Output the artist name along with the corresponding number of occurrences.
              Order records by the number of occurrences in descending order.
Tables      : spotify_worldwide_daily_song_ranking

<spotify_worldwide_daily_song_ranking>
id                int
position          int
trackname         varchar
artist            varchar
streams           int
url               varchar
date              datetime
region            varchar

*/


-- solution 1:
SELECT artist,
       COUNT(*) AS appeared_cnt
FROM spotify_worldwide_daily_song_ranking
GROUP BY artist
ORDER BY appeared_cnt DESC
