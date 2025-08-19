FROM alpine:3.21

COPY ./adminer.php /var/www/adminer/adminer.php

RUN apk update && apk add --no-cache php84 php84-fpm php84-curl php84-cli \
    php84-gd php84-mysqli php84-session

COPY www.conf /etc/php84/php-fpm.d/www.conf

CMD ["php-fpm84", "--nodaemonize"]
