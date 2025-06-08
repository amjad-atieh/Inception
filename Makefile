SRCS = ./srcs
COMPOSE = docker compose -f $(SRCS)/docker-compose.yml

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

build:
	# $(SRCS)/certGen.sh
	$(COMPOSE) up --build -d

clean:
	$(COMPOSE) down -v
	# rm -fr $(SRCS)/requirements/nginx/certs

fclean: clean

re: clean build

.PHONY: up down build clean fclean re