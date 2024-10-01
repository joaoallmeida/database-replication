WITH cte_dim_marca AS (
    SELECT MARCA_ARMA FROM {{ ref('stg_ocorrencias') }}
    UNION
    SELECT MARCA_ARMA FROM {{ ref('stg_portes') }}
    UNION
    SELECT MARCA_ARMA FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ generate_identity_column('MARCA_ARMA') }} AS ID
    , MARCA_ARMA AS  DESC_MARCA
    , CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
FROM cte_dim_marca
ORDER BY 2
