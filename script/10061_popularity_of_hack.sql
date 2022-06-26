/*

Title       : Popularity of Hack
Link        : https://platform.stratascratch.com/coding/10061-popularity-of-hack?code_type=1
Difficulty  : Easy
Question    : Meta/Facebook has developed a new programing language called Hack.
              To measure the popularity of Hack they ran a survey with their employees. 
              The survey included data on previous programing familiarity as well as the number of years of experience, age, 
              gender and most importantly satisfaction with Hack. 
              Due to an error location data was not collected, but your supervisor demands a report showing average popularity of Hack by office location. 
              Luckily the user IDs of employees completing the surveys were stored.
              Based on the above, find the average popularity of the Hack per office location.
              Output the location along with the average popularity.
Tables      : facebook_employees, facebook_hack_survey

<facebook_employees>
id              int
location        varchar
age             int
gender          varchar
is_senior       bool

<facebook_hack_survey>
employee_id     int
age             int
gender          varchar
popularity      int

*/


-- solution 1: 
SELECT fe.location,
       AVG(fhs.popularity) AS avg_popularity
FROM facebook_employees AS fe
INNER JOIN facebook_hack_survey AS fhs 
    ON fe.id = fhs.employee_id
GROUP BY fe.location
