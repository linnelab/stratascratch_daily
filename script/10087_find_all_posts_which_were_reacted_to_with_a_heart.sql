/*

Title       : Find all posts which were reacted to with a heart
Link        : https://platform.stratascratch.com/coding/10087-find-all-posts-which-were-reacted-to-with-a-heart?code_type=1
Difficulty  : Easy
Question    : Find all posts which were reacted to with a heart. For such posts output all columns from facebook_posts table.
Tables      : facebook_reactions, facebook_posts

<facebook_reactions>
poster              int
friend              int
reaction            varchar
date_day            int
post_id             int

<facebook_posts>
post_id             int
poster              int
post_text           varchar
post_keywords       varchar
post_date           datetime

*/


-- note:
-- exclude duplicate rows.


-- solution 1:
SELECT DISTINCT p.*
FROM facebook_reactions AS r
INNER JOIN facebook_posts AS p
    ON r.post_id = p.post_id
WHERE r.reaction = 'heart'
