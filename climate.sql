select *
from public.electricity;

alter schema public;

with data as (select *, DATE_PART('week', measure) kw
              from public.electricity
              where week <> DATE_PART('week', measure))
select *
from data;

select count(*)
from electricity;
--
select *
from electricity;

-- SELECT *,LEAD (price,1) OVER (ORDER BY price) AS next_price
-- FROM basket;

-- select
--     lead
-- from electricity

-- SELECT ad.date,
--             AVG(ad.downloads)
--             OVER(ORDER BY ad.date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS avg_downloads
-- FROM app_downloads_by_date ad
-- ;

-- TODO check ob Datenluecken vorhanden

-- Average pro Tag
with electricity_data as (select measure::date measure_date, measure as measure_ts, load
                          from electricity)
select avg(load) as load_day, measure_date
from electricity_data
group by measure_date
order by measure_date
;

-- add index
alter table electricity
add constraint electricity__pk
    unique (measure);

select measure, count(1) as cnt
from electricity
group by measure
having count(1) > 1;

select *
from electricity
where measure between '2020-06-30 21:00:00.000000 +00:00' and '2020-06-30 23:00:00.000000 +00:00';

-- cleanup data

-- 30687.0269999326

-- update electricity
-- set load = (select avg(load) from electricity where measure = '2020-06-30 22:00:00.000000 +00:00' group by measure)
-- where measure = '2020-06-30 22:00:00.000000 +00:00';

-- Alternative via Self Join

--
SELECT el1.measure, AVG(el2.load)
FROM electricity el1
         JOIN electricity el2 ON el1.measure >= el2.measure - interval '7 days'
    AND el2.measure <= el1.measure
GROUP BY el1.measure
ORDER BY el1.measure;

SELECT ad_1.date, AVG(ad_2.downloads)
FROM app_downloads_by_date ad_1
         JOIN app_downloads_by_date ad_2 ON ad_2.date >= ad_1.date - interval '29 days'
    AND ad_2.date <= ad_1.date
GROUP BY ad_1.date
ORDER BY ad_1.date


-- kalenderwoche

with electricity_data as (select *
                                  , DATE_PART('year', measure) year_extracted
                                  , DATE_PART('month', measure) month_extracted
                                  , DATE_PART('week', measure) week_extracted
                          from electricity),
    electricity_data2 as (select measure, load,
                              week, week_extracted,
                              week = week_extracted week_ok,
                              month, month_extracted,
                              month = month_extracted month_ok,
                              year, year_extracted,
                              year = year_extracted year_ok
                          from electricity_data)
select *
from electricity_data2
where 1=1 and
--     (week <> week_extracted or month <> month_extracted or year <> year_extracted)
-- and not year_ok
 measure between  '2022-01-01T00:30:00'
order by measure desc, week_ok, month_ok, year_ok
;



select to_char(date '2022-01-01', 'iyyy-iw') as iso_kw_year;

with dates as (select date '2022-01-01' testdate)
select *
       , date_part('week', testdate)
       , date_part('year', testdate)
, date_part('week', testdate - 7)
, date_part('year', testdate - 7),
    to_char(testdate, 'iyyy-iw') as iso_kw_year,
    to_char(testdate, 'yyyy-ww') as kw_year
    from dates
;

SELECT to_char('2022-01-01'::date, 'iyyy-iw');

--
-- 2022-01-01T00:30:00+01:00;26495.6095001507;2022-01-01T00:30:00+0100;2022;1;1;5;1;1;52

select now();
ALTER DATABASE climate SET timezone TO 'Europe/Berlin';

set timezone
select * from electricity where measure = '2022-01-01T00:30:00';