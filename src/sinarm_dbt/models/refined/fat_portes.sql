WITH dim_marca AS (
    SELECT * FROM {{ ref('dim_marca') }}
),
dim_calibre AS (
    SELECT * FROM {{ ref('dim_calibre') }}
),
dim_municipio AS (
    SELECT * FROM {{ ref('dim_municipio') }}
),
dim_uf AS (
    SELECT * FROM {{ ref('dim_uf') }}
),
dim_especie_arma AS (
    SELECT * FROM {{ ref('dim_especie_arma') }}
),
dim_status AS (
    SELECT * FROM {{ ref('dim_status') }}
),
dim_genero AS (
    SELECT * FROM {{ ref('dim_genero') }}
),
dim_abrangencia AS (
    SELECT * FROM {{ ref('dim_abrangencia') }}
),
dim_tipo_porte AS (
    SELECT * FROM {{ ref('dim_tipo_porte') }}
),
stg_portes AS (
    SELECT * FROM {{ ref('stg_portes') }}
)
SELECT DISTINCT
    A.ID_PORTE
    ,F.ID_UF
    ,E.ID_MUNICIPIO
    ,B.ID_ABRANGENCIA
    ,D.ID_CALIBRE
    ,G.ID_ESPECIE
    ,C.ID_MARCA
    ,I.ID_TIPO
    ,J.ID_GENERO
    ,H.ID_STATUS
    ,A.TOTAL
    ,A.ANO_EMISSAO
    ,A.MES_EMISSAO
    ,CURRENT_TIMESTAMP AS DT_CARGA
    ,A.DT_CARGA AS DT_CARGA_STG
FROM stg_portes A
INNER JOIN dim_abrangencia B ON A.ABRANGENCIA = B.ABRANGENCIA
INNER JOIN dim_marca C ON A.MARCA_ARMA = C.MARCA_ARMA
INNER JOIN dim_calibre D ON A.CALIBRE_ARMA = D.CALIBRE_ARMA
INNER JOIN dim_municipio E ON A.MUNICIPIO = E.MUNICIPIO
INNER JOIN dim_uf F ON A.UF = F.UF
INNER JOIN dim_especie_arma G ON  A.ESPECIE_ARMA = G.ESPECIE_ARMA
INNER JOIN dim_status H ON A.STATUS = H.STATUS
INNER JOIN dim_tipo_porte I ON A.TIPO = I.TIPO
INNER JOIN dim_genero J ON A.SEXO = J.GENERO
ORDER BY A.ID_PORTE
