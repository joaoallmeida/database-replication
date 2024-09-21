SHELL := /bin/bash

SOURCE_JSON := $(shell cat src/connectors/source-thordb-connector.json)
SINK_MJOLNIRDB_JSON := $(shell cat src/connectors/sink-mjolnirdb-connector.json)
SINK_STORMBREAKERDB_JSON := $(shell cat src/connectors/sink-stormbreakerdb-connector.json)

define get_container_ip
$(shell docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(1))
endef

container:
	@echo -e "\n:: Building docker containers ::\n"
	docker compose -f docker/docker-compose.yaml up -d

	@echo -e "\n:: Waiting 30s to services up ::\n"
	@sleep 30

connector:
	@echo -e "\n:: Setting up Kafka connectors ::\n"
	curl -i -s -X POST 127.0.0.1:8083/connectors/ -H "Accept:application/json" -H "Content-Type:application/json" -d '$(SOURCE_JSON)'
	curl -i -s -X POST 127.0.0.1:8083/connectors/ -H "Accept:application/json" -H "Content-Type:application/json" -d '$(SINK_MJOLNIRDB_JSON)'
	curl -i -s -X POST 127.0.0.1:8083/connectors/ -H "Accept:application/json" -H "Content-Type:application/json" -d '$(SINK_STORMBREAKERDB_JSON)'

py-dependencies:
	@echo -e "\n:: Install Python Dependencies ::\n"
	poetry install

environment:
	@echo -e "\n:: Creating Env File ::\n"
	echo -e "THOR_DBHOST=$(call get_container_ip, thordb)\nMJOLNIR_DBHOST=$(call get_container_ip, mjolnirdb)\nSTORMBREAKER_DBHOST=$(call get_container_ip, stormbreakerdb)\nTHOR_DBUSER=root\nTHOR_DBPASSWORD=thordb2024\nTHOR_DATABASE=sinarm" >> .env
	@echo -e "\n:: .env file created! ::\n"

destroy:
	docker compose -f docker/docker-compose.yaml down -v
	rm .env
	@echo -e "\n:: Cleanup complete! ::\n"

build: container connector environment
	@echo -e "\n:: Build complete! ::\n"
