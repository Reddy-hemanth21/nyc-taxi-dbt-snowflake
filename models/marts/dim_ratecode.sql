with ratecodes as (

    select distinct ratecode_id
    from {{ ref('stg_yellow_trips') }}
    where ratecode_id is not null

)

select
    ratecode_id,
    case ratecode_id
        when 1 then 'Standard rate'
        when 2 then 'JFK'
        when 3 then 'Newark'
        when 4 then 'Nassau or Westchester'
        when 5 then 'Negotiated fare'
        when 6 then 'Group ride'
        when 99 then 'Unknown'
        else 'Unknown'
    end as ratecode_name
from ratecodes