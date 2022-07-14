/*

Title       : Name to Medal Connection
Link        : https://platform.stratascratch.com/coding/9952-name-to-medal-connection?code_type=1
Difficulty  : Hard
Question    : Find the connection between the number of letters in the athlete's first name and the number of medals won for each type for medal, 
              including no medals. Output the length of the name along with the corresponding number of no medals, bronze medals, silver medals, and gold medals.
Tables      : olympics_athletes_events

<olympics_athletes_events>
id            int
name          varchar
sex           varchar
age           float
height        float
weight        datetime
team          varchar
noc           varchar
games         varchar
year          int
season        varchar
city          varchar
sport         varchar
event         varchar
medal         varchar

*/


-- logic:
-- 1. from name column get first name length.
-- 2. calculate each of medal kind counts, contain no medal, bronze, sliver, gold.


-- note:
-- 1. when where medal is null, not use medal column to count , 
--    because medal column is not value can calculate count, will get zero value for all first_name_length.


-- solution 1:
SELECT LENGTH(SPLIT_PART(name, ' ', 1)) AS first_name_length,
       COUNT(name) FILTER (WHERE medal IS NULL),
       COUNT(name) FILTER (WHERE medal = 'Bronze'),
       COUNT(name) FILTER (WHERE medal = 'Silver'),
       COUNT(name) FILTER (WHERE medal = 'Gold')
FROM olympics_athletes_events
GROUP BY 1
