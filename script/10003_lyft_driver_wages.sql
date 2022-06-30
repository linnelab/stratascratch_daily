/*

Title       : Lyft Driver Wages
Link        : https://platform.stratascratch.com/coding/10003-lyft-driver-wages?code_type=1
Difficulty  : Easy
Question    : Find all Lyft drivers who earn either equal to or less than 30k USD or equal to or more than 70k USD.
              Output all details related to retrieved records.
Tables      : lyft_drivers

<lyft_drivers>
index                 int
start_date            datetime
end_date              datetime
yearly_salary         int

*/


-- solution 1:
SELECT *
FROM lyft_drivers
WHERE yearly_salary <= 30000
    OR yearly_salary >= 70000
