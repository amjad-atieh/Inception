#!/bin/sh

envsubst < /my.cnf > /etc/my.cnf

. /run/secrets/db_pass
. /run/secrets/db_root_pass

if [ ! -d "/var/lib/mariadb/mariadb" ]; then
  echo "Initializing database..."
  /usr/bin/mariadb-install-db --user=root --basedir=/usr --datadir=/var/lib/mariadb
  echo "Setting up database and users..."
  /usr/bin/mariadbd --user=root --bootstrap <<EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'localhost';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
else
  echo "Database already initialized."
fi

exec "$@"