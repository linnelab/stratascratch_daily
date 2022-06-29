/*

Title       : Employee and Manager Salaries
Link        : https://platform.stratascratch.com/coding/9894-employee-and-manager-salaries?code_type=1
Difficulty  : Medium
Question    : Find employees who are earning more than their managers. 
              Output the employee's first name along with the corresponding salary.
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
SELECT emp.first_name, 
       emp.salary
FROM employee AS emp
LEFT JOIN employee AS mag
    ON emp.manager_id = mag.id
WHERE emp.salary > mag.salary
