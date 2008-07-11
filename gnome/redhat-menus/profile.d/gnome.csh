#!/bin/csh
# GNOME additions:
if ( $?GNOME_XDG_CONFIG_DIRS ) then
    setenv XDG_CONFIG_DIRS $GNOME_XDG_CONFIG_DIRS:/etc/gnome/xdg
else
    setenv XDG_CONFIG_DIRS /etc/xdg:/etc/gnome/xdg
endif
