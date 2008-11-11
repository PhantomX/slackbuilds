#!/bin/sh

SYSFS=/sys
NAME=$1
NUM=$2

for i in "${SYSFS}${DEVPATH}/${NAME}.*/specifier_id"; do
    if [ ! -f "$i" ]; then
        continue
    fi
    SPECID="`cat $i`"
    if [ $((SPECID)) -eq $((0x00609e)) ]; then
        echo -n "sbp2-${NUM} "
    elif [ $((SPECID)) -eq $((0x00a02d)) ]; then
        SWVER="`cat ${i%/specifier_id}/version`"
        if [ $((SWVER)) -ge $((0x100)) -a $((SWVER)) -lt $((0x110)) ]; then
            echo -n "iidc${NUM} "
        elif [ $((SWVER)) -eq $((0x10001)) ]; then
            echo -n "avc${NUM} "
        elif [ $((SWVER)) -ge $((0x14000)) -a $((SWVER)) -le $((0x14001)) ]; then
            echo -n "vendorfw${NUM} "
        fi
    fi
done
echo
