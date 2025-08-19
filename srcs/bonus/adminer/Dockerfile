FROM alpine:3.21

COPY ./adminer.php /adminer.php

COPY ./entrypoint.sh /entrypoint.sh

RUN apk update && apk add --no-cache php84 php84-fpm php84-curl php84-cli php84-gd && chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["php-fpm84", "--nodaemonize"]
