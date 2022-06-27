/*

Title       : Premium vs Freemium
Link        : https://platform.stratascratch.com/coding/10300-premium-vs-freemium?code_type=1
Difficulty  : Hard
Question    : Find the total number of downloads for paying and non-paying users by date. 
              Include only records where non-paying customers have more downloads than paying customers. 
              The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads.
Tables      : ms_user_dimension, ms_acc_dimension, ms_download_facts

<ms_user_dimension>
user_id              int
acc_id               int

<ms_acc_dimension>
acc_id               int
paying_customer      varchar

<ms_download_facts>
date                 datetime
user_id              int
downloads            int

*/


-- logic : 
-- 1. join table and find paying and non_paying customer total download counts by date.
-- 2. get records for non_paying customer download counts > paying customer download counts.
-- 3. order by date
-- 4. output column : date | non_paying download counts | paying download counts


-- note :
-- solution 2 and 3 diff is using FILTER() and CASE WHEN.
-- FILTER() and CASE WHEN ref : https://kb.objectrocket.com/postgresql/how-to-use-the-filter-clause-in-postgresql-881


-- solution 1: 
WITH customer_download_cnt AS (
    SELECT date, 
           paying_customer, 
           SUM(downloads) AS download_cnt
    FROM ms_download_facts AS d
    INNER JOIN ms_user_dimension AS u
        ON d.user_id = u.user_id
    INNER JOIN ms_acc_dimension AS a
        ON u.acc_id = a.acc_id
    GROUP BY date, paying_customer
), non_paying AS (
    SELECT date, 
           download_cnt AS non_paying_download_cnt
    FROM customer_download_cnt AS c1
    WHERE paying_customer = 'no'
), paying AS (
    SELECT date, 
           download_cnt AS paying_download_cnt
    FROM customer_download_cnt AS c1
    WHERE paying_customer = 'yes'
)
SELECT n.date, 
       n.non_paying_download_cnt, 
       p.paying_download_cnt
FROM non_paying AS n
INNER JOIN paying AS p
    ON n.date = p.date
    AND n.non_paying_download_cnt > p.paying_download_cnt
ORDER BY date


-- solution 2: use FILTER()
WITH download_count AS (
    SELECT date,
           SUM(downloads) FILTER (WHERE paying_customer = 'no') AS non_paying,
           SUM(downloads) FILTER (WHERE paying_customer = 'yes') AS paying
    FROM ms_download_facts AS d
    INNER JOIN ms_user_dimension AS u
        ON d.user_id = u.user_id
    INNER JOIN ms_acc_dimension AS a
        ON u.acc_id = a.acc_id
    GROUP BY date
    ORDER BY date
)
SELECT *
FROM download_count
WHERE (non_paying - paying) > 0               -- can use WHERE non_paying > paying


-- solution 3: use CASE WHEN
WITH download_count AS (
    SELECT date,
           SUM(CASE WHEN paying_customer = 'no' THEN downloads END) AS non_paying,
           SUM(CASE WHEN paying_customer = 'yes' THEN downloads END) AS paying
    FROM ms_download_facts AS d
    INNER JOIN ms_user_dimension AS u
        ON d.user_id = u.user_id
    INNER JOIN ms_acc_dimension AS a
        ON u.acc_id = a.acc_id
    GROUP BY date
    ORDER BY date
)
SELECT *
FROM download_count
WHERE non_paying > paying
