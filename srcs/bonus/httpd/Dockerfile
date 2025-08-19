FROM alpine:3.21

COPY ./calculator /var/www/localhost/htdocs/calculator

RUN apk update && apk add --no-cache apache2

COPY ./httpd.conf /etc/apache2/httpd.conf

CMD [ "/usr/sbin/httpd", "-D", "FOREGROUND" ]
