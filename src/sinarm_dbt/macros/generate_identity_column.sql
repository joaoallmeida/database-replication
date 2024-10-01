{% macro generate_identity_column(col_name) %}
    ROW_NUMBER() OVER (ORDER BY (SELECT {{ col_name }}))
{% endmacro %}
