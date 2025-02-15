select 
    calls_ivr_id, 
    customer_phone
from `keepcoding.ivr_details`
where customer_phone != 'UNKNOWN'
qualify row_number() over(
    partition by cast(calls_ivr_id as string) 
    order by customer_phone asc
) = 1;