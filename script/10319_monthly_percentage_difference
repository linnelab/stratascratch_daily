/*

Title       : Monthly Percentage Difference
Link        : https://platform.stratascratch.com/coding/10319-monthly-percentage-difference?code_type=1
Difficulty  : Hard
Question    : Given a table of purchases by date, calculate the month-over-month percentage change in revenue. 
              The output should include the year-month date (YYYY-MM) and percentage change, 
              rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
              The percentage change column will be populated from the 2nd month forward and can be calculated as 
              ((this month's revenue - last month's revenue) / last month's revenue)*100.
Tables      : sf_transactions

<sf_transactions>
id                int
created_at        datetime
value             int
purchase_id       int

*/


-- logic:
-- 1. calculate every month sum revenue.
-- 2. get last month sum revenue.
-- 3. use formula to get monthly percentage diff.


-- note:
-- solution 1: 
-- LAG() OVER() : https://vimsky.com/zh-tw/examples/usage/postgresql-lag-function.html
-- solution 2: 
-- Window Functions : https://www.postgresql.org/docs/current/tutorial-window.html
-- solution 3: 
-- if there is a missing month, then LAG() method will be off. Suggest to calculate the next month date first and use join to avoid this issue.
-- INTERVAL : https://www.postgresql.org/docs/current/functions-datetime.html
-- TO_DATE : https://www.postgresqltutorial.com/postgresql-date-functions/postgresql-to_date/


-- solution 1: 
WITH each_month_revenue AS (
    SELECT TO_CHAR(created_at, 'YYYY-MM') AS purchase_month,
           SUM(value) AS total_revenue
    FROM sf_transactions
    GROUP BY purchase_month
), this_and_last_month_revenue AS(
    SELECT purchase_month, 
           total_revenue AS this_month_revenue,
           LAG(total_revenue, 1) OVER (ORDER BY purchase_month) AS last_month_revenue
    FROM each_month_revenue
)
SELECT purchase_month,
       ROUND(((this_month_revenue - last_month_revenue) / last_month_revenue) * 100, 2) AS percentage_diff
FROM this_and_last_month_revenue
ORDER BY purchase_month


-- solution 2:
SELECT TO_CHAR(created_at, 'YYYY-MM') AS purchase_month,
       ROUND((SUM(value) - LAG(SUM(value), 1) OVER w) / LAG(SUM(value)) OVER w * 100, 2) AS percentage_diff
FROM sf_transactions
GROUP BY purchase_month
WINDOW w AS (ORDER BY TO_CHAR(created_at, 'YYYY-MM'))


-- solution 3:
WITH month_revenue AS (
    SELECT TO_CHAR(created_at, 'YYYY-MM') AS purchase_month,
           TO_DATE(TO_CHAR(created_at, 'YYYY-MM')||'-01', 'YYYY-MM-DD') AS month_beginning,
           SUM(value) AS revenue
    FROM sf_transactions
    GROUP BY purchase_month, month_beginning
)
SELECT m1.purchase_month,
       ROUND((m1.revenue - m2.revenue) / m2.revenue * 100, 2) AS percentage_diff
FROM month_revenue AS m1
LEFT JOIN month_revenue AS m2
    ON m1.month_beginning = (m2.month_beginning + interval '1 month')
