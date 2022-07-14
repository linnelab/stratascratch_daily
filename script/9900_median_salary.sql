/*

Title       : Median Salary
Link        : https://platform.stratascratch.com/coding/9900-median-salary?code_type=1
Difficulty  : Hard
Question    : Find the median employee salary of each department.
              Output the department name along with the corresponding salary rounded to the nearest whole dollar.
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
SELECT department,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS median_salary
FROM employee
GROUP BY department
