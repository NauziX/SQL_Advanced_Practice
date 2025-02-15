with dni_flag as (
    select 
        calls_ivr_id,
        step_name,
        step_result,
        document_identification,
        document_type,
        billing_account_id,
        case 
            when step_name = 'customerinfobydni.tx' and step_result = 'ok' then 1 
            else 0 
        end as info_by_dni_lg
    from `keepcoding.ivr_details`
)

select 
    calls_ivr_id,
    max(info_by_dni_lg) as info_by_dni_lg,
    document_identification,
    document_type,
    billing_account_id
from dni_flag
where document_identification != 'UNKNOWN' and document_type not in ('UNKNOWN','DESCONOCIDO')
group by calls_ivr_id, document_identification, document_type, billing_account_id;