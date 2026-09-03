with vendors as (

    select distinct vendor_id
    from {{ ref('stg_yellow_trips') }}
    where vendor_id is not null

)

select
    vendor_id,
    case vendor_id
        when 1 then 'Creative Mobile Technologies'
        when 2 then 'Curb Mobility'
        when 6 then 'Myle Technologies'
        when 7 then 'Helix'
        else 'Unknown'
    end as vendor_name
from vendors