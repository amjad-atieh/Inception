SRCS = ./srcs
COMPOSE = docker compose -f $(SRCS)/docker-compose.yml
INTRA = aatieh

build:
	mkdir -p /home/$(INTRA)/data/volumes/wordpress
	mkdir -p /home/$(INTRA)/data/volumes/mariadb
	mkdir -p /home/$(INTRA)/data/volumes/adminer
	$(COMPOSE) up --build -d
	$(MAKE) ps

up:
	$(COMPOSE) up -d; 
	$(MAKE) ps

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean: clean
	rm -fr /home/aatieh/data/volumes/*

re: fclean build

ps:
	$(COMPOSE) ps

.PHONY: up down build clean fclean re