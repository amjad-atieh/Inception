FROM alpine:3.21

COPY startup.sh /startup.sh
COPY my.cnf /etc/my.cnf

RUN  apk update && apk add mariadb mariadb-client && rm -rf /var/cache/apk/* \
	&& chmod  +x /startup.sh
	
ENTRYPOINT ["/startup.sh"]
CMD ["mariadbd", "--user=mysql", "--datadir=/var/lib/mysql"]
