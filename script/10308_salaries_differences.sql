/*

Title       : Salaries Differences
Link        : https://platform.stratascratch.com/coding/10308-salaries-differences?code_type=1
Difficulty  : Easy
Question    : Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. 
              Output just the absolute difference in salaries.
Tables      :  db_employee, db_dept

<db_employee>
id                  int
first_name          varchar
last_name           varchar
salary              int
department_id       int
email               datetime

<db_dept>
id                  int
department          varchar

*/


-- logic:
-- 1. find highest marketing salary
-- 2. find highest engineering salary
-- 3. 1-2 = salary diff


-- solution 1: use cte get highest marketing and engineering salary
WITH max_marketing AS (
    SELECT MAX(salary) AS marketing_salary
    FROM db_dept AS dept
    INNER JOIN db_employee AS emp
        ON dept.id = emp.department_id
    WHERE dept.department = 'marketing'
), max_engineering AS (
    SELECT MAX(salary) AS engineer_salary
    FROM db_dept AS dept
    INNER JOIN db_employee AS emp
        ON dept.id = emp.department_id
    WHERE dept.department = 'engineering'
)
SELECT ABS(m.marketing_salary - e.engineer_salary) AS salary_diff
FROM max_marketing AS m, max_engineering AS e


-- solution 2: select 
SELECT ABS((
    SELECT MAX(salary)
    FROM db_employee AS emp
    INNER JOIN db_dept AS dept
        ON emp.department_id = dept.id
    WHERE dept.department = 'marketing'
) - (
    SELECT MAX(salary)
    FROM db_employee AS emp
    INNER JOIN db_dept AS dept
        ON emp.department_id = dept.id
    WHERE dept.department = 'engineering'
)) AS salary_diff


-- solution 3: use filter 
SELECT 
    ABS(
        MAX(emp.salary) FILTER (WHERE dept.department = 'marketing') - 
        MAX(emp.salary) FILTER (WHERE dept.department = 'engineering')
    )
FROM db_employee AS emp
INNER JOIN db_dept AS dept
    ON emp.department_id = dept.id
    
    
-- solution 4: use case when
SELECT ABS(
        MAX(CASE WHEN dept.department = 'marketing' THEN emp.salary END) -
        MAX(CASE WHEN dept.department = 'engineering' THEN emp.salary END)
    ) AS salary_diff
FROM db_employee AS emp
INNER JOIN db_dept AS dept
    ON emp.department_id = dept.id
