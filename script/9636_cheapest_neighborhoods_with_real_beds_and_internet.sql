/*

Title       : Cheapest Neighborhoods With Real Beds And Internet
Link        : https://platform.stratascratch.com/coding/9636-cheapest-neighborhoods-with-real-beds-and-internet?code_type=1
Difficulty  : Medium
Question    : Find neighborhoods where you can sleep on a real bed in a villa with internet while paying the lowest price possible.
Tables      : airbnb_search_details

<airbnb_search_details>
id                          int
price                       float
property_type               varchar
room_type                   varchar
amenities                   varchar
accommodates                int
bathrooms                   int
bed_type                    varchar
cancellation_policy         varchar
cleaning_fee                bool
city                        varchar
host_identity_verified      varchar
host_response_rate          varchar
host_since                  datetime
neighbourhood               varchar
number_of_reviews           int
review_scores_rating        float
zipcode                     int
bedrooms                    int
beds                        int

*/


-- note:
-- not suggest use limit 1 script to get lowest price, if match results have multiple records that same lowest price, it will loss.


-- solution 1:
WITH rk_neighbourhood AS (
    SELECT neighbourhood,
           RANK() OVER (ORDER BY MIN(price)) AS rk
    FROM airbnb_search_details
    WHERE property_type = 'Villa' 
        AND bed_type = 'Real Bed'
        AND amenities ILIKE '%Internet%'
    GROUP BY neighbourhood
)
SELECT neighbourhood
FROM rk_neighbourhood
WHERE rk = 1
