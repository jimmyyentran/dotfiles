#!/bin/bash

SELFSPY_COUNT="$(ps aux | grep '[/]usr/bin/selfspy' | wc -l)"
if [ $((SELFSPY_COUNT)) -le 1 ]; then
    ./notify.sh "Selfspy Down" "Restart the service"
    mail -s "Selfspy Down" jimmyytran@gmail.com <<< "Restart the service"
fi
