{{ config(materialized='table',
    unique_key='host_id'
) 
}}

select host_id,
       replace(host_name,' ','-') as host_name,
       host_since,
       is_superhost,
       response_rate,
       case
          when response_rate > 90 then 'very good'
          when response_rate > 80 then 'good'
          when response_rate > 70 then 'fair'
          else 'poor'
        end as response_rate_quality,
       created_at
       
from  {{ ref('bronze_hosts')}}