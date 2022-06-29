/*

Title       : Number Of Units Per Nationality
Link        : https://platform.stratascratch.com/coding/10156-number-of-units-per-nationality?code_type=1
Difficulty  : Medium
Question    : Find the number of apartments per nationality that are owned by people under 30 years old.
              Output the nationality along with the number of apartments.
              Sort records by the apartments count in descending order.
Tables      : airbnb_hosts, airbnb_units

<airbnb_hosts>
host_id             int
nationality         varchar
gender              varchar
age                 int

<airbnb_units>
host_id             int
unit_id             varchar
unit_type           varchar
n_beds              int
n_bedrooms          int
country             varchar
city                varchar

*/


-- note:
-- 1. airbnb_hosts tables contain duplicate records, so need to exclude duplicate rows. (use DISTINCT())
-- 2. Choice unit_id columns to exclude duplicate rows because this column is unique values. 
--    If you choice another column to distinct, will get incorrect row counts.


-- solution 1:
WITH apartment AS (
    SELECT DISTINCT *
    FROM airbnb_hosts AS h
    INNER JOIN airbnb_units AS u
        ON h.host_id = u.host_id
    WHERE h.age < 30
        AND u.unit_type = 'Apartment'
)
SELECT nationality,
       COUNT(*) AS apartment_cnt
FROM apartment
GROUP BY nationality
ORDER BY apartment_cnt DESC


-- solution 2:
SELECT h.nationality,
       COUNT(DISTINCT u.unit_id) AS apartment_cnt
FROM airbnb_hosts AS h
INNER JOIN airbnb_units AS u
    ON h.host_id = u.host_id
WHERE h.age < 30
    AND u.unit_type = 'Apartment'
GROUP BY h.nationality
ORDER BY apartment_cnt DESC
