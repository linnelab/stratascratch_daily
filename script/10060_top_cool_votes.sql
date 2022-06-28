/*

Title       : Top Cool Votes
Link        : https://platform.stratascratch.com/coding/10060-top-cool-votes?code_type=1
Difficulty  : Medium
Question    : Find the review_text that received the highest number of 'cool' votes.
              Output the business name along with the review text with the highest numbef of 'cool' votes.
Tables      : yelp_reviews

<yelp_reviews>
business_name       varchar
review_id           varchar
user_id             varchar
stars               varchar
review_date         datetime
review_text         varchar
funny               int
useful              int
cool                int

*/


-- solution 1: 
SELECT business_name, 
       review_text, 
       cool
FROM yelp_reviews
WHERE cool = (SELECT MAX(cool) FROM yelp_reviews)
