/*

Title       : Top Percentile Fraud
Link        : https://platform.stratascratch.com/coding/10303-top-percentile-fraud?code_type=1
Difficulty  : Hard
Question    : ABC Corp is a mid-sized insurer in the US and in the recent past their fraudulent claims have increased significantly 
              for their personal auto insurance portfolio. 
              They have developed a ML based predictive model to identify propensity of fraudulent claims. 
              Now, they assign highly experienced claim adjusters for top 5 percentile of claims identified by the model.
              Your objective is to identify the top 5 percentile of claims from each state. 
              Your output should be policy number, state, claim cost, and fraud score.
Tables      : fraud_score

<fraud_score>
policy_num        varchar
state             varchar
claim_cost        int
fraud_score       float

*/


-- logic:

-- [solution 1]:
-- 1. use NTILE() function equally distributed records to 100 buckets, 
--    distributed method : use state column partition and sort fraud_score column by descending.
-- 2. from one hundred of buckets to find the top 5 percentile.

-- [solution 2]:
-- 1. use PERCENTILE_CONT() to get each state percentile.
-- 2. determine fraud_score whether over state percentile.


-- solution 1:
WITH rank_data AS (
    SELECT policy_num,
           state,
           claim_cost,
           fraud_score,
           NTILE(100) OVER (PARTITION BY state ORDER BY fraud_score DESC) AS percentile
    FROM fraud_score
)
SELECT policy_num,
       state,
       claim_cost,
       fraud_score
FROM rank_data
WHERE percentile < 6


-- solution 2:
WITH percentiles AS (
    SELECT state,
           PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY fraud_score DESC) AS percentile
    FROM fraud_score
    GROUP BY state
)
SELECT *
FROM fraud_score AS f
INNER JOIN percentiles AS p
    ON f.state = p.state
WHERE f.fraud_score >= p.percentile
