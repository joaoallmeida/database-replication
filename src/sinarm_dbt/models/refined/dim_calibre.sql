WITH cte_dim_calibre AS (
    SELECT CALIBRE_ARMA FROM {{ ref('stg_ocorrencias') }}
    UNION
    SELECT CALIBRE_ARMA FROM {{ ref('stg_portes') }}
    UNION
    SELECT CALIBRE_ARMA FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['CALIBRE_ARMA']) }} AS ID_CALIBRE
    ,CALIBRE_ARMA
FROM cte_dim_calibre
ORDER BY 2
