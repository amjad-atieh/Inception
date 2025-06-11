#!/bin/sh

envsubst < /my.cnf > /etc/my.cnf

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing database..."
  mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
  echo "Setting up database and users..."
  /usr/bin/mariadbd --user=mysql --bootstrap <<EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${MYSQL_NAME}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_NAME}\`.* TO '${MYSQL_USER}'@'%';
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_NAME}\`.* TO '${MYSQL_USER}'@'localhost';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
else
  echo "Database already initialized."
fi

exec "$@"