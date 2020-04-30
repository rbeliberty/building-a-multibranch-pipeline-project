build:
	SYMFONY_VERSION=3.4.* docker-compose up --build

upd:
	@docker-compose up -d

up:
	@docker-compose up

down:
	@docker-compose down