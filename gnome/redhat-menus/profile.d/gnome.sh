#!/bin/sh
# GNOME additions:
if [ ! "${GNOME_XDG_CONFIG_DIRS}" = "" ]; then
  GNOME_XDG_CONFIG_DIRS=${GNOME_XDG_CONFIG_DIRS}:/etc/gnome/xdg
else
  GNOME_XDG_CONFIG_DIRS=/etc/xdg:/etc/gnome/xdg
fi
export GNOME_XDG_CONFIG_DIRS
