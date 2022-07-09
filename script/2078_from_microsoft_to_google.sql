/*

Title       : From Microsoft to Google
Link        : https://platform.stratascratch.com/coding/2078-from-microsoft-to-google?code_type=1
Difficulty  : Hard
Question    : Consider all LinkedIn users who, at some point, worked at Microsoft. 
              For how many of them was Google their next employer right after Microsoft (no employers in between)?
Tables      : linkedin_users

<linkedin_users>
user_id           int
employer          varchar
position          varchar
start_date        datetime
end_date          datetime

*/


-- logic:
-- [solution 1]:
-- 1. self join to get table results have first employer is microsoft and next employer is google, 
--    between no gap, so microsoft end date need to equal google start date.
-- 2. count #1 results.

-- [solution 2]:
-- 1. sort start_date and partition user_id, then use LEAD() to compare next employer for current records, then produce new column records next_employer.
-- 2. filter employer is microsoft and next_employer is google, then count results.


-- note:
-- I thought this questions not clear description "no employers in between" case, so will produce two solutions.

-- [solution 1]: 
-- assume microsoft end date is equal google start date, and between no date gap or no other employer,
-- so this method only get match #1 condition, 
-- if micorsoft end date and google start date in between have no other employer, is not work date gap, this record will not contain on table results.

-- [solution 2]: 
-- assume microsoft end date is equal google start date, and contain no work date gap in between, but not enclude other employer in between.
-- this method can get microsoft start date and google end date have gap in between(i.e. no other employer, no work) records.


-- solution 1:
SELECT COUNT(DISTINCT l1.user_id) AS n_employees
FROM linkedin_users AS l1
INNER JOIN linkedin_users AS l2
    ON l1.user_id = l2.user_id
    AND l1.end_date = l2.start_date
WHERE l1.employer ILIKE 'microsoft'
    AND l2.employer ILIKE 'google'


-- solution 2:
WITH next_employer_list AS (
    SELECT user_id,
           employer,
           LEAD(employer) OVER (PARTITION BY user_id ORDER BY start_date) AS next_employer
    FROM linkedin_users
)
SELECT COUNT(DISTINCT user_id) AS n_employees
FROM next_employer_list
WHERE employer ILIKE 'microsoft'
    AND next_employer ILIKE 'google'
