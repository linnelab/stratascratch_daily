/*

Title       : Find the top 10 ranked songs in 2010
Link        : https://platform.stratascratch.com/coding/9650-find-the-top-10-ranked-songs-in-2010?code_type=1
Difficulty  : Medium
Question    : What were the top 10 ranked songs in 2010?
              Output the rank, group name, and song name but do not show the same song twice.
              Sort the result based on the year_rank in ascending order.
Tables      : billboard_top_100_year_end

<billboard_top_100_year_end>
id                int
year              int
year_rank         int
group_name        varchar
artist            varchar
song_name         varchar

*/


-- solution 1:
SELECT DISTINCT year_rank,
       group_name,
       song_name
FROM billboard_top_100_year_end
WHERE year = 2010
    AND year_rank < 11
ORDER BY year_rank
