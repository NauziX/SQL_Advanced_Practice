select 
    calls_ivr_id, 
    document_type,
    document_identification
from `keepcoding.ivr_details`
where document_type not in ('UNKNOWN','DESCONOCIDO')
qualify row_number() over (
    partition by cast(calls_ivr_id AS STRING) 
    order by document_type asc
) = 1;