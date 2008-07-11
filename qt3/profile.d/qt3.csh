#!/bin/csh
# Environment path variables for the Qt package:
if ( ! $?QTDIR ) then
    # It's best to use the generic directory to avoid
    # compiling in a version-containing path:
    if ( -d /usr/lib/qt3 ) then
        setenv QTDIR /usr/lib/qt3
        setenv QTINC /usr/lib/qt3/include
        setenv QTLIB /usr/lib/qt3/lib
    else
        # Find the newest Qt directory and set $QTDIR to that:
        foreach qtd ( /usr/lib/qt3-* )
            if ( -d $qtd ) then
                setenv QTDIR $qtd
                setenv QTINC $qtd/include
                setenv QTLIB $qtd/lib
            endif
        end
    endif
endif
set path = ( $path $QTDIR/bin )
if ( $?CPLUS_INCLUDE_PATH ) then
    setenv CPLUS_INCLUDE_PATH $QTDIR/include:$CPLUS_INCLUDE_PATH
else
    setenv CPLUS_INCLUDE_PATH $QTDIR/include
endif
