#!/bin/csh
if ( $?XDG_CONFIG_DIRS ) then
    setenv XDG_CONFIG_DIRS ${XDG_CONFIG_DIRS}:/etc/xfce/xdg
else
    setenv XDG_CONFIG_DIRS /etc/xdg:/etc/xfce/xdg
endif
