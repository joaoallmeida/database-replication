WITH cte_dim_municipio AS (
    SELECT MUNICIPIO FROM {{ ref('stg_ocorrencias') }}
    UNION
    SELECT MUNICIPIO FROM {{ ref('stg_portes') }}
    UNION
    SELECT MUNICIPIO FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ generate_identity_column('MUNICIPIO') }} AS ID
    , MUNICIPIO AS DESC_MUNICIPIO
    , CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
FROM cte_dim_municipio
ORDER BY 2
