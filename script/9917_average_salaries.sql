/*

Title       : Average Salaries
Link        : https://platform.stratascratch.com/coding/9917-average-salaries?code_type=1
Difficulty  : Easy
Question    : Compare each employee's salary with the average salary of the corresponding department.
              Output the department, first name, and salary of employees along with the average salary of that department.
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


-- logic:
-- solution 1 : use cte to get avg department salary and join source table to get another columns.
-- solution 2 : use partition department to calculate each of department average salary.


-- solution 1: 
WITH avg_department_salary AS (
    SELECT department, 
           AVG(salary) AS avg_salary
    FROM employee
    GROUP BY department
)
SELECT e.department, 
       e.first_name, 
       e.salary, 
       a.avg_salary
FROM employee AS e
LEFT JOIN avg_department_salary AS a
    ON e.department = a.department
    
    
-- solution 2: 
SELECT department,
       first_name,
       salary,
       AVG(salary) OVER (PARTITION BY department) AS avg_salary
FROM employee
