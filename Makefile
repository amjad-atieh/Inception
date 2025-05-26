COMPOSE = docker compose

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

build:
	./certGen.sh
	$(COMPOSE) up --build -d

clean:
	$(COMPOSE) down -v
	rm -fr NGINX/certs

.PHONY: up down build clean