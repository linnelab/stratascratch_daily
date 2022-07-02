/*

Title       : Find the base pay for Police Captains
Link        : https://platform.stratascratch.com/coding/9972-find-the-base-pay-for-police-captains?code_type=1
Difficulty  : Easy
Question    : Find the base pay for Police Captains.
              Output the employee name along with the corresponding base pay.
Tables      : sf_public_salaries

<sf_public_salaries>
id                        int
employeename              varchar
jobtitle                  varchar
basepay                   float
overtimepay               float
otherpay                  float
benefits                  float
totalpay                  float
totalpaybenefits          float
year                      int
notes                     datetime
agency                    varchar
status                    varchar

*/


-- note:
-- job title need to contain 'police' and 'captain' keywords.


-- solution 1:
SELECT employeename,
       basepay
FROM sf_public_salaries
WHERE jobtitle ILIKE ALL (ARRAY['%police%', '%captain%'])



------ I thought about these solutions, but it's not best.

-- query 1. 
-- reason: If source data contain other job title and belong police captain, these records will not be showed in result table.

SELECT employeename,
       basepay
FROM sf_public_salaries
WHERE jobtitle = 'CAPTAIN III (POLICE DEPARTMENT)'


-- query 2. 
-- reason: for where condition "|" (i.e. or), it will get jobtitle is police but not captain, or get jobtitle is captain but not police.

SELECT employeename,
       basepay
FROM sf_public_salaries
WHERE jobtitle ~* '\y(police|captain)\y'


-- query 3:
-- reason: the solution can get correct results, but query can be simplified, use ILIKE ALL (ARRAY[....])
SELECT employeename,
       basepay
FROM sf_public_salaries
WHERE jobtitle ILIKE '%police%' AND jobtitle ILIKE '%captain%'
