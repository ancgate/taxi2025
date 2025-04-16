{{ config(materialized='table') }}

SELECT 1 AS taxi_type_id, 'Yellow' AS taxi_type_name
UNION ALL
SELECT 2, 'Green'