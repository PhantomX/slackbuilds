#!/bin/sh
if [ ! "$XDG_CONFIG_DIRS" = "" ]; then
  XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:/etc/xfce/xdg
else
  XDG_CONFIG_DIRS=/etc/xdg:/etc/xfce/xdg
fi
export XDG_CONFIG_DIRS
