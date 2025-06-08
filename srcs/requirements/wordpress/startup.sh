#!/bin/sh

envsubst < /var/www/html/wp-config-sample.php > /var/www/html/wp-config.php

sed -i "s/ = 'wp_';/\$table_prefix = 'wp_';/" /var/www/html/wp-config.php

exec "$@"