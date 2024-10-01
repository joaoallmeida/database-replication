WITH cte_dim_tipo_porte AS (
    SELECT DISTINCT TIPO FROM {{ ref('stg_portes') }}
)
SELECT
   {{ generate_identity_column('TIPO') }} AS ID
    , TIPO AS DESC_TIPO
    ,CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
FROM cte_dim_tipo_porte
ORDER BY 2
