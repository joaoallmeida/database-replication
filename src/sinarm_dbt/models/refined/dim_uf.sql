WITH cte_dim_uf AS (
    SELECT UF FROM {{ ref('stg_ocorrencias') }}
    UNION
    SELECT UF FROM {{ ref('stg_portes') }}
    UNION
    SELECT UF FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ generate_identity_column('UF') }} AS ID
    ,UF AS DESC_UF
    ,CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
FROM cte_dim_uf
ORDER BY 2
