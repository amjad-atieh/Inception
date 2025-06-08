#!/bin/sh
mkdir -p /etc/certs
openssl req -x509 -newkey rsa:2048 -nodes \
  -keyout /etc/certs/server.key -out /etc/certs/server.crt -days 365 \
  -subj "/CN=localhost"

exec "$@"
