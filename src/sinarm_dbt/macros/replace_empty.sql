{% macro replace_empty(col) %}

    CASE 
        WHEN ( {{ col }} IS NULL ) OR ( {{ col }} = '' ) OR ( {{ col }} = ' ' ) THEN NULL
        ELSE {{ col }}
    END
    
{% endmacro %}