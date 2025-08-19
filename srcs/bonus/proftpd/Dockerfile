FROM alpine:3.21

COPY ./entrypoint.sh /entrypoint.sh

RUN apk update && apk add --no-cache proftpd && mkdir -p /run/proftpd \
    && mkdir -p /run/proftpd && chmod +x /entrypoint.sh

COPY ./proftpd.conf /etc/proftpd/

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "proftpd", "-n" ]
