select
  calls_ivr_id,
  calls_phone_number,
  calls_start_date,
  case
    when datetime_diff(calls_start_date, lag(calls_start_date) over(
        partition by calls_phone_number 
        order by calls_start_date
    ), hour) <= 24 then 1
    else 0
  end as repeated_phone_24h,
  case
    when datetime_diff(lead(calls_start_date) over(
        partition by calls_phone_number 
        order by calls_start_date
    ), calls_start_date, hour) <= 24 then 1
    else 0
  end as cause_recall_phone_24h
from `keepcoding.ivr_details`
qualify row_number() over(
    partition by cast(calls_ivr_id as string) 
    order by calls_start_date asc
) = 1;
