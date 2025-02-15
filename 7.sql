select 
    calls_ivr_id, 
    billing_account_id
from `keepcoding.ivr_details`
where billing_account_id != 'UNKNOWN'
qualify row_number() over(
    partition by cast(calls_ivr_id as string) 
    order by billing_account_id asc
) = 1;