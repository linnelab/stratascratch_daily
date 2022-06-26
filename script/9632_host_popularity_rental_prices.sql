/*

Title       : Host Popularity Rental Prices
Link        : https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices?code_type=1
Difficulty  : Hard
Question    : You’re given a table of rental property searches by users. 
              The table consists of search results and outputs host information for searchers. 
              Find the minimum, average, maximum rental prices for each host’s popularity rating. 
              The host’s popularity rating is defined as below:
                  0 reviews: New
                  1 to 5 reviews: Rising
                  6 to 15 reviews: Trending Up
                  16 to 40 reviews: Popular
                  more than 40 reviews: Hot
              Tip: The id column in the table refers to the search ID. 
                   You'll need to create your own host_id by concating price, room_type, host_since, zipcode, and number_of_reviews.
              Output host popularity rating and their minimum, average and maximum rental prices.
Tables      : airbnb_host_searches

<airbnb_host_searches>
id                                  int
price                               float
property_type                       varchar
room_type                           varchar
amenities                           varchar
accommodates                        int
bathrooms                           int
bed_type                            varchar
cancellation_policy                 varchar
cleaning_fee                        bool
city                                varchar
host_identity_verified              varchar
host_response_rate                  varchar
host_since                          datetime
neighbourhood                       varchar
number_of_reviews                   int
review_scores_rating                float
zipcode                             int
bedrooms                            int
beds                                int

*/


-- note :
-- source data have duplicate record, so need to group by exclude duplicate record, when use AVG() calculate price result will correct.

-- solution 1: 
WITH host_popularity_rating AS (
    SELECT (price || room_type || host_since || zipcode || number_of_reviews) AS host_id,
           price, 
           CASE WHEN number_of_reviews = 0 THEN 'New'
                WHEN number_of_reviews < 6 THEN 'Rising'
                WHEN number_of_reviews < 16 THEN 'Trending Up'
                WHEN number_of_reviews < 41 THEN 'Popular'
                ELSE 'Hot'
            END AS popularity_rating
    FROM airbnb_host_searches
    GROUP BY host_id, price, popularity_rating
)
SELECT popularity_rating, 
       MIN(price) AS min_price,
       AVG(price) AS avg_price,
       MAX(price) AS max_price
FROM host_popularity_rating
GROUP BY popularity_rating
