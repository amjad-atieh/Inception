#!/bin/sh

envsubst < /etc/redis-sample.conf > /etc/redis.conf

exec "$@"