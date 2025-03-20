#!/bin/sh

while :
do
    # Refresh Menu Image
    /bin/fbgrab -z 0 -d /dev/fb0 /tmp/www/menu.tmp > /dev/null 2>&1
    [ -f "/tmp/www/menu.tmp" ] && sleep 1 || exit 1
    mv /tmp/www/menu.tmp /tmp/www/menu.png
   
    # Update index.html 
    IPV4_ADDR="$(ip a | grep 'scope global' | awk '{print $2}' | cut -d'/' -f 1)"
    if [ ! -z "$IPV4_ADDR" ]; then
        if [ -z "$(cat /tmp/www/index.html | grep $IPV4_ADDR)" ]; then
            sed -i "s/REPLACE_IPV4_ADDRESS/$IPV4_ADDR/g" /tmp/www/index.html
        fi
    fi
done

