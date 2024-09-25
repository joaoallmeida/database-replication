WITH cte_dim_status AS (
    SELECT STATUS FROM {{ ref('stg_portes') }}
    UNION
    SELECT STATUS_REGISTRO FROM {{ ref('stg_registros') }}
)
SELECT  {{ dbt_utils.generate_surrogate_key(['STATUS']) }} AS ID_STATUS
        ,STATUS
FROM cte_dim_status
ORDER BY 2
