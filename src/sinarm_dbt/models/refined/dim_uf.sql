WITH cte_dim_uf AS (
    SELECT UF FROM {{ ref('stg_ocorrencias') }}
    UNION
    SELECT UF FROM {{ ref('stg_portes') }}
    UNION
    SELECT UF FROM {{ ref('stg_registros') }}
)
SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['UF']) }} AS ID_UF
    ,UF
FROM cte_dim_uf
ORDER BY 2
