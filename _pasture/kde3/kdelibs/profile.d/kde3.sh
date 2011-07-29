#!/bin/sh
# KDE additions:
KDEDIR=/usr
export KDEDIR

## When/if using prelinking, avoids (some) use of kdeinit
if [ -f /etc/default/prelink ]; then
  if grep -qs '^PRELINKING=yes' /etc/default/prelink ; then
    [ -z "${KDE_IS_PRELINKED}" ] && KDE_IS_PRELINKED=1 && export KDE_IS_PRELINKED
  fi
fi
