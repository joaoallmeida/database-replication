WITH cte_dim_municipio AS (
    SELECT MUNICIPIO FROM {{ ref('stg_ocorrencias') }}
    UNION
    SELECT MUNICIPIO FROM {{ ref('stg_portes') }}
    UNION
    SELECT MUNICIPIO FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['MUNICIPIO']) }} AS ID_MUNICIPIO
    , MUNICIPIO
FROM cte_dim_municipio
ORDER BY 2
