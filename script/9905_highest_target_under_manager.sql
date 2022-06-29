/*

Title       : Highest Target Under Manager
Link        : https://platform.stratascratch.com/coding/9905-highest-target-under-manager?code_type=1
Difficulty  : Medium
Question    : Find the highest target achieved by the employee or employees who works under the manager id 13. 
              Output the first name of the employee and target achieved. 
              The solution should show the highest target achieved under manager_id=13 and which employee(s) achieved it.
Tables      : salesforce_employees

<salesforce_employees>
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


-- logic: 
-- 1. find employees are manager_id = 13 (i.e. employees who works under the manager id 13)
-- 2. from 1 results find highest target employees.


-- solution 1: use DENSE_RANK()
SELECT first_name,
       target
FROM (
    SELECT first_name,
           target,
           DENSE_RANK() OVER (ORDER BY target DESC) AS rk
    FROM salesforce_employees
    WHERE manager_id = 13
) AS t
WHERE t.rk = 1


-- solution 2: use MAX()
SELECT first_name,
       target
FROM salesforce_employees
WHERE manager_id = 13 
    AND target = (SELECT MAX(target) FROM salesforce_employees WHERE manager_id = 13)
