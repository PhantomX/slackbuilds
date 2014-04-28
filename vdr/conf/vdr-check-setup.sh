#!/bin/sh

cfg=/etc/vdr/channels.conf
if [ ! -s $cfg ] ; then
    echo "$cfg is not valid, use \"scandvb -o vdr\" from the dvb-apps package to create one." >&2
    exit 2
else
    chown VDR_USER:VDR_GROUP $cfg && chmod 644 $cfg
fi
