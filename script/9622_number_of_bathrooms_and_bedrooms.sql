/*

Title       : Number Of Bathrooms And Bedrooms
Link        : https://platform.stratascratch.com/coding/9622-number-of-bathrooms-and-bedrooms?code_type=1
Difficulty  : Easy
Question    : Find the average number of bathrooms and bedrooms for each city’s property types. Output the result along with the city name and the property type.
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
       property_type, 
       AVG(bathrooms) AS avg_bathrooms,
       AVG(bedrooms) AS avg_bedrooms
FROM airbnb_search_details
GROUP BY city, property_type
