WITH cte_dim_categoria AS (
    SELECT DISTINCT CATEGORIA FROM {{ ref('stg_registros') }}
)
SELECT
    {{ dbt_utils.generate_surrogate_key(['CATEGORIA']) }} AS ID_CATEGORIA
    , CATEGORIA
FROM cte_dim_categoria
ORDER BY 2
