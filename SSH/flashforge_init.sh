#!/bin/sh
set -x

WORK_DIR=`dirname $0`
echo "" > $WORK_DIR/log.txt

cp $WORK_DIR/bin/* /bin/
cp $WORK_DIR/scripts/services.sh /opt/

ln -sfn /bin/dropbearmulti /bin/dropbear
ln -sfn /bin/dropbearmulti /bin/scp
ln -sfn /bin/dropbearmulti /bin/ssh
ln -sfn /bin/dropbearmulti /bin/dropbearkey

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
    echo "/opt/services.sh &" >> /opt/auto_run.sh
    echo "Added services to auto_run.sh" >> $WORK_DIR/log.txt
fi
sync

$WORK_DIR/scripts/rootpasswd.sh
echo "Updated root password" >> $WORK_DIR/log.txt
sync

$WORK_DIR/play
exit 0
