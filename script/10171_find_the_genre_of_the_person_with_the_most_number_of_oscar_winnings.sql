/*

Title       : Find the genre of the person with the most number of oscar winnings
Link        : https://platform.stratascratch.com/coding/10171-find-the-genre-of-the-person-with-the-most-number-of-oscar-winnings?code_type=1
Difficulty  : Hard
Question    : Find the genre of the person with the most number of oscar winnings.
              If there are more than one person with the same number of oscar wins, return the first one in alphabetic order based on their name. 
              Use the names as keys when joining the tables.
Tables      : oscar_nominees, nominee_information

<oscar_nominees>
year              int
category          varchar
nominee           varchar
movie             varchar
winner            bool
id                int

<nominee_information>
name              varchar
amg_person_id     varchar
top_genre         varchar
birthday          datetime
id                int

*/


-- logic:
-- 1. calculate each oscar winner mapping genre type counts.
--    if same counts then ascending sorting oscar winner name.
-- 2. from #1 result to find max count on genre type.


-- solution 1:
WITH top_oscar_genre AS (
    SELECT noi.name,
           noi.top_genre,
           COUNT(noi.name) AS cnt
    FROM oscar_nominees AS osn
    INNER JOIN nominee_information AS noi
        ON osn.nominee = noi.name
    WHERE osn.winner IS TRUE
    GROUP BY noi.name,
             noi.top_genre
    ORDER BY noi.name
)
SELECT DISTINCT top_genre
FROM top_oscar_genre
WHERE cnt = (SELECT MAX(cnt) FROM top_oscar_genre)
