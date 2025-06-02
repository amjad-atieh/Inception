#!/bin/sh
set -e

# Start MariaDB in bootstrap mode to run setup
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing database..."
  mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

  echo "Setting up root user..."
  /usr/bin/mariadbd --user=mysql --bootstrap <<EOF
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE user='root';
CREATE USER 'root'@'%' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
else
  echo "Database already initialized."
fi

# Start actual MariaDB server
# exec mariadbd-safe --datadir=/var/lib/mysql
# exec /usr/bin/mariadbd --user=mysql --datadir=/var/lib/mysql

exec "$@"