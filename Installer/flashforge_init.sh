#!/bin/sh
set -x

WORK_DIR=`dirname $0`
echo "" > $WORK_DIR/log.txt

# Notify User we have STARTED!!!!!
cat $WORK_DIR/start.img > /dev/fb0

# Create and Copy Resources
mkdir -p /opt/services/bin
mkdir -p /opt/services/sbin
mkdir -p /opt/services/www
cp -a $WORK_DIR/bin/* /opt/services/bin/
cp -a $WORK_DIR/sbin/* /opt/services/sbin/
cp -a $WORK_DIR/www/* /opt/services/www/
cp -a $WORK_DIR/scripts/autorun.sh /opt/services/autorun.sh

# Update executable permissions
chmod +x /opt/services/bin/*
chmod +x /opt/services/sbin/*
chmod +x /opt/services/autorun.sh

# Generate SymLinks
ln -sfn /opt/services/bin/dropbearmulti /bin/dropbear
ln -sfn /opt/services/bin/dropbearmulti /bin/scp
ln -sfn /opt/services/bin/dropbearmulti /bin/ssh
ln -sfn /opt/services/bin/dropbearmulti /bin/dropbearkey
ln -sfn /opt/services/bin/busybox /bin/httpd
ln -sfn /opt/services/bin/busybox /bin/nc

echo "Services installed" >> $WORK_DIR/log.txt
sync

# Generate host key once if it does not exist.
if [ ! -e /etc/dropbear/dropbear_rsa_host_key ]; then
    mkdir -p /etc/dropbear
    /bin/dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
    echo "Generated dropbear rsa host key" >> $WORK_DIR/log.txt
fi
sync

if [ ! $(grep services /opt/auto_run.sh) ]; then
    echo "/opt/services/autorun.sh &" >> /opt/auto_run.sh
    echo "Added services to auto_run.sh" >> $WORK_DIR/log.txt
fi
sync

$WORK_DIR/scripts/rootpasswd.sh
echo "Updated root password" >> $WORK_DIR/log.txt
sync

# Notify User we have FINISHED!!
cat $WORK_DIR/end.img > /dev/fb0
$WORK_DIR/play
exit 0
