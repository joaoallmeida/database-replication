WITH cte_dim_genero AS (
    SELECT SEXO FROM {{ ref('stg_portes') }}
    UNION
    SELECT SEXO FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['SEXO']) }} AS ID_GENERO
    , SEXO AS GENERO
FROM cte_dim_genero
ORDER BY 2
