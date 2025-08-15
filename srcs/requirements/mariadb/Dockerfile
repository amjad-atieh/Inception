FROM alpine:3.21

COPY startup.sh /startup.sh
COPY my.cnf /my.cnf

RUN  apk update && apk add --no-cache mariadb envsubst mariadb-client \
	&& chmod  +x /startup.sh
	
ENTRYPOINT ["/startup.sh"]
CMD ["mariadbd", "--user=mariadb", "--datadir=/var/lib/mariadb"]
