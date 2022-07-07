/*

Title       : Duplicate Emails
Link        : https://platform.stratascratch.com/coding/9895-duplicate-emails?code_type=1
Difficulty  : Medium
Question    : Find all emails with duplicates.
Tables      : employee

<employee>
id                    int
first_name            varchar
last_name             varchar
age                   int
sex                   varchar
employee_title        varchar
department            varchar
salary                int
target                int
bonus                 int
email                 varchar
city                  varchar
address               varchar
manager_id            int

*/


-- solution 1:
WITH email_cnt AS (
    SELECT email,
           COUNT(email) AS email_cnt
    FROM employee
    GROUP BY email
)
SELECT email
FROM email_cnt
WHERE email_cnt > 1


-- solution 2:
SELECT email
FROM employee
GROUP BY email
HAVING COUNT(email) > 1
