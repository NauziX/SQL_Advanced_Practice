select
    calls_ivr_id, 
    case 
        when countif(module_name = 'AVERIA_MASIVA') > 0 then 1 
        else 0 
    end as masiva_lg
from `keepcoding.ivr_details`
group by 1;