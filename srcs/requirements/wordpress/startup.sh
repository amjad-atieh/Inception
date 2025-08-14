#!/bin/sh
WP_ROOT="/var/www/html"
PHP_BIN="/usr/bin/php84"

. /run/secrets/db_pass
. /run/secrets/wp_user_pass
. /run/secrets/wp_admin_pass

export DB_PASSWORD=$DB_PASSWORD

envsubst < $WP_ROOT/wp-config-sample.php > $WP_ROOT/wp-config.php

export DB_PASSWORD=""

sed -i "s/ = 'wp_';/\$table_prefix = 'wp_';/" $WP_ROOT/wp-config.php

host=$DB_NAME
port=$DB_PORT

echo "Waiting for WordPress to be installed/ready..."
timeout=120
start_time=$(date +%s)

until nc -z "$DB_NAME" "$port" >/dev/null 2>&1; do
  current_time=$(date +%s)
  elapsed=$((current_time - start_time))
  if [ "$elapsed" -ge "$timeout" ]; then
    echo "Error: Database not available after $timeout seconds."
    exit 1
  fi
  echo "Database host '$host' not yet available on port '$port'. Waiting 1 second..."
  sleep 1
done
echo "Database is up and running!"



wp core install --path=$WP_ROOT --url=$WP_SITEURL --title=inception --admin_user=$WP_ADMIN_USER --admin_email=$WP_ADMIN_EMAIL --admin_password=$WP_ADMIN_PASS

wp user create $WP_USER $INTRA@student.42amman.com  --path=$WP_ROOT --role=author --user_pass=$WP_USER_PASS

wp plugin install redis-cache --path=$WP_ROOT

wp plugin activate redis-cache --path=$WP_ROOT

wp redis enable --path=$WP_ROOT

exec "$@"
