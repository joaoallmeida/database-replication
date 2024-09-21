import logging
import os
import yaml
import logging
import polars as pl
from typing import Literal
from unidecode import unidecode

logging.basicConfig(level='INFO',format='%(asctime)s - [%(levelname)s] >> %(message)s')

def load_postgre(df: pl.DataFrame, schema:str , table:str) -> int:
    CONN_URL = f'postgresql://{os.environ['THOR_DBUSER']}:{os.environ['THOR_DBPASSWORD']}@{os.environ['THOR_DBHOST']}:5432/{os.environ['THOR_DATABASE']}'
    return df.write_database(f'{schema}.{table}',CONN_URL, if_table_exists='append', engine="sqlalchemy")

def raw_data_clean(df:pl.DataFrame, resource:Literal['ocorrencias','portes','registros']) -> pl.DataFrame:

    if resource == 'ocorrencias':
        df = df.with_columns(
            pl.col('MUNICIPIO').map_elements(lambda x: unidecode(x), return_dtype=pl.String).str.strip_chars(),
            pl.col('TIPO_OCORRENCIA').map_elements(lambda x: unidecode(x), return_dtype=pl.String).str.strip_chars(),
            pl.col('CALIBRE_ARMA').str.strip_chars(),
            pl.col('ESPECIE_ARMA').str.strip_chars(),
            pl.col('MARCA_ARMA').str.strip_chars(),
            pl.col('ANO_OCORRENCIA').cast(pl.Int32),
            pl.col('MES_OCORRENCIA').cast(pl.Int32),
            pl.col('TOTAL').cast(pl.Int32)
        )
        df = df.rename({col: col.lower() for col in df.columns})

    elif resource == 'portes':

        df = df.with_columns(
            pl.col('MUNICIPIO').map_elements(lambda x: unidecode(x), return_dtype=pl.String).str.strip_chars(),
            pl.col('TIPO').str.strip_chars(),
            pl.col('STATUS').map_elements(lambda x: unidecode(x), return_dtype=pl.String).str.strip_chars(),
            pl.col('ABRANGENCIA').map_elements(lambda x: unidecode(x), return_dtype=pl.String).str.strip_chars(),
            pl.col('ESPECIE_ARMA').str.strip_chars(),
            pl.col('MARCA_ARMA').str.strip_chars(),
            pl.col('CALIBRE_ARMA').str.strip_chars(),
            pl.col('MES_MISSAO').cast(pl.Int32),
            pl.col('ANO_EMISSAO').cast(pl.Int32),
            pl.col('TOTAL').cast(pl.Int32)
        )

        df = df.rename({col:col.lower() for col in df.columns}).rename({"mes_missao":"mes_emissao"})

    elif resource == 'registros':

        df = df.with_columns(
            pl.col('MUNICIPIO').map_elements(lambda x: unidecode(x), return_dtype=pl.String).str.strip_chars(),
            pl.col('STATUS_REGISTRO').map_elements(lambda x: unidecode(x), return_dtype=pl.String).str.strip_chars(),
            pl.col('ESPECIE_ARMA').str.strip_chars(),
            pl.col('MARCA_ARMA').str.strip_chars(),
            pl.col('CALIBRE_ARMA').str.strip_chars(),
            pl.col('SEXO').str.strip_chars(),
            pl.col('CATEGORIA').map_elements(lambda x: unidecode(x), return_dtype=pl.String).str.strip_chars(),
            pl.col('ANO_EMISSAO').cast(pl.Int32),
            pl.col('MES_MISSAO').cast(pl.Int32),
            pl.col('TOTAL').cast(pl.Int32)
        )

        df = df.rename({col:col.lower() for col in df.columns})

    return df

def get_raw_data(url:str, resource:Literal['ocorrencias','portes','registros']) -> pl.DataFrame:
    logging.info(f'Getting data from resource: {resource}')
    try:
        df = pl.read_csv(url, separator=';', encoding='ISO-8859-1')
        df = raw_data_clean(df,resource)
    except Exception as e:
        logging.error(f'Failure to get data from resource >>{resource}<<: {e}')
        raise e
    return df

if __name__=="__main__":

    with open('src/pipe/orchestration.yml','r') as file:
        content  = yaml.safe_load(file)

    for source in content['pipeline'][0]['sources']:
        df = get_raw_data(source['url'], source['name'])
        load_postgre(df, 'raw', source['name'])
