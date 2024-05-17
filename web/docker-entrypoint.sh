#!/bin/bash
#
#

source /etc/apache2/envvars
echo "$APACHE_RUN_DIR"
exec "$@"
