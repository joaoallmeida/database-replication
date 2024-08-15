SHELL := /bin/bash

SOURCE_JSON := $(shell cat src/connectors/sourceConnector.json)
SINK_JSON := $(shell cat src/connectors/sinkConnector.json)

define get_container_ip
$(shell docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(1))
endef

container:
	@echo -e "\n:: Building docker containers ::\n"
	docker compose -f docker/docker-compose.yaml up -d
	
	@echo -e "\n:: Waiting 30s to services up ::\n"
	@sleep 30

connector: container
	@echo -e "\n:: Setting up Kafka connectors ::\n"
	curl -i -s -X POST 127.0.0.1:8083/connectors/ -H "Accept:application/json" -H "Content-Type:application/json" -d '$(SOURCE_JSON)'
	curl -i -s -X POST 127.0.0.1:8083/connectors/ -H "Accept:application/json" -H "Content-Type:application/json" -d '$(SINK_JSON)'

py-dependencies:
	@echo -e "\n:: Install Python Dependencies ::\n"
	poetry install

environment:
	@echo -e "\n:: Creating Env File ::\n"
	@echo -e "POSTGRE_HOST=$(call get_container_ip, primarydb)\nPOSTGRE_HOST_REPLICA=$(call get_container_ip, replicadb)\nPOSTGRE_USER=root\nPOSTGRE_PASSWORD=primarydb2024\nPOSTGRE_DATABASE=sinarm" >> .env
	@echo -e "\n:: .env file created! ::\n"

destroy:
	docker compose -f docker/docker-compose.yaml down -v
	rm .env
	@echo -e "\n:: Cleanup complete! ::\n"

build: container connector environment
	@echo -e "\n:: Build complete! ::\n"
