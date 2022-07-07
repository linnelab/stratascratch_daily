/*

Title       : Activity Rank
Link        : https://platform.stratascratch.com/coding/10351-activity-rank?code_type=1
Difficulty  : Hard
Question    : Find the email activity rank for each user. 
              Email activity rank is defined by the total number of emails sent. 
              The user with the highest number of emails sent will have a rank of 1, and so on. 
              Output the user, total emails, and their activity rank. 
              Order records by the total emails in descending order. Sort users with the same number of emails in alphabetical order.
              In your rankings, return a unique value (i.e., a unique rank) even if multiple users have the same number of emails.
Tables      : google_gmail_emails

<google_gmail_emails>
id                  int
from_user           varchar
to_user             varchar
day                 int

*/


-- note:
-- use ROW_NUMBER(): because question need to return a unique rank even if multiple users have the same number of emails.


-- solution 1:
SELECT from_user,
       COUNT(from_user) AS total_send_cnt,
       ROW_NUMBER() OVER (ORDER BY COUNT(from_user) DESC, from_user ASC) AS activity_rk
FROM google_gmail_emails
GROUP BY from_user
