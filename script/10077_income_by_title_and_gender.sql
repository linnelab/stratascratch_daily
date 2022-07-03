/*

Title       : Income By Title and Gender
Link        : https://platform.stratascratch.com/coding/10077-income-by-title-and-gender?code_type=1
Difficulty  : Medium
Question    : Find the average total compensation based on employee titles and gender. 
              Total compensation is calculated by adding both the salary and bonus of each employee. 
              However, not every employee receives a bonus so disregard employees without bonuses in your calculation. 
              Employee can receive more than one bonus.
              Output the employee title, gender (i.e., sex), along with the average total compensation.
Tables      : sf_employee, sf_bonus

<sf_employee>
id                      int
first_name              varchar
last_name               varchar
age                     int
sex                     varchar
employee_title          varchar
department              varchar
salary                  int
target                  int
email                   varchar
city                    varchar
address                 varchar
manager_id              int


<sf_bonus>
worker_ref_id           int
bonus                   int
bonus_date              datetime

*/


-- note:
-- second table "sf_bonus" have mutiple records on same worker_ref_id, so use SUM() to calculate total bonus for each worker_ref_id,
-- then use this total bonus to add employee salary and get avg compensation.


-- solution 1:
WITH total_bonus AS (
    SELECT worker_ref_id,
           SUM(bonus) AS total_bonus
    FROM sf_bonus
    GROUP BY worker_ref_id
)
SELECT e.employee_title, 
       e.sex,
       AVG(e.salary + b.total_bonus) AS avg_compensation
FROM sf_employee AS e
INNER JOIN total_bonus AS b
    ON e.id = b.worker_ref_id
GROUP BY e.employee_title, 
         e.sex
