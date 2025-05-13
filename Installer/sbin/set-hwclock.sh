#!/bin/sh

while :
do
    DATE="$(nc time.nist.gov 13 | awk '{print $2,$3}' | grep -v "^ *$" | (read t; date "+%Y-%m-%d %H:%M:%S" -s "20$t"))"
    case $DATE in
        20*)
            exit 0
            ;;
        *)
            sleep 1
            ;;
    esac
done

