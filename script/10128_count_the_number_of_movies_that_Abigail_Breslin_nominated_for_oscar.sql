/*

Title       : Count the number of movies that Abigail Breslin nominated for oscar
Link        : https://platform.stratascratch.com/coding/10128-count-the-number-of-movies-that-abigail-breslin-nominated-for-oscar?code_type=1
Difficulty  : Easy
Question    : Count the number of movies that Abigail Breslin was nominated for an oscar.
Tables      : oscar_nominees

<oscar_nominees>
year            int
category        varchar
nominee         varchar
movie           varchar
winner          bool
id              int

*/


-- solution 1:
SELECT COUNT(*) AS oscar_nominee_cnt
FROM oscar_nominees
WHERE nominee = 'Abigail Breslin'
