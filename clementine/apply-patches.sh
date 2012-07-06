
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Use system sha2. Patch accepted by upstream
# http://code.google.com/p/clementine-player/issues/detail?id=2623
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-sha2.patch
# Desktop file fixes. Sent upstream
# http://code.google.com/p/clementine-player/issues/detail?id=2690
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-desktop.patch
# Fixes startup on a fresh install. From upstream trunk
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fresh-start.patch
# Fix a possible crash when an album cover search times out at the same time that
# it's cancelled or finishes normally.  Fixes RHBZ#797451
# http://code.google.com/p/clementine-player/issues/detail?id=2752
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-albumcoverfetch-crash.patch
# Upstream patch for libimobiledevice
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/imobiledevice.patch
# Compatibility patch with liblastfm1. Backported from upstream trunk
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-liblastfm1-compatibility.patch

set +e +o pipefail
