#!/bin/csh
# KDE additions:
if ( ! $?KDEDIR ) then
    setenv KDEDIR /usr
endif

#  When/if using prelinking, avoids (some) use of kdeinit
if ( -f /etc/default/prelink ) then
   set PRELINKING = `grep "^PRELINKING=" /etc/default/prelink | cut -d"=" -f2`
   if ( "$PRELINKING" == "yes" )  then
      if ( ! $?KDE_IS_PRELINKED ) setenv KDE_IS_PRELINKED 1
   endif
endif
