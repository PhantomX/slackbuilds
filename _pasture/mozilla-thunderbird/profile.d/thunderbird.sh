#!/bin/sh
# Set Pango behavior:

if [ "${MOZ_DISABLE_PANGO}" = "" ]; then
  MOZ_DISABLE_PANGO=0
fi
export MOZ_DISABLE_PANGO
