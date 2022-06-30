/*

Title       : Churro Activity Date
Link        : https://platform.stratascratch.com/coding/9688-churro-activity-date?code_type=1
Difficulty  : Easy
Question    : Find the activity date and the pe_description of facilities with the name 'STREET CHURROS' and with a score of less than 95 points.
Tables      : los_angeles_restaurant_health_inspections

<los_angeles_restaurant_health_inspections>
serial_number               varchar
activity_date               datetime
facility_name               varchar
score                       int
grade                       varchar
service_code                int
service_description         varchar
employee_id                 varchar
facility_address            varchar
facility_city               varchar
facility_id                 varchar
facility_state              varchar
facility_zip                varchar
owner_id                    varchar
owner_name                  varchar
pe_description              varchar
program_element_pe          int
program_name                varchar
program_status              varchar
record_id                   varchar

*/


-- solution 1:
SELECT activity_date,
       pe_description
FROM los_angeles_restaurant_health_inspections
WHERE facility_name = 'STREET CHURROS'
      AND score < 95
