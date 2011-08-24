#!/bin/bash

RED="\\#FF0000\\"
GREEN="\\#00FF00\\"
YELLOW="\\#DFAF8F\\"
GRAY="\\#CCCCCC\\"
WHITE="\\#BEBEBE\\"
DEFAULT="\\#888888\\"

UPDATES=/tmp/.updates

if [ -r $UPDATES ] ; then
    OPT="$(cat $UPDATES)"
    if [ "$OPT" ] ; then
        NB=$(echo "$OPT" | wc -l)
        declare -i LINE=$RANDOM%$NB+1
        OPT=$(echo "$OPT" | sed -n $LINE"p")
        OPT="$WHITE[$RED$OPT ($NB)$WHITE]"
    fi
else
    OPT="${YELLOW}No info about updates "
fi

TKBPS=0
RKBPS=0
for i in wlan0 eth0; do
    R1=`cat /sys/class/net/$i/statistics/rx_bytes`
    T1=`cat /sys/class/net/$i/statistics/tx_bytes`
    sleep 1
    R2=`cat /sys/class/net/$i/statistics/rx_bytes`
    T2=`cat /sys/class/net/$i/statistics/tx_bytes`
    TKBPS=$(echo $T2 $T1 $TKBPS | awk '{print $1 - $2 + $3}')
    RKBPS=$(echo $R2 $R1 $RKBPS | awk '{print $1 - $2 + $3}')
done
TKBPS=$(echo $TKBPS | awk '{printf "%d", $1 / 1024}')
RKBPS=$(echo $RKBPS | awk '{printf "%d", $1 / 1024}')
NETWORK="$YELLOW$RKBPS$WHITE : $YELLOW$TKBPS$WHITE KiB/s"
WIFI=$(wicd-cli --wireless -d | sort | egrep "^(Quality:|Bit Rates:)" | cut -d: -f2- | tr -d "\n")
[ "$WIFI" ] && OPT="$OPT WiFi:$WIFI% "

LOAD=$(cat /proc/loadavg | awk '{printf "%d", $1*100/2}') # /2 cause I've 2 cores
REM=$(awk '/remaining capacity/ { print $3 }' /proc/acpi/battery/BAT0/state)
LAST=$(awk '/last full/ { print $4 }' /proc/acpi/battery/BAT0/info)
BATTERY=$(echo $REM $LAST | awk '{printf "%d", ($1/$2)*100}')
[ $BATTERY -ge 90 ] && BATTERY="${GREEN}${BATTERY}"
[ $BATTERY -le 5 ] && BATTERY="${RED}${BATTERY}"
MEM=$(free | grep buffers/cache | awk '{printf "%d", $4/1024}')
VOLUME=$(amixer get Master | sed -n 's|.*\[\([0-9]*\)\%.*|\1%|pg' | head -1)
DATE=$(date +'%a %d @%l:%M:%S')

wmfs -s 0 "${OPT}${WHITE}[Net: $NETWORK | Load: ${YELLOW}${LOAD} ${WHITE}% | \
Bat:$YELLOW $BATTERY ${WHITE}% | Mem: $YELLOW $MEM ${WHITE}MiB free | \
Vol:$YELLOW ${VOLUME}${WHITE} | ${YELLOW}${DATE}${WHITE}]"

