WITH cte_dim_tipo_porte AS (
    SELECT DISTINCT TIPO FROM {{ ref('stg_portes') }}
)
SELECT
    {{ dbt_utils.generate_surrogate_key(['TIPO']) }} AS ID_PORTE
    , TIPO
FROM cte_dim_tipo_porte
ORDER BY 2
