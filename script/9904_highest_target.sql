/*

Title       : Highest Target
Link        : https://platform.stratascratch.com/coding/9904-highest-target?code_type=1
Difficulty  : Medium
Question    : Find the employee who has achieved the highest target.
              Output the employee's first name along with the achieved target and the bonus.
Tables      : employee

<lyft_drivers>
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
SELECT first_name,
       target,
       bonus
FROM employee
WHERE target = (SELECT MAX(target) FROM employee)
