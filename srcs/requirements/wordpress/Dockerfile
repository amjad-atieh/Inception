FROM alpine:3.21

COPY startup.sh /startup.sh
COPY ./wordpress /var/www/html

RUN apk update && apk add php84 php84-fpm php84-mysqli php84-json \
	php84-session php84-xml php84-curl php84-gd php84-mbstring php84-zip \
	envsubst && rm -rf /var/cache/apk/* && chown -R nobody:nobody /var/www/html \
	&& chmod -R 755 /var/www/html && chmod  +x /startup.sh
	
COPY www.conf /etc/php84/php-fpm.d/www.conf

ENTRYPOINT ["/startup.sh"]
# CMD ["tail", "-f", "/dev/null"]
CMD ["php-fpm84", "--nodaemonize"]
