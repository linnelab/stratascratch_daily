/*

Title       : Find the rate of processed tickets for each type
Link        : https://platform.stratascratch.com/coding/9781-find-the-rate-of-processed-tickets-for-each-type?code_type=1
Difficulty  : Medium
Question    : Find the rate of processed tickets for each type.
Tables      : facebook_complaints

<facebook_complaints>
complaint_id      int
type              int
processed         bool

*/


-- logic:
-- get processed rate : (the number of each type is true processed / total processed count for each type)
-- solution 2 : For processed = true records change to 1, then sum records. It will get the number of each type is true processed.


-- note:
-- The denominator needs to change the data type as numeric or decimal, the final result (i.e. processed rate) will have decimal point. 


-- solution 1:
WITH each_type_processed_cnt AS (
    SELECT type,
           COUNT(*) AS processed_cnt
    FROM facebook_complaints
    WHERE processed IS TRUE
    GROUP BY type
), each_type_total_cnt AS (
    SELECT type,
           COUNT(*) AS total_cnt
    FROM facebook_complaints
    GROUP BY type
)
SELECT p.type,
       p.processed_cnt / CAST(t.total_cnt AS DECIMAL) AS processed_rate
FROM each_type_processed_cnt AS p
INNER JOIN each_type_total_cnt AS t
    ON p.type = t.type


-- solution 2:
SELECT type,
       SUM(CASE WHEN processed IS TRUE THEN 1 ELSE 0 END) / COUNT(*)::NUMERIC AS processed_rate
FROM facebook_complaints
GROUP BY type
