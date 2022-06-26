/*

Title       : Workers With The Highest Salaries
Link        : https://platform.stratascratch.com/coding/10353-workers-with-the-highest-salaries?code_type=1
Difficulty  : Medium
Question    : Find the titles of workers that earn the highest salary. Output the highest-paid title or multiple titles that share the highest salary.
Tables      : worker, title

<worker>
worker_id            int
first_name           varchar
last_name            varchar
salary               int
joining_date         datetime
department           varchar

<title>
worker_ref_id        int
worker_title         varchar
affected_from        datetime

*/


-- solution 1: 
SELECT t.worker_title,
       w.salary AS highest_salary
FROM worker AS w
INNER JOIN title AS t
    ON w.worker_id = t.worker_ref_id
WHERE w.salary = (SELECT MAX(salary) FROM worker)
