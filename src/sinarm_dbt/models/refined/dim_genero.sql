WITH cte_dim_genero AS (
    SELECT SEXO FROM {{ ref('stg_portes') }}
    UNION
    SELECT SEXO FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ generate_identity_column('SEXO') }} AS ID
    , SEXO AS DESC_GENERO
    , CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
FROM cte_dim_genero
ORDER BY 2
