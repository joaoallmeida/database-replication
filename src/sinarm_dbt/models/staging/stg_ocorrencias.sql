SELECT
    ID
    ,{{ replace_empty('UF') }} AS UF
    ,{{ replace_empty('MUNICIPIO') }} AS MUNICIPIO
    ,{{ replace_empty('ESPECIE_ARMA') }} AS ESPECIE_ARMA
    ,{{ replace_empty('MARCA_ARMA') }} AS MARCA_ARMA
    ,{{ replace_empty('CALIBRE_ARMA') }} AS CALIBRE_ARMA
    ,TIPO_OCORRENCIA
    ,ANO_OCORRENCIA
    ,MES_OCORRENCIA
    ,TOTAL
    ,CASE
        WHEN MAIS_1000_MIL_HAB = 'S' THEN 1
        ELSE 0
    END AS MAIS_1000_MIL_HAB
    ,DT_CARGA
    ,CURRENT_TIMESTAMP AS DT_CARGA_STG
FROM {{source('raw','ocorrencias')}}
