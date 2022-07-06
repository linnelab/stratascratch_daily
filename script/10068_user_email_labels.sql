/*

Title       : User Email Labels
Link        : https://platform.stratascratch.com/coding/10068-user-email-labels?code_type=1
Difficulty  : Medium
Question    : Find the number of emails received by each user under each built-in email label. 
              The email labels are: 'Promotion', 'Social', and 'Shopping'. 
              Output the user along with the number of promotion, social, and shopping mails count,.
Tables      : google_gmail_emails, google_gmail_labels

<google_gmail_emails>
id                int
from_user         varchar
to_user           varchar
day               int

<google_gmail_labels>
email_id          int
label             varchar

*/


-- note:
-- solution 3: 
-- when use "=", it will return boolean data type (i.e. TRUE or FALSE),
-- then use ::int can change boolean TRUE or FALSE as 1 or 0,
-- so can use SUM() function to get count.


-- solution 1:
SELECT to_user,
       COUNT(to_user) FILTER (WHERE label = 'Promotion') AS promotion_cnt,
       COUNT(to_user) FILTER (WHERE label = 'Social') AS social_cnt,
       COUNT(to_user) FILTER (WHERE label = 'Shopping') AS shopping_cnt
FROM google_gmail_emails AS e
INNER JOIN google_gmail_labels AS l
    ON e.id = l.email_id
GROUP BY to_user


-- solution 2:
SELECT e.to_user,
       SUM(CASE WHEN l.label = 'Promotion' THEN 1 ELSE 0 END) AS promotion_cnt,
       SUM(CASE WHEN l.label = 'Social' THEN 1 ELSE 0 END) AS social_cnt,
       SUM(CASE WHEN l.label = 'Shopping' THEN 1 ELSE 0 END) AS shopping_cnt
FROM google_gmail_emails AS e
INNER JOIN google_gmail_labels AS l
    ON e.id = l.email_id
GROUP BY e.to_user


-- solution 3:
SELECT e.to_user,
       SUM((l.label = 'Promotion')::int) AS promotion_cnt,
       SUM((l.label = 'Social')::int) AS social_cnt,
       SUM((l.label = 'Shopping')::int) AS shopping_cnt
FROM google_gmail_emails AS e
INNER JOIN google_gmail_labels AS l
    ON e.id = l.email_id
GROUP BY e.to_user
