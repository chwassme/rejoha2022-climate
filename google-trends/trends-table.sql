create table google_trend_data (
    year integer,
    data jsonb
);
--

drop view google_trends;
create or replace view google_trends as
(

select  to_timestamp(to_number(jsonb_array_elements(data -> 'interest_over_time' -> 'timeline_data') ->> 'timestamp', '9999999999'))::date as period_start
        , 'month' period_length
        , jsonb_array_element(jsonb_array_elements(data -> 'interest_over_time' -> 'timeline_data') -> 'values', 0) ->> 'query' as query
--         , jsonb_array_elements(data -> 'interest_over_time' -> 'timeline_data')
        , jsonb_array_element(jsonb_array_elements(data -> 'interest_over_time' -> 'timeline_data') -> 'values', 0) ->> 'extracted_value' as relevance_100
from google_trend_data
    );