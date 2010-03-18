#!/bin/sh
#
# Google Chrome startup script
#

GC_LIB=$(uname -m)
case ${GC_LIB} in
  x86_64 | ia64 | s390 )
   GC_LIB_DIR="/usr/lib64"
   SECONDARY_LIB_DIR="/usr/lib"
   ;;
  * )
    GC_LIB_DIR="/usr/lib"
    SECONDARY_LIB_DIR="/usr/lib64"
    ;;
esac

if [ ! -x ${GC_LIB_DIR}/google-chrome/chrome ]; then
  if [ ! -x ${SECONDARY_LIB_DIR}/google-chrome/chrome ]; then
  echo "Error: ${GC_LIB_DIR}/google-chrome/chrome not found"
  if [ -d ${SECONDARY_LIB_DIR} ]; then
    echo "       ${SECONDARY_LIB_DIR}/google-chrome/chrome not found"
  fi
  exit 1
  fi
  GC_LIB_DIR="${SECONDARY_LIB_DIR}"
fi

LD_LIBRARY_PATH=${GC_LIB_DIR}/google-chrome:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

if [ -x "${GC_LIB_DIR}/google-chrome/chrome" ]
then
  exec "${GC_LIB_DIR}/google-chrome/chrome" "$@"
fi
echo "Couldn't run Google Chrome (chrome). Is GC_LIB_DIR set?"
exit 1
