#!/bin/csh
# Set Pango behavior

if ( ! $?MOZ_DISABLE_PANGO ) then
    setenv MOZ_DISABLE_PANGO 0
endif
