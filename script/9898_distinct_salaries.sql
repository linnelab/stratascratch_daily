/*

Title       : Distinct Salaries
Link        : https://platform.stratascratch.com/coding/9898-unique-salaries?code_type=1
Difficulty  : Hard
Question    : Find the top three distinct salaries for each department. 
              Output the department name and the top 3 distinct salaries by each department. 
              Order your results alphabetically by department and then by highest salary to lowest.
Tables      : twitter_employee

<twitter_employee>
id                  int
first_name          varchar
last_name           varchar
age                 int
sex                 varchar
employee_title      varchar
department          varchar
salary              int
target              int
bonus               int
email               varchar
city                varchar
address             varchar
manager_id          int

*/


-- logic:
-- partiton by department and descending sort salary, and find rank top 3 salary.


-- solution 1:
WITH salary_rank_by_dept AS (
    SELECT DISTINCT department,
           salary,
           DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rk
    FROM twitter_employee
    ORDER BY department, rk
)
SELECT department,
       salary
FROM salary_rank_by_dept
WHERE rk < 4
