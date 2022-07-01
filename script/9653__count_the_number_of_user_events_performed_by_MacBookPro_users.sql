/*

Title       : Count the number of user events performed by MacBookPro users
Link        : https://platform.stratascratch.com/coding/9653-count-the-number-of-user-events-performed-by-macbookpro-users?code_type=1
Difficulty  : Easy
Question    : Count the number of user events performed by MacBookPro users.
              Output the result along with the event name.
              Sort the result based on the event count in the descending order.
Tables      : playbook_events

<playbook_events>
user_id           int
occurred_at       datetime
event_type        varchar
event_name        varchar
location          varchar
device            varchar

*/


-- solution 1:
SELECT event_name,
       COUNT(*) AS event_cnt
FROM playbook_events
WHERE device = 'macbook pro'
GROUP BY event_name
ORDER BY event_cnt DESC
