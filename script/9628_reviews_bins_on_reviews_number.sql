/*

Title       : Reviews Bins on Reviews Number
Link        : https://platform.stratascratch.com/coding/9628-reviews-bins-on-reviews-number?code_type=1
Difficulty  : Medium
Question    : To better understand the effect of the review count on the price of accomodation, 
              categorize the number of reviews into the following groups along with the price.
              0 reviews: NO
              1 to 5 reviews: FEW
              6 to 15 reviews: SOME
              16 to 40 reviews: MANY
              more than 40 reviews: A LOT
              Output the price and it's categorization. Perform the categorization on accomodation level.
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


-- solution 1:
SELECT price,
       CASE WHEN number_of_reviews = 0 THEN 'NO'
            WHEN number_of_reviews <= 5 THEN 'FEW'
            WHEN number_of_reviews <= 15 THEN 'SOME'
            WHEN number_of_reviews <= 40 THEN 'MANY'
            WHEN number_of_reviews > 40 THEN 'A LOT'
       END AS level
FROM airbnb_search_details
