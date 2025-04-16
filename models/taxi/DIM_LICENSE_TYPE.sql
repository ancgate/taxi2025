{{ config(materialized='table') }}


WITH hvfhv_cte AS (
    SELECT DISTINCT hvfhs_license_num
    FROM public.hvfhv_raw)

SELECT 
    ROW_NUMBER() OVER (ORDER BY hvfhs_license_num) AS LICENSE_TYPE_ID,
    hvfhs_license_num
FROM hvfhv_cte