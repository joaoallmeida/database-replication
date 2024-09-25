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
    -- {{ dbt_utils.generate_surrogate_key(['A.ID_OCORRENCIA', 'E.ID_MUNICIPIO', 'B.ID_TIPO_OCORRENCIA', 'D.ID_CALIBRE', 'C.ID_MARCA', 'G.ID_ESPECIE']) }} AS ID
    A.ID_OCORRENCIA
    ,F.ID_UF
    ,E.ID_MUNICIPIO
    ,B.ID_TIPO_OCORRENCIA
    ,D.ID_CALIBRE
    ,G.ID_ESPECIE
    ,C.ID_MARCA
    ,A.TOTAL
    ,A.MAIS_1000_MIL_HAB
    ,A.ANO_OCORRENCIA
    ,A.MES_OCORRENCIA
    ,CURRENT_TIMESTAMP AS DT_CARGA
    ,A.DT_CARGA AS DT_CARGA_STG
FROM stg_ocorrencias A
INNER JOIN dim_ocorrencia B ON A.tipo_ocorrencia = B.tipo_ocorrencia
INNER JOIN dim_marca C ON A.marca_arma = C.marca_arma
INNER JOIN dim_calibre D ON A.calibre_arma = D.calibre_arma
INNER JOIN dim_municipio E ON A.municipio = E.municipio
INNER JOIN dim_uf F ON  A.uf = F.uf
INNER JOIN dim_especie_arma G ON  A.especie_arma = G.especie_arma
ORDER BY A.ID_OCORRENCIA