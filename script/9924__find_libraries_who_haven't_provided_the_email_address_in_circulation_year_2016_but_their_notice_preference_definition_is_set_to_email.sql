/*

Title       : Find libraries who haven't provided the email address in circulation year 2016 but their notice preference definition is set to email
Link        : https://platform.stratascratch.com/coding/9924-find-libraries-who-havent-provided-the-email-address-in-2016-but-their-notice-preference-definition-is-set-to-email?code_type=1
Difficulty  : Easy
Question    : Find libraries who haven't provided the email address in circulation year 2016 but their notice preference definition is set to email.
              Output the library code.
Tables      : library_usage

<library_usage>
patron_type_code                    int
patron_type_definition              varchar
total_checkouts                     int
total_renewals                      int
age_range                           varchar
home_library_code                   varchar
home_library_definition             varchar
circulation_active_month            varchar
circulation_active_year             float
notice_preference_code              varchar
notice_preference_definition        varchar
provided_email_address              bool
year_patron_registered              int
outside_of_county                   bool
supervisor_district                 float

*/


-- note:
-- Result will produce same records on home library code, so need to disitnct duplicate rows.
-- Because provided_email_address column data type is boolean, so where condition use "IS FALSE" to determine which records have matching.


-- solution 1:
SELECT DISTINCT home_library_code
FROM library_usage
WHERE provided_email_address IS FALSE 
    AND notice_preference_definition = 'email'
    AND circulation_active_year = 2016
