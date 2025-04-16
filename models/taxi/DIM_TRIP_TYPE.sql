{{ config(materialized='table') }}

WITH triptype_cte AS (
    SELECT DISTINCT 
           CAST(COALESCE(trip_type, 99) AS INTEGER) AS trip_type_id
    FROM public.green_raw
)

SELECT 
    trip_type_id,
    CASE trip_type_id
        WHEN 1 THEN 'Street-hail'
        WHEN 2 THEN 'Dispatch'
        WHEN 3 THEN 'Other'
        WHEN 4 THEN 'Other'
        WHEN 5 THEN 'Other'
        ELSE 'Other'
    END AS trip_type_name
FROM triptype_cte
