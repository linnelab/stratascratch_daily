/*

Title       : Ranking Most Active Guests
Link        : https://platform.stratascratch.com/coding/10159-ranking-most-active-guests?code_type=1
Difficulty  : Medium
Question    : Rank guests based on the number of messages they've exchanged with the hosts. 
              Guests with the same number of messages as other guests should have the same rank. 
              Do not skip rankings if the preceding rankings are identical.
              Output the rank, guest id, and number of total messages they've sent. 
              Order by the highest number of total messages first.
Tables      : airbnb_contacts

<airbnb_contacts>
id_guest            varchar
id_host             varchar
id_listing          varchar
ts_contact_at       datetime
ts_reply_at         datetime
ts_accepted_at      datetime
ts_booking_at       datetime
ds_checkin          datetime
ds_checkout         datetime
n_guests            int
n_messages          int

*/


-- solution 1: use CTE
WITH guest_message_cnt AS (
    SELECT id_guest,
           SUM(n_messages) AS message_cnt
    FROM airbnb_contacts
    GROUP BY id_guest
)
SELECT DENSE_RANK() OVER (ORDER BY message_cnt DESC) AS rk, *
FROM guest_message_cnt


-- solution 2:
SELECT DENSE_RANK() OVER (ORDER BY SUM(n_messages) DESC) AS rk,
       id_guest,
       SUM(n_messages) AS message_cnt
FROM airbnb_contacts
GROUP BY id_guest
ORDER BY rk
