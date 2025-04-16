{{ config(materialized='table') }}

WITH fact_uber_cte AS (

SELECT

TO_NUMBER(TO_CHAR(CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(ON_SCENE_DATETIME/1000/1000)),'YYYYMMDDHH')) AS onscene_date_id,
TO_NUMBER(TO_CHAR(CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(REQUEST_DATETIME/1000/1000)),'YYYYMMDDHH')) AS request_date_id,
TO_NUMBER(TO_CHAR(CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(PICKUP_DATETIME/1000/1000)),'YYYYMMDDHH')) AS pickup_date_id,
TO_NUMBER(TO_CHAR(CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(DROPOFF_DATETIME/1000/1000)),'YYYYMMDDHH')) AS dropoff_date_id,
PULOCATIONID AS pickup_location_id,
DOLOCATIONID AS dropoff_location_id,
TRIP_MILES as trip_miles,
TRIP_TIME as trip_duration,
BASE_PASSENGER_FARE as base_passenger_fare,
TOLLS as tolls,
BCF as bcf,
SALES_TAX as sales_tax,
CONGESTION_SURCHARGE as congestion_surcharge,
AIRPORT_FEE as airport_fee,
TIPS as tips,
DRIVER_PAY as driver,
l.LICENSE_TYPE_ID
FROM {{ ref('DIM_LICENSE_TYPE') }} l 
INNER JOIN public.hvfhv_raw r ON r.hvfhs_license_num = l.hvfhs_license_num
)

select * from fact_uber_cte