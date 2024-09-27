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
dim_genero AS (
    SELECT * FROM {{ ref('dim_genero') }}
),
dim_categoria AS (
    SELECT * FROM {{ ref('dim_categoria') }}
),
stg_registros AS (
    SELECT * FROM {{ ref('stg_registros') }}

)
SELECT DISTINCT
    A.ID_REGISTRO
    ,F.ID_UF
    ,E.ID_MUNICIPIO
    ,D.ID_CALIBRE
    ,G.ID_ESPECIE
    ,C.ID_MARCA
    ,B.ID_CATEGORIA
    ,H.ID_GENERO
    ,A.TOTAL
    ,A.ANO_EMISSAO
    ,A.MES_EMISSAO
    ,CURRENT_TIMESTAMP AS DT_CARGA
    ,A.DT_CARGA AS DT_CARGA_STG
FROM stg_registros A
INNER JOIN dim_categoria B ON A.CATEGORIA = B.CATEGORIA
INNER JOIN dim_marca C ON A.MARCA_ARMA = C.MARCA_ARMA
INNER JOIN dim_calibre D ON A.CALIBRE_ARMA = D.CALIBRE_ARMA
INNER JOIN dim_municipio E ON A.MUNICIPIO = E.MUNICIPIO
INNER JOIN dim_uf F ON A.UF = F.UF
INNER JOIN dim_especie_arma G ON  A.ESPECIE_ARMA = G.ESPECIE_ARMA
INNER JOIN dim_genero H ON A.SEXO = H.GENERO
ORDER BY A.ID_REGISTRO
