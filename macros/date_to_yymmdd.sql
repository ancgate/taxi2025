{% macro date_to_yymmdd(date) %}
CAST(TO_CHAR({{ date }}, 'YYYYMMDD') AS INTEGER)
{% endmacro %}