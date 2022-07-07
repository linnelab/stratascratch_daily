/*

Title       : Find the unique room types
Link        : https://platform.stratascratch.com/coding/9895-duplicate-emails?code_type=1
Difficulty  : Medium
Question    : Find the unique room types(filter room types column). 
              Output each unique room types in its own row.
Tables      : airbnb_searches

<airbnb_searches>
ds                          datetime
id_user                     varchar
ds_checkin                  datetime
ds_checkout                 datetime
n_searches                  int
n_nights                    float
n_guests_min                int
n_guests_max                int
origin_country              varchar
filter_price_min            float
filter_price_max            float
filter_room_types           varchar
filter_neighborhoods        datetime

*/


-- logic:

-- [solution 1]:
-- 1. use ',' to split text on filter_room_types column and save split string to array. (use STRING_TO_ARRAY())
-- 2. rotate array elements as multi rows. (use UNNEST())
-- 3. #2 results will produce multiple duplicate records of room types, use DISTINCT() remove duplicate rows.
-- 4. exclude empty string: 
--    because source string header on filter_room_types column have "," . Use #1 method "," to split text will produce empty string.

-- [solution 2]:
-- 1. because source string header on filter_room_types column have ",". can use LTRIM() to remove "," on string header.
-- 2. other logic same as #1, #2, and #3 on solution 1.

-- [solution 3]:
-- 1. because source string header on filter_room_types column have ",". can use LTRIM() to remove "," on string header.
-- 2. use REGEXP_SPLIT_TO_TABLE() method split string into table format.


-- solution 1:
SELECT *
FROM (
    SELECT DISTINCT UNNEST(STRING_TO_ARRAY(filter_room_types, ',')) AS room_types
    FROM airbnb_searches
) AS t
WHERE t.room_types <> ''


-- solution 2:
SELECT DISTINCT UNNEST(STRING_TO_ARRAY(LTRIM(filter_room_types, ','), ',')) AS room_types
FROM airbnb_searches


-- solution 3:
SELECT DISTINCT REGEXP_SPLIT_TO_TABLE(LTRIM(filter_room_types, ','), ',') AS room_types
FROM airbnb_searches
