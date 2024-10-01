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
    A.ID
    ,F.ID AS ID_UF
    ,E.ID AS ID_MUNICIPIO
    ,B.ID AS ID_ABRANGENCIA
    ,D.ID AS ID_CALIBRE
    ,G.ID AS ID_ESPECIE
    ,C.ID AS ID_MARCA
    ,I.ID AS ID_TIPO
    ,J.ID AS ID_GENERO
    ,H.ID AS ID_STATUS
    ,A.TOTAL
    ,A.ANO_EMISSAO
    ,A.MES_EMISSAO
    ,CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
    ,A.DT_CARGA AS DT_CARGA_STG
FROM stg_portes A
INNER JOIN dim_abrangencia B    ON A.ABRANGENCIA = B.DESC_ABRANGENCIA
INNER JOIN dim_marca C          ON A.MARCA_ARMA = C.DESC_MARCA
INNER JOIN dim_calibre D        ON A.CALIBRE_ARMA = D.DESC_CALIBRE
INNER JOIN dim_municipio E      ON A.MUNICIPIO = E.DESC_MUNICIPIO
INNER JOIN dim_uf F             ON A.UF = F.DESC_UF
INNER JOIN dim_especie_arma G   ON  A.ESPECIE_ARMA = G.DESC_ESPECIE
INNER JOIN dim_status H         ON A.STATUS = H.DESC_STATUS
INNER JOIN dim_tipo_porte I     ON A.TIPO = I.DESC_TIPO
INNER JOIN dim_genero J         ON A.SEXO = J.DESC_GENERO
ORDER BY A.ID
