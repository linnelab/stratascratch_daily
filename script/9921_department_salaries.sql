/*

Title       : Department Salaries
Link        : https://platform.stratascratch.com/coding/9921-department-salaries?code_type=1
Difficulty  : Medium
Question    : Find the number of male and female employees per department and also their corresponding total salaries.
              Output department names along with the corresponding number of female employees, 
              the total salary of female employees, the number of male employees, and the total salary of male employees.
Tables      : employee

<employee>
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


-- solution 1: use cte()
WITH female_emp_total_salary AS (
    SELECT department, 
           COUNT(sex) AS female_cnt,
           SUM(salary) AS female_salary
    FROM employee
    WHERE sex = 'F'
    GROUP BY department
), male_emp_total_salary AS (
    SELECT department, 
           COUNT(sex) AS male_cnt,
           SUM(salary) AS male_salary
    FROM employee
    WHERE sex = 'M'
    GROUP BY department
)
SELECT *
FROM female_emp_total_salary AS f
INNER JOIN male_emp_total_salary AS m
    ON f.department = m.department


-- solution 2: use filter()
SELECT department,
       COUNT(sex) FILTER (WHERE sex = 'F') AS female_cnt,
       SUM(salary) FILTER (WHERE sex = 'F') AS female_salary,
       COUNT(sex) FILTER (WHERE sex = 'M') AS male_cnt,
       SUM(salary) FILTER (WHERE sex = 'M') AS female_salary
FROM employee 
GROUP BY department


-- solution 3: use case when
SELECT department,
       SUM(CASE WHEN sex = 'F' THEN 1 ELSE 0 END) AS femlae_cnt,
       SUM(CASE WHEN sex = 'F' THEN salary ELSE 0 END) AS female_cnt,
       SUM(CASE WHEN sex = 'M' THEN 1 ELSE 0 END) AS male_cnt,
       SUM(CASE WHEN sex = 'M' THEN salary ELSE 0 END) AS female_cnt
FROM employee
GROUP BY department
