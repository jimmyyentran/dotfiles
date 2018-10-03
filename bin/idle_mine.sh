#!/bin/bash

IDLE_TRIGGER_MIN=10
IDLE_TRIGGER=$(($IDLE_TRIGGER_MIN * 60 * 1000))
IDLE_TIME=$(DISPLAY=:0 xprintidle)
IDLE_MAX=999999

re='^[0-9]+$'
if ! [[ $IDLE_TIME =~ $re  ]] ; then
    echo "No display detected, using max"
    IDLE_TIME=$IDLE_MAX
fi

# miner_running=$(ps aux | grep "[R]ig1")
miner_running=$(ps aux | grep "[d]evices 1")
if [ "${#miner_running}" -eq 0 ]; then
    IS_MINER_RUNNING=false
else
    IS_MINER_RUNNING=true
fi

if [ $IDLE_TIME -ge $IDLE_TRIGGER ]; then
    if ! $IS_MINER_RUNNING; then
        echo "No miner for gpu1 running. Beginning to run." >> ~/miner_gpu1.log
        # nohup ethminer --farm-recheck 1000 -U -S us2.ethermine.org:4444 -FS us1.ethermine.org:4444 -O 0xB8360a09F959A091dd6387a4B05424791981C35F.Rig1 --report-hashrate --cuda-devices 1 &>> ~/miner_gpu1.log &
        # nohup ccminer -a phi -o stratum+tcp://futurecoins.club:6667 -u Lgf6Ann8RHDfpZfGeiKCNm1R9TStiGuKEi -p c=LUX --devices 1 -i 25 &>> ~/miner_gpu1.log &
        nohup ~/Workspace/ccminer_2.3/ccminer -a phi2 -o stratum+tcp://bpool.io:8332 -u Lgf6Ann8RHDfpZfGeiKCNm1R9TStiGuKEi -p c=LUX --devices 1 --pstate 0 --intensity 19 &>> ~/miner_gpu1.log &
    fi
else
    if $IS_MINER_RUNNING; then
        echo "No longer idle. Killing miner" >> ~/miner_gpu1.log
        kill $(echo $miner_running | awk '{print $2}')
    fi
fi
