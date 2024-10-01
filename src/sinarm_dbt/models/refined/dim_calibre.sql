WITH cte_dim_calibre AS (
    SELECT CALIBRE_ARMA FROM {{ ref('stg_ocorrencias') }}
    UNION
    SELECT CALIBRE_ARMA FROM {{ ref('stg_portes') }}
    UNION
    SELECT CALIBRE_ARMA FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ generate_identity_column('CALIBRE_ARMA') }} AS ID
    ,CALIBRE_ARMA AS DESC_CALIBRE
    ,CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
FROM cte_dim_calibre
ORDER BY 2
