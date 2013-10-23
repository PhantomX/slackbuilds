#!/bin/sh
#
# Chromium startup script
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

if [ ! -x ${GC_LIB_DIR}/chromium-browser/chrome ]; then
  if [ ! -x ${SECONDARY_LIB_DIR}/chromium-browser/chrome ]; then
  echo "Error: ${GC_LIB_DIR}/chromium-browser/chrome not found"
  if [ -d ${SECONDARY_LIB_DIR} ]; then
    echo "       ${SECONDARY_LIB_DIR}/chromium-browser/chrome not found"
  fi
  exit 1
  fi
  GC_LIB_DIR="${SECONDARY_LIB_DIR}"
fi

# Allow the user to override command-line flags, bug gentoo#357629.
# This is based on Debian's chromium-browser package, and is intended
# to be consistent with Debian.
for f in /etc/chromium/*; do
  [[ -f ${f} ]] && source "${f}"
done

for f in "${HOME}"/.config/chromium/user/*; do
  [[ -f ${f} ]] && source "${f}"
done

# Prefer user defined CHROMIUM_USER_FLAGS (from env) over system
# default CHROMIUM_FLAGS (from /etc/chromium/default).
CHROMIUM_FLAGS=${CHROMIUM_USER_FLAGS:-"${CHROMIUM_FLAGS}"}

# Set the .desktop file name
export CHROME_DESKTOP="chromium-browser.desktop"

LD_LIBRARY_PATH=${GC_LIB_DIR}/chromium-browser:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

if [ -x "${GC_LIB_DIR}/chromium-browser/chrome" ]
then
  exec "${GC_LIB_DIR}/chromium-browser/chrome" "${CHROMIUM_FLAGS}" "$@"
fi
echo "Couldn't run Chromium (chrome). Is GC_LIB_DIR set?"
exit 1
