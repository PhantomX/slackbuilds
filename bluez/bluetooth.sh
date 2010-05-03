#!/bin/sh

# Check whether /etc/rc.d/rc.bluetooth is executable before starting
# the bluetooth subsystem for hotplugged bluetooth devices
[ -x /etc/rc.d/rc.bluetooth ] && exec /usr/sbin/bluetoothd --udev
exit 0

