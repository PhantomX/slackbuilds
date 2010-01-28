#!/bin/sh
# Environment variables for the Qt package.
#
# It's best to use the generic directory to avoid
# compiling in a version-containing path:

if [ `uname -m` = "x86_64" ] ;then
  LIBDIRSUFFIX="64"
else
  LIBDIRSUFFIX=""
fi

if [ -d /usr/lib${LIBDIRSUFFIX}/qt3 ]; then
  QTDIR=/usr/lib${LIBDIRSUFFIX}/qt3
  QTINC=/usr/lib${LIBDIRSUFFIX}/qt3/include
  QTLIB=/usr/lib${LIBDIRSUFFIX}/qt3/lib
else
  # Find the newest Qt directory and set $QTDIR to that:
  for qtd in /usr/lib${LIBDIRSUFFIX}/qt3-* ; do
    if [ -d ${qtd} ]; then
      QTDIR="${qtd}"
      QTINC="${qtd}/include"
      QTLIB="${qtd}/lib${LIBDIRSUFFIX}"
    fi
  done
fi
export PATH="$PATH:${QTDIR}/bin"
export QTDIR QTINC QTLIB
export CPLUS_INCLUDE_PATH
