FROM alpine:3.21

COPY startup.sh /startup.sh
COPY ./wordpress /var/www/html

RUN apk update && apk add php84 php84-fpm php84-mysqli php84-json php84-phar php84-ctype \
	php84-session php84-xml php84-curl php84-gd php84-mbstring php84-zip curl php84-dev \
	envsubst php84-redis && rm -rf /var/cache/apk/* && chown -R nobody:nobody /var/www/html \
	&& curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod -R 755 /var/www/html && chmod  +x /startup.sh /usr/local/bin/wp \
	&& ln -s /usr/bin/php84.phar /usr/local/bin/php.phar \
	&& ln -s /usr/bin/php84 /usr/local/bin/php

COPY www.conf /etc/php84/php-fpm.d/www.conf

ENTRYPOINT ["/startup.sh"]
CMD ["php-fpm84", "--nodaemonize"]
