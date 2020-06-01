#!/bin/sh

crontab -l | grep -v '/etc/netmon/pingtest.sh' | crontab -
crontab -l | grep -v '/etc/netmon/speedtest.sh' | crontab -

sudo rm -rf /var/www/html/netmon
sudo rm -rf /etc/netmon

echo "netmon gone !"

