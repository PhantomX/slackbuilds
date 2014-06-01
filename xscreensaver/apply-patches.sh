
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
patch -p1 --verbose --backup --suffix=.orig -i ${SB_PATCHDIR}/${NAME}-5.26-webcollage-default-nonet.patch
## Patches which must be discussed with upstream
# driver/test-passwd tty segfaults
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-5.12-test-passwd-segv-tty.patch
# patch to compile driver/test-xdpms
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-5.12-tests-miscfix.patch
# Fix test-passwd compilation for lock.c change
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-5.27-1001-test-passwd-add-skeleten-definition-for-reset_watchd.patch
# Patch for hacks under hacks/ using pthread
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-5.27-0001-hacks-Makefile.in-add-thread-related-flags-correctly.patch
# c89 compilation for delauary
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-5.27-0002-delaunay-don-t-use-double-backslash-comments.patch
# desktop file installation
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-5.27-0003-driver-Makefile.in-readd-INTLTOOL_DESKTOP_RULE.patch
# Recent intltool needs this
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-5.27-0004-po-Makefile.in.in-add-comments-after-POTFILES-line.patch
# Remove GLib deprecation warning
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-5.27-0005-Remove-GLib-deprecated-warnings.patch
# Remove clang -Winvalid-source-encoding warning
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-5.27-0006-Remove-clang-Winvalid-source-encoding-warning.patch

set +e +o pipefail
