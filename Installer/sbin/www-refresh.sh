#!/bin/sh

while :
do
    # Refresh Menu Image
    cat /dev/fb0 > /tmp/www/menu.tmp
    [ -f "/tmp/www/menu.tmp" ] && sleep 0.5 || exit 1
    mv /tmp/www/menu.tmp /tmp/www/menu.fb
   
    # Update index.html 
    IPV4_ADDR="$(ip a | grep 'scope global' | awk '{print $2}' | cut -d'/' -f 1)"
    if [ ! -z "$IPV4_ADDR" ]; then
        if [ -z "$(cat /tmp/www/index.html | grep $IPV4_ADDR)" ]; then
            sed -i "s/REPLACE_IPV4_ADDRESS/$IPV4_ADDR/g" /tmp/www/index.html
        fi
    fi
done

