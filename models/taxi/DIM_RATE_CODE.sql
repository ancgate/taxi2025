{{ config(materialized='table') }}

WITH ratecode_cte AS (
    SELECT DISTINCT 
           CAST(COALESCE(ratecodeid, 99) AS INTEGER) AS rate_code_id
    FROM public.green_raw
)

SELECT 
    rate_code_id,
    CASE rate_code_id
        WHEN 1 THEN 'Standard rate'
        WHEN 2 THEN 'JFK'
        WHEN 3 THEN 'Newark'
        WHEN 4 THEN 'Nassau or Westchester'
        WHEN 5 THEN 'Negotiated fare'
        WHEN 6 THEN 'Group ride'
        ELSE 'Other'
    END AS rate_code_name
FROM ratecode_cte