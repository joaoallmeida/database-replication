WITH cte_dim_especie_arma AS (
    SELECT ESPECIE_ARMA FROM {{ ref('stg_ocorrencias') }}
    UNION
    SELECT ESPECIE_ARMA FROM {{ ref('stg_portes') }}
    UNION
    SELECT ESPECIE_ARMA FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['ESPECIE_ARMA']) }} AS ID_ESPECIE
    ,ESPECIE_ARMA
FROM cte_dim_especie_arma
ORDER BY 2
