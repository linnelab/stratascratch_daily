/*

Title       : Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut
Link        : https://platform.stratascratch.com/coding/10026-find-all-wineries-which-produce-wines-by-possessing-aromas-of-plum-cherry-rose-or-hazelnut?code_type=1
Difficulty  : Medium
Question    : Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut. 
              To make it more simple, look only for singular form of the mentioned aromas. 
              Output unique winery values only.
Tables      : winemag_p1

<winemag_p1>
id                    int
country               varchar
description           varchar
designation           varchar
points                int
price                 float
province              varchar
region_1              varchar
region_2              varchar
variety               varchar
winery                varchar

*/


-- logic: 
-- find description contain keywords: plum, cherry, rose, hazelnut


-- note:
-- 1. use posix regix to find keywords.
-- ref link : https://www.delftstack.com/zh-tw/howto/postgres/postgresql-select-if-string-contains/

-- 2. ~* : indicate string matches regular expression, case insensitively.

-- 3. PostgreSQL uses \y as word boundaries.
--    \y : matches only at the beginning or end of a word.

--    e.g. select * from table_name where column ~* '\yAB\y';
--    This will match 'AB', 'ab', 'ab - text', 'text ab', 'text AB', 'text-ab-text', 'text AB text' ... etc.

-- ref link : 
-- https://stackoverflow.com/questions/3825676/postgresql-regex-word-boundaries
-- https://www.postgresql.org/docs/current/functions-matching.html#POSIX-CONSTRAINT-ESCAPES-TABLE


-- solution 1:
SELECT winery
FROM winemag_p1
WHERE description ~* '\y(plum|cherry|rose|hazelnut)\y'
