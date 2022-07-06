/*

Title       : Super Managers
Link        : https://platform.stratascratch.com/coding/9901-super-managers?code_type=1
Difficulty  : Medium
Question    : Find managers with at least 7 direct reporting employees.
              Output first names of managers.
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


-- logic:
-- 1. find manager list
-- 2. calculate this manager have employees count.
-- 3. get first name of manager with at least 7 employees.


-- note:
-- use having method to determine the number of employees bigger than six.


-- solution 1:
WITH manager_list AS (
    SELECT id,
           first_name
    FROM employee
    WHERE employee_title = 'Manager'
), manager_have_emp_cnt AS (
    SELECT e.manager_id, 
           m.first_name,
           COUNT(e.id) AS employee_cnt
    FROM employee AS e
    INNER JOIN manager_list AS m
        ON e.manager_id = m.id
    GROUP BY e.manager_id, 
             m.first_name
)
SELECT first_name
FROM manager_have_emp_cnt
WHERE employee_cnt > 6


-- solution 2:
WITH match_manager AS (
    SELECT manager_id
    FROM employee
    GROUP BY manager_id
    HAVING COUNT(manager_id) > 6
)
SELECT e.first_name
FROM match_manager AS m
INNER JOIN employee AS e
    ON m.manager_id = e.id
