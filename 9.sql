with phone_flag as (
    select 
        calls_ivr_id,
        step_name,
        step_result,
        customer_phone,
        case 
            when step_name = 'CUSTOMERINFOBYPHONE.TX' and step_result = 'OK' then 1 
            else 0 
        end as info_by_phone_lg
    from `keepcoding.ivr_details`
)

select 
    calls_ivr_id,
    max(info_by_phone_lg) as info_by_phone_lg,
    customer_phone,
    step_name
from phone_flag
where customer_phone != 'UNKNOWN'
group by calls_ivr_id,customer_phone,step_name;