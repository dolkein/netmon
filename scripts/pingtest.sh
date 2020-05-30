#!/bin/sh
pingtest=$(ping -c1 google.com | grep '1 packets transmitted, 1 received')

if [ -n "$pingtest" ]; then
    echo $(date --iso-8601=seconds) ",Up" >>/etc/netmon/data/pingtest.csv
else
    echo $(date --iso-8601=seconds) ",Down" >>/etc/netmon/data/pingtest.csv
fi

