with dates as (

    select distinct
        cast(pickup_datetime as date) as date_day
    from {{ ref('stg_yellow_trips') }}

)

select
    date_day,
    extract(year    from date_day) as year,
    extract(month   from date_day) as month,
    extract(day     from date_day) as day_of_month,
    extract(dayofweek from date_day) as day_of_week,
    case when extract(dayofweek from date_day) in (0, 6)
         then true else false end as is_weekend
from dates