#!/bin/csh
# Environment path variables for the Qt package:

if ( "`uname -m`" =~ "x86_64" ) then
   setenv LIBDIRSUFFIX 64
else
   unset LIBDIRSUFFIX
endif


if ( ! $?QTDIR ) then
    # It's best to use the generic directory to avoid
    # compiling in a version-containing path:
    if ( -d /usr/lib${LIBDIRSUFFIX}/qt3 ) then
        setenv QTDIR /usr/lib${LIBDIRSUFFIX}/qt3
        setenv QTINC /usr/lib${LIBDIRSUFFIX}/qt3/include
        setenv QTLIB /usr/lib${LIBDIRSUFFIX}/qt3/lib
    else
        # Find the newest Qt directory and set $QTDIR to that:
        foreach qtd ( /usr/lib${LIBDIRSUFFIX}/qt3-* )
            if ( -d $qtd ) then
                setenv QTDIR $qtd
                setenv QTINC $qtd/include
                setenv QTLIB $qtd/lib${LIBDIRSUFFIX}
            endif
        end
    endif
endif
set path = ( $path $QTDIR/bin )
unset LIBDIRSUFFIX
