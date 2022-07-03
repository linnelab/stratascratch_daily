/*

Title       : Counting Instances in Text
Link        : https://platform.stratascratch.com/coding/9814-counting-instances-in-text?code_type=1
Difficulty  : Hard
Question    : Find the number of times the words 'bull' and 'bear' occur in the contents. 
              We're counting the number of times the words occur so words like 'bullish' should not be included in our count.
              Output the word 'bull' and 'bear' along with the corresponding number of occurrences.
Tables      : google_file_store

<google_file_store>
filename        varchar
contents        varchar

*/


-- logic:

-- [solution 1]
-- 1. use empty char to split string, and each text into array type. (use STRING_TO_ARRAY())
-- 2. array elements set each rows in table. (use UNNEST())
-- 3. get the number of 'bull' and 'bear' text.

-- [solution 2]
-- 1. TO_TSVECTOR() : get text in string, and return text and text in string location.
-- Ref link : https://www.postgresql.org/docs/current/textsearch-controls.html
--            https://www.twblogs.net/a/5b8d139c2b717718833a9926

-- 2. TS_STAT() : 
-- count the word appear frequency.
-- return columns name :
-- 1. word   : text.
-- 2. ndoc   : the number of the word occurred in document.
-- 3. nentry : total number of occurrences of the word.
-- Ref link : https://blog.csdn.net/weixin_39540651/article/details/104043260
--            https://www.postgresql.org/docs/current/textsearch-features.html#TEXTSEARCH-STATISTICS


-- solution 1:
WITH split_text AS (
    SELECT UNNEST(STRING_TO_ARRAY(contents, ' ')) AS each_text
    FROM google_file_store
)
SELECT each_text,
       COUNT(each_text) AS text_cnt
FROM split_text
WHERE each_text in ('bull', 'bear')
GROUP BY each_text


-- solution 2:
SELECT word,
       nentry
FROM TS_STAT('SELECT TO_TSVECTOR(contents) FROM google_file_store')
WHERE word IN ('bull', 'bear')
