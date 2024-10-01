WITH cte_dim_abrangencia AS (
    SELECT DISTINCT ABRANGENCIA FROM {{ ref('stg_portes') }}
)
SELECT
    {{ generate_identity_column('ABRANGENCIA') }} AS ID
    , ABRANGENCIA AS  DESC_ABRANGENCIA
    , CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
FROM cte_dim_abrangencia
ORDER BY 2
