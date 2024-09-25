WITH cte_dim_ocorrencia AS (
    SELECT DISTINCT TIPO_OCORRENCIA
    FROM {{ ref('stg_ocorrencias') }}
)
SELECT {{ dbt_utils.generate_surrogate_key(['TIPO_OCORRENCIA']) }} AS ID_TIPO_OCORRENCIA
    ,TIPO_OCORRENCIA
FROM cte_dim_ocorrencia
ORDER BY 2
