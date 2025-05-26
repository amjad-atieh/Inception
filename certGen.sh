#!/bin/sh
mkdir -p NGINX/certs
openssl req -x509 -newkey rsa:2048 -nodes \
  -keyout NGINX/certs/server.key -out NGINX/certs/server.crt -days 365 \
  -subj "/CN=localhost"
