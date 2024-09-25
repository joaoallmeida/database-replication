WITH cte_dim_abrangencia AS (
    SELECT DISTINCT ABRANGENCIA FROM {{ ref('stg_portes') }}
)
SELECT
    {{ dbt_utils.generate_surrogate_key(['ABRANGENCIA']) }} AS ID_ABRANGENCIA
    , ABRANGENCIA
FROM cte_dim_abrangencia
ORDER BY 2
