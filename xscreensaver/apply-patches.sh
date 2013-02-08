
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --verbose --backup --suffix=.orig -i ${SB_PATCHDIR}/${NAME}.patch
# Allow xscreensaver to work setgid shadow.  I'd rather avoid requiring
# setuid root on this if at all possible...
zcat ${SB_PATCHDIR}/${NAME}.setuid.diff.gz | patch -p1 --verbose --backup --suffix=.orig

# Add support for the electricsheep distributed screensaver:
zcat ${SB_PATCHDIR}/${NAME}.electricsheep.diff.gz | patch -p1 --verbose --backup --suffix=.orig

# Patches from Fedora
# Change webcollage not to access to net
patch -p1 --verbose --backup --suffix=.orig -i ${SB_PATCHDIR}/${NAME}-5.16-webcollage-default-nonet.patch
# Remove "AC_PROG_CC' was expanded before it was required" warning
patch -p1 --verbose --backup --suffix=.orig -i ${SB_PATCHDIR}/${NAME}-5.11-conf264.patch
## Patches which must be discussed with upstream
# driver/test-passwd tty segfaults
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-5.12-test-passwd-segv-tty.patch
# patch to compile driver/test-xdpms
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-5.12-tests-miscfix.patch

set +e +o pipefail
