SELECT 
    {{ dbt_utils.generate_surrogate_key(['MUNICIPIO', 'TIPO', 'STATUS', 'MARCA_ARMA']) }} AS SK_PORTE
    ,ID_PORTE
    ,ANO_EMISSAO
    ,MES_EMISSAO
    ,UF
    ,MUNICIPIO
    ,TIPO
    ,STATUS
    ,ABRANGENCIA
    ,ESPECIE_ARMA
    ,MARCA_ARMA
    ,CALIBRE_ARMA
    ,SEXO
    ,TOTAL
    ,DT_CARGA
    ,CURRENT_TIMESTAMP AS DT_CARGA_STG
FROM {{source('raw','portes')}}
