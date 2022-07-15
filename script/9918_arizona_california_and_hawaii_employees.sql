/*

Title       : Arizona, California, and Hawaii Employees
Link        : https://platform.stratascratch.com/coding/9918-arizona-california-and-hawaii-employees?code_type=1
Difficulty  : Hard
Question    : Find employees from Arizona, California, and Hawaii while making sure to output all employees from each city. 
              Output column headers should be Arizona, California, and Hawaii. 
              Data for all cities must be ordered on the first name.
              Assume unequal number of employees per city.
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


-- logic:
-- 1. find first name for employee on Arizona, California and Hawaii, then get ranking column for these first_name.
-- 2. use #1 ranking column to join table, and results need to show Arizona, California and Hawaii three columns and contain employee first_name.


-- solution 1:
WITH az AS (
    SELECT first_name,
           ROW_NUMBER() OVER (PARTITION BY city ORDER BY first_name) AS rk
    FROM employee
    WHERE city = 'Arizona'
), cf AS (
    SELECT first_name,
           ROW_NUMBER() OVER (PARTITION BY city ORDER BY first_name) AS rk
    FROM employee
    WHERE city = 'California'
), hw AS (
    SELECT first_name,
           ROW_NUMBER() OVER (PARTITION BY city ORDER BY first_name) AS rk
    FROM employee
    WHERE city = 'Hawaii'
)
SELECT a.first_name,
       c.first_name,
       h.first_name
FROM az AS a
FULL JOIN cf AS c
    ON a.rk = c.rk
FULL JOIN hw AS h
    ON a.rk = h.rk    
