#!/bin/sh

mkdir -p /var/www/html/adminer

cp /adminer.php /var/www/html/adminer/index.php

exec "$@"
