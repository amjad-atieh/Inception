FROM alpine:3.21


RUN  apk update && apk add mariadb mariadb-client && rm -rf /var/cache/apk/*
	# && mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

COPY entrypoint.sh /entrypoint.sh 
COPY my.cnf /etc/my.cnf
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# RUN chmod +x /entrypoint.sh 	 && /entrypoint.sh
RUN chmod +x /entrypoint.sh 

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mariadbd-safe", "--datadir=/var/lib/mysql"]
# CMD ["/entrypoint.sh"]
# CMD ["/usr/bin/mariadbd", "--user=mysql", "--datadir=/var/lib/mysql"]
# CMD ["tail", "-f", "/dev/null"]

# mariadb -h mariadb -P 3306 -u root -p    
