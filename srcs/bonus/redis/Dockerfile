FROM alpine:3.21

COPY ./entrypoint.sh /entrypoint.sh

RUN apk update && apk add --no-cache redis envsubst && chmod +x /entrypoint.sh

COPY ./redis-sample.conf /etc/redis-sample.conf

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "redis-server", "/etc/redis.conf" ]
