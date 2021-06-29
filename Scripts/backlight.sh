#!/bin/bash

# Wrapper around xbacklight to check batteries doen't go below 1

# Usage info and command line argument verification
if [[ ${#} -lt 2 ]]
then
	echo "Usage ${0} OPTION VALUE"
	echo 'OPTION: -inc to increase brightness'
	echo 'OPTION: -dec to decrese brightness'
	echo 'VALUE: [1,100] step to increase or decrease'
	exit 1
fi

# Will use later on
OPTION=${1}
STEP=${2}
float=$(xbacklight -get)
CURRENT_BRIGHTNESS_LEVEL=${float%.*}
FINAL_VALUE=$(( ${CURRENT_BRIGHTNESS_LEVEL} - ${STEP} ))
# Check if step result in brighntess go below 0

# only when option is to decrease
if [[ ${OPTION} = '-inc' ]]
then 
 	xbacklight -inc ${STEP}
	exit 1
fi

#echo $FINAL_VALUE
if [[ ${FINAL_VALUE} -gt 0 ]]
then
	xbacklight -dec ${STEP}
	exit 0
fi

exit 1
