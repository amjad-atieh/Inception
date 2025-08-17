#!/bin/sh

. /run/secrets/ftp_pass

adduser ${INTRA} << EOF
${FTP_PASS}
${FTP_PASS}
EOF

chown -R ${INTRA}:${INTRA} /var/www/html

exec "$@"
