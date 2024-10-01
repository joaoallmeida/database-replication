WITH cte_dim_status AS (
    SELECT STATUS FROM {{ ref('stg_portes') }}
    UNION
    SELECT STATUS_REGISTRO FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ generate_identity_column('STATUS') }} AS ID
    , STATUS AS DESC_STATUS
    , CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
FROM cte_dim_status
ORDER BY 2
