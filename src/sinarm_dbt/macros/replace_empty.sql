{% macro replace_empty(col) %}

    CASE 
        WHEN ( {{ col }} IS NULL ) OR ( {{ col }} = '' ) OR ( {{ col }} = ' ' ) THEN 'N/A'
        ELSE {{ col }}
    END
    
{% endmacro %}
