WITH dim_ocorrencia AS (
    SELECT * FROM {{ ref('dim_ocorrencia') }}
),
dim_marca AS (
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
stg_ocorrencias AS (
    SELECT * FROM {{ ref('stg_ocorrencias') }}

)
SELECT DISTINCT
    A.ID
    ,F.ID AS ID_UF
    ,E.ID AS ID_MUNICIPIO
    ,B.ID AS ID_TIPO_OCORRENCIA
    ,D.ID AS ID_CALIBRE
    ,G.ID AS ID_ESPECIE
    ,C.ID AS ID_MARCA
    ,A.TOTAL
    ,A.MAIS_1000_MIL_HAB
    ,A.ANO_OCORRENCIA
    ,A.MES_OCORRENCIA
    ,CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS DT_CARGA
    ,A.DT_CARGA AS DT_CARGA_STG
FROM stg_ocorrencias A
INNER JOIN dim_ocorrencia B ON A.TIPO_OCORRENCIA = B.DESC_TIPO_OCORRENCIA
INNER JOIN dim_marca C      ON A.MARCA_ARMA = C.DESC_MARCA
INNER JOIN dim_calibre D    ON A.CALIBRE_ARMA = D.DESC_CALIBRE
INNER JOIN dim_municipio E  ON A.MUNICIPIO = E.DESC_MUNICIPIO
INNER JOIN dim_uf F         ON A.UF = F.DESC_UF
INNER JOIN dim_especie_arma G ON A.ESPECIE_ARMA = G.DESC_ESPECIE
ORDER BY A.ID
