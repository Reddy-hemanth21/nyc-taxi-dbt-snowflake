with trips as (

    select * from {{ ref('stg_yellow_trips') }}

)

select
    -- surrogate key: one unique id per trip row
    {{ dbt_utils.generate_surrogate_key(['vendor_id', 'pickup_datetime', 'dropoff_datetime', 'pickup_location_id', 'total_amount']) }} as trip_key,

    -- foreign keys to the dimensions
    vendor_id,
    ratecode_id,
    payment_type,
    cast(pickup_datetime as date)   as pickup_date,

    -- location ids
    pickup_location_id,
    dropoff_location_id,

    -- degenerate dimensions
    store_and_fwd_flag,

    -- timestamps
    pickup_datetime,
    dropoff_datetime,
    datediff('minute', pickup_datetime, dropoff_datetime) as trip_duration_minutes,

    -- measures (the numeric facts)
    passenger_count,
    trip_distance,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    congestion_surcharge,
    airport_fee,
    total_amount

from trips