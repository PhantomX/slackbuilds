#!/bin/sh
# Starts the CDEmu daemon instance on D-Bus *system* bus. Optional
# configuration (number of devices, audio driver, log file) are read
# from /etc/default/cdemu-daemon

# Default settings
unset NUM_DEVICES SYS_AUDIO_DRIVER SYS_LOG_FILE
[ -e /etc/default/cdemu-daemon ] && . /etc/default/cdemu-daemon
NUM_DEVICES=${NUM_DEVICES:-2}
SYS_AUDIO_DRIVER=${SYS_AUDIO_DRIVER:-null}
SYS_LOG_FILE=${SYS_LOG_FILE:-/tmp/cdemu-daemon.log}

# Start the daemon
/usr/sbin/cdemud --ctl-device=/dev/vhba_ctl --bus=system --num-devices=${NUM_DEVICES} --audio-driver=${SYS_AUDIO_DRIVER} --logfile=${SYS_LOG_FILE}
