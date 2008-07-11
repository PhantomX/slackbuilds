#!/bin/csh
# KDE additions:
if ( ! $?KDEDIR ) then
    setenv KDEDIR /usr
endif
if ( $?XDG_CONFIG_DIRS ) then
    setenv XDG_CONFIG_DIRS ${XDG_CONFIG_DIRS}:/etc/kde/xdg
else
    setenv XDG_CONFIG_DIRS /etc/xdg:/etc/kde/xdg
endif

#  When/if using prelinking, avoids (some) use of kdeinit
if ( -f /etc/prelinkopts.conf ) then
   set PRELINKING = `grep "^PRELINKING=" /etc/prelinkopts.conf | cut -d"=" -f2`
   if ( "$PRELINKING" == "yes" )  then
      if ( ! $?KDE_IS_PRELINKED ) setenv KDE_IS_PRELINKED 1
   endif
endif
