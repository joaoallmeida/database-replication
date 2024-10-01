{% macro replace_empty(col) %}

    CASE
        WHEN ( {{ col }} IS NULL ) THEN 'N/A'
        WHEN ( {{ col }} = '' ) THEN 'N/A'
        WHEN ( {{ col }} = ' ' ) THEN 'N/A'
        ELSE {{ col }}
    END

{% endmacro %}
