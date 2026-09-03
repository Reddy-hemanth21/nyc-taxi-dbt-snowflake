with source as (

    select * from {{ source('raw', 'yellow_trips') }}

),

cleaned as (

    select
        cast("VendorID" as integer)                     as vendor_id,
        cast("tpep_pickup_datetime" as timestamp_ntz)   as pickup_datetime,
        cast("tpep_dropoff_datetime" as timestamp_ntz)  as dropoff_datetime,
        cast("passenger_count" as integer)              as passenger_count,
        cast("trip_distance" as float)                  as trip_distance,
        cast("RatecodeID" as integer)                   as ratecode_id,
        "store_and_fwd_flag"                            as store_and_fwd_flag,
        cast("PULocationID" as integer)                 as pickup_location_id,
        cast("DOLocationID" as integer)                 as dropoff_location_id,
        cast("payment_type" as integer)                 as payment_type,
        cast("fare_amount" as float)                    as fare_amount,
        cast("extra" as float)                          as extra,
        cast("mta_tax" as float)                        as mta_tax,
        cast("tip_amount" as float)                     as tip_amount,
        cast("tolls_amount" as float)                   as tolls_amount,
        cast("improvement_surcharge" as float)          as improvement_surcharge,
        cast("total_amount" as float)                   as total_amount,
        cast("congestion_surcharge" as float)           as congestion_surcharge,
        cast("Airport_fee" as float)                    as airport_fee

    from source

)

select *
from cleaned
where pickup_datetime >= '2024-01-01'
  and pickup_datetime <  '2024-02-01'
  and passenger_count > 0
  and trip_distance > 0
  and total_amount > 0