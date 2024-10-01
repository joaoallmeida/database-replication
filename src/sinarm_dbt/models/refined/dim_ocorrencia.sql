WITH cte_dim_ocorrencia AS (
    SELECT DISTINCT TIPO_OCORRENCIA
    FROM {{ ref('stg_ocorrencias') }}
)
SELECT {{ generate_identity_column('TIPO_OCORRENCIA') }} AS ID
    ,TIPO_OCORRENCIA AS DESC_TIPO_OCORRENCIA
    ,CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
FROM cte_dim_ocorrencia
ORDER BY 2
