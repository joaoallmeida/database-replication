WITH cte_dim_especie_arma AS (
    SELECT ESPECIE_ARMA FROM {{ ref('stg_ocorrencias') }}
    UNION
    SELECT ESPECIE_ARMA FROM {{ ref('stg_portes') }}
    UNION
    SELECT ESPECIE_ARMA FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ generate_identity_column('ESPECIE_ARMA') }} AS ID
    ,ESPECIE_ARMA AS DESC_ESPECIE
    ,CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
FROM cte_dim_especie_arma
ORDER BY 2
