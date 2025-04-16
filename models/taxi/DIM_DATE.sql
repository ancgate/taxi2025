{{
    config(
         materialized='table'
    )
}}

WITH RECURSIVE date_cte AS (
    SELECT CAST('2024-01-01 00:00:00' AS timestamp) AS date_value
    UNION ALL
    SELECT date_value + interval '1 hour'
    FROM date_cte
    WHERE date_value + interval '1 hour' <= CAST('2025-12-31 23:00:00' AS timestamp)
)

SELECT
  {{ datetime_to_yyyymmddhh('date_value') }} AS date_id,
  date_value AS timestamp_is_isoformat,
  CAST(EXTRACT(YEAR FROM date_value) AS INTEGER) AS year_number,
  CAST(EXTRACT(QUARTER FROM date_value) AS INTEGER) AS quarter_number,
  CAST(EXTRACT(MONTH FROM date_value) AS INTEGER) AS month_number,
  CAST(EXTRACT(DAY FROM date_value) AS INTEGER) AS day_number,
  CAST(EXTRACT(HOUR FROM date_value) AS INTEGER) AS hour_number,
  CAST(FLOOR((EXTRACT(day FROM date_value) - 1) / 7) AS INTEGER) + 1 AS week_of_month,
  CAST(EXTRACT(week FROM date_value) AS INTEGER) AS week_of_year,
  TO_CHAR(date_value, 'Month') AS month_name,
  CAST(DAYNAME(date_value) AS VARCHAR) AS day_name,
FROM date_cte