.PHONY: help build up start down destroy stop restart rebuild
all: up
help:	## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)
build:	## Build the Docker network.
	mkdir -p /home/lfournie/data/mariadb
	mkdir -p /home/lfournie/data/wordpress
	docker-compose -f sources/docker-compose.yml build
up:	## Build the Docker network and start all services.
	mkdir -p /home/lfournie/data/mariadb
	mkdir -p /home/lfournie/data/wordpress
	docker-compose -f sources/docker-compose.yml up --build
start:	## Start all existing services.
	docker-compose -f sources/docker-compose.yml start
down:	## Stop all services and removes all containers.
	docker-compose -f sources/docker-compose.yml down
destroy:## Stop all services and removes all containers, networks, volumes and images.
	docker-compose -f sources/docker-compose.yml down -v
	docker system prune -a --filter label=wordpress --filter label=mariadb --filter label=nginx
stop:	## Stop all existing services.
	docker-compose -f sources/docker-compose.yml stop
restart:## Stop all existing services and restart them cleanly.
	docker-compose -f sources/docker-compose.yml stop
	docker-compose -f sources/docker-compose.yml up
rebuild: ## Remove all existing services and clean all containers, networks, volumes and images before rebuilding everything cleanly.
	docker-compose -f sources/docker-compose.yml down -v
	docker system prune -a --filter laber=wordpress --filter label=mariadb --filter label=nginx
	docker-compose -f sources/docker-compose.yml up --build

