#!/bin/sh
# Environment variables for the Qt package.
#
# It's best to use the generic directory to avoid
# compiling in a version-containing path:
if [ -d /usr/lib/qt3 ]; then
  QTDIR=/usr/lib/qt3
  QTINC=/usr/lib/qt3/include
  QTLIB=/usr/lib/qt3/lib
else
  # Find the newest Qt directory and set $QTDIR to that:
  for qtd in /usr/lib/qt3-* ; do
    if [ -d ${qtd} ]; then
      QTDIR="${qtd}"
      QTINC="${qtd}/include"
      QTLIB="${qtd}/lib"
    fi
  done
fi
if [ ! "${CPLUS_INCLUDE_PATH}" = "" ]; then
  CPLUS_INCLUDE_PATH=${QTDIR}/include:${CPLUS_INCLUDE_PATH}
else
  CPLUS_INCLUDE_PATH=${QTDIR}/include
fi
export PATH="$PATH:${QTDIR}/bin"
export QTDIR QTINC QTLIB
export CPLUS_INCLUDE_PATH
