#!/bin/sh

# Update Clock
/opt/services/sbin/set-hwclock.sh &

# Setup SSH
/bin/dropbear &

# Install WebUI Resources
cp -a /opt/services/www /tmp/

# Start WebUI Services
/bin/httpd -h /tmp/www
/opt/services/sbin/www-refresh.sh &

