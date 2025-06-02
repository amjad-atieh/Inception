FROM alpine:3.21

COPY wordpress_data /var/www/html

RUN  apk update && apk add php84 php84-fpm php84-mysqli php84-json php84-session php84-xml php84-curl php84-gd php84-mbstring php84-zip mariadb mariadb-client && rm -rf /var/cache/apk/* && chown -R nobody:nobody /var/www/html && chmod -R 755 /var/www/html

COPY www.conf /etc/php84/php-fpm.d

CMD ["php-fpm84", "--nodaemonize"]
# CMD ["tail", "-f", "/dev/null"]


#php-fpm84

# apk add php84-mysqli php84-curl php84-gd php84-mbstring php84-xml php84-zip php84-opcache php84-pecl-imagick
