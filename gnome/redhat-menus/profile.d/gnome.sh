#!/bin/sh
# GNOME additions:
if [ ! "${GNOME_XDG_CONFIG_DIRS}" = "" ]; then
  GNOME_XDG_CONFIG_DIRS=/etc/gnome/xdg:${GNOME_XDG_CONFIG_DIRS}
else
  GNOME_XDG_CONFIG_DIRS=/etc/gnome/xdg:/etc/xdg
fi
export GNOME_XDG_CONFIG_DIRS
