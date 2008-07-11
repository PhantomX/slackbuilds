#!/bin/sh
# KDE additions:
KDEDIR=/usr
export KDEDIR
if [ ! "${XDG_CONFIG_DIRS}" = "" ]; then
  XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS}:/etc/kde/xdg
else
  XDG_CONFIG_DIRS=/etc/xdg:/etc/kde/xdg
fi
export XDG_CONFIG_DIRS

## When/if using prelinking, avoids (some) use of kdeinit
if [ -f /etc/prelinkopts.conf ]; then
  if [ $(grep '^PRELINKING=yes' /etc/prelinkopts.conf) ] ; then
    [ -z "$KDE_IS_PRELINKED" ] && KDE_IS_PRELINKED=1 && export KDE_IS_PRELINKED
  fi
fi
