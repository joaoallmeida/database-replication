#!/bin/bash

#Source Connector
SOURCE_JSON=$(cat $PWD/src/connectors/sourceConnector.json)
curl -i -s -X POST -H "Accept:application/json" -H "Content-Type:application/json"  127.0.0.1:8083/connectors/ -d "$SOURCE_JSON"

#Sink Connector
SINK_JSON=$(cat $PWD/src/connectors/sinkConnector.json)
curl -i -s -X POST -H "Accept:application/json" -H "Content-Type:application/json" 127.0.0.1:8083/connectors/ -d "$SINK_JSON"
