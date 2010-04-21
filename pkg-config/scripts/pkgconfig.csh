#!/bin/csh
if ( $?PKG_CONFIG_PATH ) then
    setenv PKG_CONFIG_PATH ${PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig
else
    setenv PKG_CONFIG_PATH /usr/local/lib/pkgconfig:/usr/lib/pkgconfig
endif
