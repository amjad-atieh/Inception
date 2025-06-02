#!/bin/sh
mkdir -p srcs/requirements/nginx/certs
openssl req -x509 -newkey rsa:2048 -nodes \
  -keyout srcs/requirements/nginx/certs/server.key -out srcs/requirements/nginx/certs/server.crt -days 365 \
  -subj "/CN=localhost"
