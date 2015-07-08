#!/bin/sh
# Starts the CDEmu daemon instance on D-Bus *session* bus. Optional
# configuration (number of devices, audio driver, log file) are read
# from ~/.cdemu-daemon

# Default settings
unset NUM_DEVICES AUDIO_DRIVER LOG_FILE
[ -e /etc/default/cdemu-daemon ] && . /etc/default/cdemu-daemon
[ -e ~/.cdemu-daemon ] && . ~/.cdemu-daemon
NUM_DEVICES=${NUM_DEVICES:-2}
AUDIO_DRIVER=${AUDIO_DRIVER:-pulse}
LOG_FILE=${LOG_FILE:-~/.cdemu-daemon.log}

# Start the daemon
exec /usr/bin/cdemu-daemon --ctl-device=/dev/vhba_ctl --bus=session --num-devices=${NUM_DEVICES} --audio-driver=${AUDIO_DRIVER} --logfile=${LOG_FILE}
