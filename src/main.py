from pipe.ingestion import Ingestion
import yaml
import logging

logging.basicConfig(level='INFO',format='%(asctime)s - [%(levelname)s] >> %(message)s')

def main():
    ingest = Ingestion()

    with open('src/pipe/orchestration.yml','r') as file:
        content  = yaml.safe_load(file)

    sources = content['pipeline']['ingestion']
    transforms = content['pipeline']['transformation']

    for source in sources:

        source_name = source['name']

        df = ingest.get_raw_data(source['url'], source_name)
        df = ingest.raw_data_clean(df, source_name, transforms)

        ingest.load_postgre(df, 'raw', source_name)

if __name__=="__main__":
    main()
