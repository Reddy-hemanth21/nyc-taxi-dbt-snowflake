with payment_types as (

    select distinct payment_type
    from {{ ref('stg_yellow_trips') }}
    where payment_type is not null

)

select
    payment_type,
    case payment_type
        when 1 then 'Credit card'
        when 2 then 'Cash'
        when 3 then 'No charge'
        when 4 then 'Dispute'
        when 5 then 'Unknown'
        when 6 then 'Voided trip'
        else 'Unknown'
    end as payment_type_name
from payment_types