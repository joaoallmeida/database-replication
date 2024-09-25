WITH cte_dim_marca AS (
    SELECT MARCA_ARMA FROM {{ ref('stg_ocorrencias') }}
    UNION
    SELECT MARCA_ARMA FROM {{ ref('stg_portes') }}
    UNION
    SELECT MARCA_ARMA FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['MARCA_ARMA']) }} AS ID_MARCA
    ,MARCA_ARMA
FROM cte_dim_marca
ORDER BY 2
