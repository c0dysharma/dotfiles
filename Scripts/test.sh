#!/bin/bash

if [[ $# -lt 2 ]]
then
    echo "USAGE: $0 interval batterylevel"
    echo 'interval- value in minutes before checking battery level'
    echo 'batterylevel- when reaches below hibernates'
    exit 1
fi
# commands to get current battery and charging status
_battery=$(ls /sys/class/power_supply/ | grep BAT)
_level="cat /sys/class/power_supply/${_battery}/capacity"
_status="cat /sys/class/power_supply/${_battery}/status"
_hibernate="i3exit hibernate"

# get required vals
INTERVAL=$1
BATTLEVEL=$2

# check current battery level and charging status at every INTERVAL
CURRENTBATTLEVEL=$(${_level})
CURRENTBATTSTATUS=$(${_status})

# hibernate only if current battery  level is <= BATTLEVEL and status != charging
while [[ CURRENTBATTLEVEL -gt BATTLEVEL || "$CURRENTBATTSTATUS" == "Charging" ]]
do
    sleep ${INTERVAL}s
    CURRENTBATTLEVEL=$(${_level})
    CURRENTBATTSTATUS=$(${_status})
    echo "$CURRENTBATTLEVEL $CURRENTBATTSTATUS"
done

Send notification and hibernate
notify-send 'Now Hibernating'
sleep 1s
_hibernate
