/*

Title       : Highest Paid City Employees
Link        : https://platform.stratascratch.com/coding/9989-highest-paid-city-employees?code_type=1
Difficulty  : Hard
Question    : Find the top 2 highest paid City employees for each job title. 
              Output the job title along with the corresponding highest and second-highest paid employees.
Tables      : sf_public_salaries

<sf_public_salaries>
id                    int
employeename          varchar
jobtitle              varchar
basepay               float
overtimepay           float
otherpay              float
benefits              float
totalpay              float
totalpaybenefits      float
year                  int
notes                 datetime
agency                varchar
status                varchar

*/


-- logic:
-- 1. rank every employee salary by jobtitle. 
--    if employee salary same will according to employeename ascending sort to get rank 1 and 2, so need use ROW_NUMBER() method, 
--    not use DENSE_RANK() method to get rank, use this method will only get rank = 1 on same salary records.
-- 2. find highest salary (i.e. rank = 1) and second salary (i.e. rank = 2) employee name for each job title.


-- note:
-- use ROW_NUMBER() to ranking employee salary.


-- solution 1:
WITH rank_salary AS (
    SELECT jobtitle,
           employeename,
           totalpaybenefits,
           ROW_NUMBER() OVER (PARTITION BY jobtitle ORDER BY totalpaybenefits DESC) AS rk
    FROM sf_public_salaries
)
SELECT jobtitle,
       MAX(employeename) FILTER (WHERE rk = 1) AS highest_salary_emp,
       MAX(employeename) FILTER (WHERE rk = 2) AS second_salary_emp
FROM rank_salary
GROUP BY jobtitle
