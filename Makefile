SRCS = ./srcs
COMPOSE = docker compose -f $(SRCS)/docker-compose.yml
INTRA = aatieh

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

build:
	mkdir -p /home/$(INTRA)/data/volumes/wordpress
	mkdir -p /home/$(INTRA)/data/volumes/mariadb
	$(COMPOSE) up --build -d

clean:
	$(COMPOSE) down -v

fclean: clean
	rm -fr /home/aatieh/data/volumes/*/*

re: fclean build

.PHONY: up down build clean fclean re