#!/bin/bash

if [[ $# -lt 1 ]]
then
    echo "USAGE: $0 batterylevel"
    echo 'batterylevel- when reaches below hibernates'
    exit 1
fi
# commands to get current battery and charging status
_battery=$(ls /sys/class/power_supply/ | grep BAT)
_level="cat /sys/class/power_supply/${_battery}/capacity"
_status="cat /sys/class/power_supply/${_battery}/status"
_hibernate="systemctl hibernate"

# get required vals
BATTLEVEL=$1

# check current battery level 
CURRENTBATTLEVEL=$(${_level})
CURRENTBATTSTATUS=$(${_status})

# hibernate only if current battery  level is <= BATTLEVEL and status != charging
while [[ CURRENTBATTLEVEL -le BATTLEVEL &&  "$CURRENTBATTSTATUS" == "Discharging" ]]
do
    #Send notification and hibernate
    notify-send 'Now Hibernating'
    sleep 2s
    $_hibernate
done


