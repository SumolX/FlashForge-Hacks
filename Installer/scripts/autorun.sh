#!/bin/sh

# Setup SSH
/bin/dropbear &

# Setup WebUI
cp -a /opt/services/www /tmp/
/bin/httpd -h /tmp/www
/opt/services/sbin/www-refresh.sh &

