#!/bin/csh
# GNOME additions:
if ( $?GNOME_XDG_CONFIG_DIRS ) then
    setenv XDG_CONFIG_DIRS /etc/gnome/xdg:$GNOME_XDG_CONFIG_DIRS
else
    setenv XDG_CONFIG_DIRS /etc/gnome/xdg:/etc/xdg
endif
