drop materialized view electricity_view;
create materialized view electricity_view as (
    select *,
           to_char(measure, 'iyyy')::int as iso_year,
           to_char(measure, 'iw')::int as iso_week
    from electricity
--     where measure between '2021-12-31T22:45:00' and '2022-01-01T00:30:00'
    order by measure
)
;
select * from electricity_view;

-- Backup
create table electricity_backup as select * from electricity;
