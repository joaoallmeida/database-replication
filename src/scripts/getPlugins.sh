#!/bin/bash

# Criar diretório para armazenar os JARs do conector
mkdir -p /kafka/connect/debezium-connector-avro

# Lista de URLs para download
jars=(
    "https://packages.confluent.io/maven/io/confluent/common-config/7.7.0/common-config-7.7.0.jar"
    "https://packages.confluent.io/maven/io/confluent/common-utils/7.7.0/common-utils-7.7.0.jar"
    "https://packages.confluent.io/maven/io/confluent/kafka-avro-serializer/7.7.0/kafka-avro-serializer-7.7.0.jar"
    "https://packages.confluent.io/maven/io/confluent/kafka-connect-avro-converter/7.7.0/kafka-connect-avro-converter-7.7.0.jar"
    "https://packages.confluent.io/maven/io/confluent/kafka-connect-avro-data/7.7.0/kafka-connect-avro-data-7.7.0.jar"
    "https://packages.confluent.io/maven/io/confluent/kafka-schema-converter/7.7.0/kafka-schema-converter-7.7.0.jar"
    "https://packages.confluent.io/maven/io/confluent/kafka-schema-registry-client/7.7.0/kafka-schema-registry-client-7.7.0.jar"
    "https://packages.confluent.io/maven/io/confluent/kafka-schema-serializer/7.7.0/kafka-schema-serializer-7.7.0.jar"
    "https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.27.1/commons-compress-1.27.1.jar"
    "https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.2/failureaccess-1.0.2.jar"
    "https://repo1.maven.org/maven2/com/google/guava/guava/33.3.0-jre/guava-33.3.0-jre.jar"
    "https://repo1.maven.org/maven2/com/eclipsesource/minimal-json/minimal-json/0.9.4/minimal-json-0.9.4.jar"
    "https://repo1.maven.org/maven2/com/google/re2j/re2j/1.7/re2j-1.7.jar"
    "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.13/slf4j-api-2.0.13.jar"
    "https://repo1.maven.org/maven2/org/yaml/snakeyaml/2.2/snakeyaml-2.2.jar"
    "https://repo1.maven.org/maven2/io/swagger/core/v3/swagger-annotations/2.2.22/swagger-annotations-2.2.22.jar"
    "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.17.2/jackson-databind-2.17.2.jar"
    "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.17.2/jackson-core-2.17.2.jar"
    "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.17.2/jackson-annotations-2.17.2.jar"
    "https://repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformat-csv/2.17.2/jackson-dataformat-csv-2.17.2.jar"
    "https://repo1.maven.org/maven2/io/confluent/logredactor/1.0.12/logredactor-1.0.12.jar"
    "https://repo1.maven.org/maven2/io/confluent/logredactor-metrics/1.0.12/logredactor-metrics-1.0.12.jar"
    "https://repo1.maven.org/maven2/org/apache/avro/avro/1.11.3/avro-1.11.3.jar"
)

# Download de cada JAR
for jar in "${jars[@]}"; do
    curl -o "/kafka/connect/debezium-connector-avro/$(basename $jar)" $jar
done

# Iniciar o serviço Debezium Connect
/docker-entrypoint.sh start
