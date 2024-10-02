import logging
import os
import yaml
import logging
import polars as pl
from unidecode import unidecode

logging.basicConfig(level='INFO',format='%(asctime)s - [%(levelname)s] >> %(message)s')

def load_postgre(df: pl.DataFrame, schema:str , table:str) -> int:
    CONN_URL = f'postgresql://{os.environ['THOR_DBUSER']}:{os.environ['THOR_DBPASSWORD']}@{os.environ['THOR_DBHOST']}:5432/{os.environ['THOR_DATABASE']}'
    return df.write_database(f'{schema}.{table}',CONN_URL, if_table_exists='append', engine="sqlalchemy")

def raw_data_clean(df:pl.DataFrame, source:str,  resources:list) -> pl.DataFrame:

    for resource in resources:

        if source == resource['name']:
            logging.info(f'Cleaning Data from resource: {resource["name"]}')
            
            for scol in resource['string_columns']:
                df = df.with_columns(
                    pl.col(scol).map_elements(lambda x: unidecode(x), return_dtype=pl.String).str.strip_chars().str.to_titlecase(),
                )

            for icol in resource['integer_columns']:
                df = df.with_columns(
                    pl.col(icol).cast(pl.Int32)
                )

            df = df.rename({col: col.lower() for col in df.columns})

    return df

def get_raw_data(url:str, source:str) -> pl.DataFrame:
    logging.info(f'Getting data from source: {source}')
    try:
        df = pl.read_csv(url, separator=';', encoding='ISO-8859-1')
    except Exception as e:
        logging.error(f'Failure to get data from source >>{source}<<: {e}')
        raise e
    return df

if __name__=="__main__":

    with open('src/pipe/orchestration.yml','r') as file:
        content  = yaml.safe_load(file)

    sources = content['pipeline']['ingestion']
    transforms = content['pipeline']['transformation']

    for source in sources:
        
        source_name = source['name']

        df = get_raw_data(source['url'], source_name)
        df = raw_data_clean(df, source_name, transforms)

        load_postgre(df, 'raw', source_name)