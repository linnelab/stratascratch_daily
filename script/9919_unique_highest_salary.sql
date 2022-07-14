/*

Title       : Unique Highest Salary
Link        : https://platform.stratascratch.com/coding/9919-unique-highest-salary?code_type=1
Difficulty  : Hard
Question    : Find the highest salary among salaries that appears only once.
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
SELECT MAX(salary) AS hightest_salary
FROM employee
