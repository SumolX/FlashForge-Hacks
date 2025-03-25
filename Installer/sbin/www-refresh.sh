#!/bin/sh

while :
do
    # Refresh Menu Image
    cat /dev/fb0 > /tmp/www/menu.tmp
    [ -f "/tmp/www/menu.tmp" ] && sleep 0.5 || exit 1
    mv /tmp/www/menu.tmp /tmp/www/menu.fb
done
