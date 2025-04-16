{{ config(materialized='table') }}

WITH vendor_cte AS (
    SELECT DISTINCT 
           CAST(vendorid AS INTEGER) AS vendor_id
    FROM public.green_raw
    WHERE vendorid IS NOT NULL
)

SELECT 
    vendor_id,
    CASE vendor_id
        WHEN 1 THEN 'Creative Mobile Technologies, LLC'
        WHEN 2 THEN 'VeriFone Inc'
        ELSE 'Other'
    END AS vendor_name
FROM vendor_cte
