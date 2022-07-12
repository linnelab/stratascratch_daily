/*

Title       : Most Senior & Junior Employee
Link        : https://platform.stratascratch.com/coding/2044-most-senior-junior-employee?code_type=1
Difficulty  : Hard
Question    : Write a query to find the number of days between the longest and least tenured employee still working for the company. 
              Your output should include the number of employees with the longest-tenure, 
              the number of employees with the least-tenure, 
              and the number of days between both the longest-tenured and least-tenured hiring dates.
Tables      : uber_employees

<uber_employees>
first_name            varchar
last_name             varchar
id                    int
hire_date             datetime
termination_date      datetime
salary                int

*/


-- logic:
-- 1. calculate longest tenured employee count and these employee still stay this company, not termination.
-- 2. calculate shortest tenured employee count and these employee still stay this company, not termination.
-- 3. get max hire date and substract min hire date for employee, to get diff days. 


-- note:
-- if use other method to get day diff.
-- in PostgreSQL, if you subtract one "datetime" value (TIMESTAMP, DATE or TIME data type) from another, 
-- you will get an INTERVAL value in the form ”ddd days hh:mi:ss”,
-- so you can use DATE_PART function to extact the number of days, but it returns the number of full days between the dates.
-- ref link : https://www.sqlines.com/postgresql/how-to/datediff


-- solution 1:
WITH old_employee_cnt AS (
    SELECT COUNT(*) AS old_cnt
    FROM uber_employees
    WHERE termination_date IS NULL
        AND hire_date = (SELECT MIN(hire_date) FROM uber_employees)
), young_employee_cnt AS (
    SELECT COUNT(*) AS young_cnt
    FROM uber_employees
    WHERE termination_date IS NULL
        AND hire_date = (SELECT MAX(hire_date) FROM uber_employees)
)
SELECT y.young_cnt,
       o.old_cnt,
       MAX(u.hire_date) - MIN(u.hire_date) AS diff_days
FROM uber_employees AS u , old_employee_cnt AS o, young_employee_cnt AS y
GROUP BY o.old_cnt,
         y.young_cnt
