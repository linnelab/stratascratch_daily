/*

Title       : Total Searches For Rooms
Link        : https://platform.stratascratch.com/coding/9638-total-searches-for-rooms?code_type=1
Difficulty  : Medium
Question    : Find the total number of searches for each room type (apartments, private, shared) by city.
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
SELECT city,
       COUNT(room_type) FILTER (WHERE room_type = 'Entire home/apt') AS apartment_cnt,
       COUNT(room_type) FILTER (WHERE room_type = 'Private room') AS private_cnt,
       COUNT(room_type) FILTER (WHERE room_type = 'Shared room') AS shared_cnt
FROM airbnb_search_details
GROUP BY city


-- solution 2:
SELECT city,
       SUM(CASE WHEN room_type = 'Entire home/apt' THEN 1 ELSE 0 END) AS apartment_cnt,
       SUM(CASE WHEN room_type = 'Private room' THEN 1 ELSE 0 END) AS private_cnt,
       SUM(CASE WHEN room_type = 'Shared room' THEN 1 ELSE 0 END) AS shared_cnt
FROM airbnb_search_details
GROUP BY city
