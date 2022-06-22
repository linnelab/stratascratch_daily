/*

Question    : Workers With The Highest Salaries
Link        : https://platform.stratascratch.com/coding/10353-workers-with-the-highest-salaries?code_type=1
Difficulty  : Medium
Description : Find the titles of workers that earn the highest salary. Output the highest-paid title or multiple titles that share the highest salary.
Tables      : worker, title

<worker>
worker_id               int
first_name              varchar
last_name               varchar
salary                  int
joining_date            datetime
department              varchar

<title>
worker_ref_id           int
worker_title            varchar
affected_from           datetime

*/

-- solution 1: use max()
SELECT t.worker_title
FROM worker AS w
INNER JOIN title AS t
    ON w.worker_id = t.worker_ref_id
WHERE w.salary = (
    SELECT MAX(salary)
    FROM worker
)

-- solution 2: use dense_rank()
SELECT worker_title
FROM (
    SELECT t.worker_title,
           dense_rank() over (ORDER BY w.salary DESC) AS rk
    FROM worker AS w
    INNER JOIN title AS t
        ON w.worker_id = t.worker_ref_id
) AS title_rank
WHERE rk = 1

-- soultion 3: use case when
