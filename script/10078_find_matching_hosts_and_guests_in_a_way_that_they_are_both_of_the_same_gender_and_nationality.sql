/*

Title       : Find matching hosts and guests in a way that they are both of the same gender and nationality
Link        : https://platform.stratascratch.com/coding/10078-find-matching-hosts-and-guests-in-a-way-that-they-are-both-of-the-same-gender-and-nationality?code_type=1
Difficulty  : Medium
Question    : Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.
              Output the host id and the guest id of matched pair.
Tables      : airbnb_hosts, airbnb_guests

<airbnb_hosts>
host_id           int
nationality       varchar
gender            varchar
age               int

<airbnb_guests>
host_id           int
nationality       varchar
gender            varchar
age               int

*/


-- note:
-- source table have duplicate rows, so need to distinct.


-- solution 1:
WITH host AS (
    SELECT DISTINCT host_id,
           CONCAT(nationality, '_', gender) AS national_gender
    FROM airbnb_hosts
), guest AS (
    SELECT DISTINCT guest_id,
           CONCAT(nationality, '_', gender) AS national_gender
    FROM airbnb_guests
)
SELECT h.host_id, 
       g.guest_id
FROM host AS h
INNER JOIN guest AS g
    ON h.national_gender = g.national_gender
ORDER BY h.host_id


-- solution 2:
SELECT DISTINCT h.host_id,
       g.guest_id
FROM airbnb_hosts AS h
INNER JOIN airbnb_guests AS g
    ON h.nationality = g.nationality
    AND h.gender = g.gender
