{% macro convert_date_to_iso(date_string) %}
TO_CHAR(TO_DATE({{ date_string }}), 'YYYY-MM-DD')
{% endmacro %}