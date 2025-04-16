{{ config(materialized='table') }}

WITH payment_type_cte AS (
    SELECT DISTINCT 
           CAST(COALESCE(payment_type, 99) AS INTEGER) AS payment_type_id
    FROM public.green_raw
)

SELECT 
    payment_type_id,
    CASE payment_type_id
        WHEN 1 THEN 'Credit card'
        WHEN 2 THEN 'Cash'
        WHEN 3 THEN 'No Charge'
        WHEN 4 THEN 'Dispute'
        WHEN 5 THEN 'Unknown'
        WHEN 6 THEN 'Voided trip'
        WHEN 99 THEN 'Other'
        ELSE 'Other'
    END AS payment_type_name
FROM payment_type_cte