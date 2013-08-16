#!/bin/sh
#
# Google Earth startup script
# Modified for Slackware by Ken Zalewski
#

GE_ARCH=$(uname -m)
case ${GE_ARCH} in
  x86_64 | ia64 | s390 )
    GOOGLEEARTH_LIB_DIR="/usr/lib64"
    SECONDARY_LIB_DIR="/usr/lib"
    ;;
  * )
    GOOGLEEARTH_LIB_DIR="/usr/lib"
    SECONDARY_LIB_DIR="/usr/lib64"
    ;;
esac

if [ ! -x ${GOOGLEEARTH_LIB_DIR}/googleearth/googleearth-bin ]; then
  if [ ! -x ${SECONDARY_LIB_DIR}/googleearth/googleearth-bin ]; then
    echo "Error: ${GOOGLEEARTH_LIB_DIR}/googleearth/googleearth-bin not found"
    if [ -d ${SECONDARY_LIB_DIR} ]; then
      echo "       ${SECONDARY_LIB_DIR}/googleearth/googleearth-bin not found"
    fi
    exit 1
  fi
  GOOGLEEARTH_LIB_DIR="${SECONDARY_LIB_DIR}"
fi

LD_LIBRARY_PATH=.:${GOOGLEEARTH_LIB_DIR}:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH
export LC_NUMERIC=en_US.UTF-8

# Let's boogie!
if [ -x "${GOOGLEEARTH_LIB_DIR}/googleearth/googleearth-bin" ]
then
  cd "${GOOGLEEARTH_LIB_DIR}/googleearth"
  exec "./googleearth-bin" $*
fi
echo "Couldn't run Google Earth (googleearth-bin). Is GOOGLEEARTH_LIB_DIR set?"
exit 1

# end of googleearth ...

