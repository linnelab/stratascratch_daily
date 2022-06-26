/*

Title       : Finding Updated Records
Link        : https://platform.stratascratch.com/coding/10299-finding-updated-records?code_type=1
Difficulty  : Easy
Question    : We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information. 
              Find the current salary of each employee assuming that salaries increase each year. 
              Output their id, first name, last name, department ID, and current salary. 
              Order your list by employee ID in ascending order.
Tables      : ms_employee_salary

<ms_employee_salary>
id                  int
first_name          varchar
last_name           varchar
salary              int
department_id       int

*/


-- note :
-- solution 2 : method like solution 2 of #9917
-- #9917 ref link : https://github.com/linnelab/stratascratch_daily/blob/main/script/9917_average_salaries.sql


-- solution 1: 
WITH current_salary AS (
    SELECT id, MAX(salary) AS current_salary
    FROM ms_employee_salary
    GROUP BY id
) 
SELECT DISTINCT cs.id, 
       mes.first_name,
       mes.last_name, 
       mes.department_id, 
       cs.current_salary
FROM current_salary AS cs
INNER JOIN ms_employee_salary AS mes
    ON cs.id = mes.id
    
-- solution 2: 
SELECT id, 
       first_name, 
       last_name, 
       department_id, 
       MAX(salary) AS current_salary
FROM ms_employee_salary
GROUP BY id, first_name, last_name, department_id
ORDER BY id
