/*

Title       : Second Highest Salary
Link        : https://platform.stratascratch.com/coding/9892-second-highest-salary?code_type=1
Difficulty  : Medium
Question    : Find the second highest salary of employees.
Tables      : employee

<employee>
id                      int
first_name              varchar
last_name               varchar
age                     int
sex                     varchar
employee_title          varchar
department              varchar
salary                  int
target                  int
bonus                   int
email                   varchar
city                    varchar
address                 varchar
manager_id              int

*/


-- logiic:
-- use DENSE_RANK() to get salary rank then get the second highest rank.


-- solution 1:
WITH salary_rank AS (
    SELECT salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS rk
    FROM employee
)
SELECT salary
FROM salary_rank
WHERE rk = 2
