#!/bin/bash

function help_and_exit {
    if [ -n "$1" ]; then
        echo "${1}"
    fi
    cat <<-EOF
    Usage: brtns [-u|-d] [value] [-i] [value]

       -u   - change brightness up by x increments
       -d   - change brightness down by x increments
       -i   - number of increments (default 10)
       -h   - display this help message
EOF
    if [ -n "${1}" ]; then
        exit 1
    fi
    exit 0
}

steps=10
if [ "$2" = "-i" ]; then
    re='^[0-9]+$'
    if ! [[ "$3" =~ $re ]] || [ "$3" = "0" ]; then
    help_and_exit "Error: $3 is not a positive integer"
    fi
    steps="$3"
fi


cur_brightness=$(</sys/class/backlight/intel_backlight/brightness)
max_brightness=$(</sys/class/backlight/intel_backlight/max_brightness)

if [ -n "$1" ]; then
    if [ "$1" = "-h" ]; then
        help_and_exit
    elif [ "$1" = "-u" ]; then
        new_brightness=$(($cur_brightness+($max_brightness/$steps)))
    elif [ "$1" = "-d" ]; then
        new_brightness=$(($cur_brightness-($max_brightness/$steps)))
    else
        help_and_exit "Error: unknown argument: $1"
    fi
fi

if [ $new_brightness -gt $max_brightness ]; then
    new_brightness=$max_brightness
elif [ $new_brightness -lt 0 ]; then
    new_brightness=0
fi


echo $new_brightness/$max_brightness
echo $new_brightness > /sys/class/backlight/intel_backlight/brightness