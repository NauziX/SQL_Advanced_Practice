create function keepcoding.cl_int(v_int int64) 
returns int64 
as (
  coalesce(v_int, -999999)
);