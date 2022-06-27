/*

Title       : Highest Salary In Department
Link        : https://platform.stratascratch.com/coding/9897-highest-salary-in-department?code_type=1
Difficulty  : Medium
Question    : Find the employee with the highest salary per department.
              Output the department name, employee's first name along with the corresponding salary.
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


-- solution 1: use JOIN
WITH highest_salary_by_dept AS (
    SELECT department, MAX(salary) AS max_salary
    FROM employee
    GROUP BY department
)
SELECT h.department,
       e.first_name,
       h.max_salary
FROM employee AS e
INNER JOIN highest_salary_by_dept AS h
    ON e.department = h.department
    AND e.salary = h.max_salary
    
 
 -- solution 2: use IN
 SELECT department, 
       first_name, 
       salary
FROM employee
WHERE (department, salary) IN (
    SELECT department, MAX(salary) AS max_salary
    FROM employee
    GROUP BY department
)
