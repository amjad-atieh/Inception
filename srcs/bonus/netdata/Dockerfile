FROM alpine:3.21

COPY ./netdata.conf /etc/netdata/netdata.conf

RUN apk update && apk add --no-cache netdata

# COPY ./httpd.conf /etc/apache2/httpd.conf

# ENTRYPOINT [ "entrypoint.sh" ]

CMD [ "netdata", "-D" ]
