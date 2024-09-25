SELECT 
    ID_REGISTRO
    ,ANO_EMISSAO	
    ,MES_MISSAO
    ,{{ replace_empty('UF') }} AS UF
    ,{{ replace_empty('MUNICIPIO') }} AS MUNICIPIO
    ,{{ replace_empty('ESPECIE_ARMA') }} AS ESPECIE_ARMA
    ,{{ replace_empty('MARCA_ARMA') }} AS MARCA_ARMA
    ,{{ replace_empty('CALIBRE_ARMA') }} AS CALIBRE_ARMA
    ,{{ replace_empty('SEXO') }} AS SEXO
    ,STATUS_REGISTRO
    ,CATEGORIA
    ,TOTAL
    ,DT_CARGA
    ,CURRENT_TIMESTAMP AS DT_CARGA_STG
FROM {{source('raw','registros')}}

