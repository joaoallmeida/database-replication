WITH cte_dim_categoria AS (
    SELECT DISTINCT CATEGORIA FROM {{ ref('stg_registros') }}
)
SELECT
    {{ generate_identity_column('CATEGORIA') }} AS ID
    ,CATEGORIA AS DESC_CATEGORIA
    ,CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
FROM cte_dim_categoria
ORDER BY 2
