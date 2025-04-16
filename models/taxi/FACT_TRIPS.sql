{{ config(materialized='table') }}

WITH green_cte AS (

  SELECT 
    VENDORID AS vendor_id,
    TO_NUMBER(TO_CHAR(CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(LPEP_PICKUP_DATETIME/1000/1000)),'YYYYMMDDHH'))  as pickup_date_id,
	TO_NUMBER(TO_CHAR(CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(LPEP_DROPOFF_DATETIME/1000/1000)),'YYYYMMDDHH'))  as dropoff_date_id,
    DATEDIFF(second, CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(LPEP_PICKUP_DATETIME/1000/1000)), CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(LPEP_DROPOFF_DATETIME/1000/1000))) as trip_duration,
	RATECODEID as rate_code_id,
	PULOCATIONID as pickup_location_id,
	DOLOCATIONID as dropoff_location_id,
	PASSENGER_COUNT as passenger_count,
	TRIP_DISTANCE as trip_distance,
	FARE_AMOUNT as fare_amount,
	EXTRA as extra,
	MTA_TAX as mta_tax,
	TIP_AMOUNT tip_amount,
	TOLLS_AMOUNT tolls_amount,
	EHAIL_FEE as ehail_fee,
	IMPROVEMENT_SURCHARGE as improvement_surcharge,
	TOTAL_AMOUNT as total_amount,
	PAYMENT_TYPE as payment_type_id, 
	TRIP_TYPE as trip_type_id,
	CONGESTION_SURCHARGE as congestion_surcharge,
    2 as taxi_type_id,
    0 as airport_fee
  FROM 
  public.green_raw
),
yellow_cte AS (

  SELECT 
  
    VENDORID AS vendor_id,
    TO_NUMBER(TO_CHAR(CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(TPEP_PICKUP_DATETIME/1000/1000)),'YYYYMMDDHH'))  as pickup_date_id,
	TO_NUMBER(TO_CHAR(CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(TPEP_DROPOFF_DATETIME/1000/1000)),'YYYYMMDDHH'))  as dropoff_date_id,
    DATEDIFF(second, CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(TPEP_PICKUP_DATETIME/1000/1000)), CONVERT_TIMEZONE('America/New_York', 'UTC', TO_TIMESTAMP(TPEP_DROPOFF_DATETIME/1000/1000))) as trip_duration,
	PASSENGER_COUNT as passenger_count,
	TRIP_DISTANCE as trip_distance,
	RATECODEID as rate_code_id,
	PULOCATIONID as pickup_location_id,
	DOLOCATIONID as dropoff_location_id,
	PAYMENT_TYPE as payment_type_id, 
	FARE_AMOUNT as fare_amount,
	EXTRA as extra,
    0 as ehail_fee,
	MTA_TAX as mta_tax,
	TIP_AMOUNT as tip_amount,
	TOLLS_AMOUNT as tolls_amount,
	IMPROVEMENT_SURCHARGE as improvement_surcharge,
	TOTAL_AMOUNT as total_amount,
	CONGESTION_SURCHARGE as congestion_surcharge,
	AIRPORT_FEE as airport_fee,
    1 as taxi_type_id,
    99 as trip_type_id
  FROM public.yellow_raw
)

Select * from green_cte
UNION 
SELECT * from yellow_cte