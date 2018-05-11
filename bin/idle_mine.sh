#!/bin/bash

IDLE_TRIGGER_MIN=10
IDLE_TRIGGER=$(($IDLE_TRIGGER_MIN * 60 * 1000))
IDLE_TIME=$(DISPLAY=:0 xprintidle)

miner_running=$(ps aux | grep "[R]ig1")
if [ "${#miner_running}" -eq 0 ]; then
    IS_MINER_RUNNING=false
else
    IS_MINER_RUNNING=true
fi

if [ $IDLE_TIME -ge $IDLE_TRIGGER ]; then
    if ! $IS_MINER_RUNNING; then
        echo "No miner for gpu1 running. Beginning to run." >> ~/miner_gpu1.log
        nohup ethminer --farm-recheck 1000 -U -S us2.ethermine.org:4444 -FS us1.ethermine.org:4444 -O 0xB8360a09F959A091dd6387a4B05424791981C35F.Rig1 --report-hashrate --cuda-devices 1 &> ~/miner_gpu1.log &
    fi
else
    if $IS_MINER_RUNNING; then
        echo "No longer idle. Killing miner" >> ~/miner_gpu1.log
        kill $(echo $miner_running | awk '{print $2}')
    fi
fi
