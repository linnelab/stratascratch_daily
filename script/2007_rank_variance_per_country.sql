/*

Title       : Rank Variance Per Country
Link        : https://platform.stratascratch.com/coding/2007-rank-variance-per-country?code_type=1
Difficulty  : Hard
Question    : Which countries have risen in the rankings based on the number of comments between Dec 2019 vs Jan 2020? 
              Hint: Avoid gaps between ranks when ranking countries.
Tables      : fb_comments_count, fb_active_users

<fb_comments_count>
user_id                   int
created_at                datetime
number_of_comments        int

<fb_active_users>
user_id                   int
name                      varchar
status                    varchar
country                   varchar

*/


-- logic:
-- 1. rank 2019 december comments counts for each country.
-- 2. rank 2020 January comments counts for each country.
-- 3. join #1 and #2 results to find rank have level up country from 2019-12 to 2020-01.


-- note:
-- I thought this question not clear descriptions.
-- this questions goal: want to get comments count have level up country from 2019-12 to 2020-01, 
-- and results contain 2019-12 no rank but 2020-01 have rank records, this case will match rank level up.


-- solution 1:
WITH dec_comments_rank AS (
    SELECT u.country,
           COUNT(c.number_of_comments) AS comments_cnt,
           DENSE_RANK() OVER (ORDER BY COUNT(c.number_of_comments) DESC) AS rk
    FROM fb_comments_count AS c
    INNER JOIN fb_active_users AS u
        ON c.user_id = u.user_id
    WHERE TO_CHAR(c.created_at, 'yyyy-mm') = '2019-12'
    GROUP BY u.country
), jan_comments_rank AS (
    SELECT u.country,
           COUNT(c.number_of_comments) AS comments_cnt,
           DENSE_RANK() OVER (ORDER BY COUNT(c.number_of_comments) DESC) AS rk
    FROM fb_comments_count AS c
    INNER JOIN fb_active_users AS u
        ON c.user_id = u.user_id
    WHERE TO_CHAR(c.created_at, 'yyyy-mm') = '2020-01'
    GROUP BY u.country
)
SELECT jan.country
FROM jan_comments_rank AS jan
LEFT JOIN dec_comments_rank AS dec
    ON jan.country = dec.country
WHERE jan.rk < dec.rk
    OR dec.rk IS NULL
