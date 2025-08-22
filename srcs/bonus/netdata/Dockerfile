FROM alpine:3.21

COPY ./netdata.conf /etc/netdata/netdata.conf

RUN apk update && apk add --no-cache netdata

CMD [ "netdata", "-D" ]
