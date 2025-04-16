{{ config(materialized='table') }}

WITH lookup_CTE AS (

SELECT  
 
ZONE as zone, 
LOCATIONID as location_id,
BOROUGH as borough, 
LATITUDE as latitude, 
LONGITUDE as longitude, 
ZIPCODE as zipcode
FROM public.lookup_raw
where LocationID != 'LocationID'

),
stage_lookup_CTE  AS (

 
 select 
 CAST(location_id AS INTEGER) AS location_id,
 CAST(borough AS VARCHAR)  AS borough,
 CAST(latitude AS DOUBLE)  AS latitude,
 CAST(longitude AS DOUBLE)  AS longitude,
 CAST(zipcode AS VARCHAR)  AS zipcode,
 CAST(zone AS VARCHAR)  AS zone
FROM lookup_CTE
),
taxi_lookup_cte AS (

  SELECT 
  LOCATIONID as location_id,
  SERVICE_ZONE as service_zone
  FROM public.taxi_zone_lookup_raw
),
location_cte AS (

SELECT 
l.location_id, 
l.borough,
l.zone,
t.service_zone, 
l.longitude,
l.latitude,
l.zipcode
FROM lookup_CTE l INNER JOIN taxi_lookup_cte t on l.location_id = t.location_id
)

SELECT * FROM location_cte
