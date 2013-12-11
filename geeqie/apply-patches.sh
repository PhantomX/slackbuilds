
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# add -Wl,--as-needed
# this touches both Makefile.in and Makefile.am as autoreconf is used
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-LDFLAGS.patch
# from master branch to fix regression
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.1-bar_keywords.c.diff
# in upstream bug tracker
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-fix-fullscreen.patch
# bz 889897
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-double_generic_dialog_close.patch
# from master
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.1-editors-NULL.patch
# reported upstream
# https://sourceforge.net/tracker/?func=detail&atid=1054680&aid=3602709&group_id=222125
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.1-filedata-change-notification.patch
# reported upstream
# https://sourceforge.net/tracker/?func=detail&aid=3603866&group_id=222125&atid=1054680
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.1-filedata-avoid-history-abort.patch
# reported upstream
# https://sourceforge.net/tracker/?func=detail&aid=3605406&group_id=222125&atid=1054682
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.1-large-files.patch
# LCMS2 patch from Geeqie-devel mailing-list
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.1-lcms2.patch

set +e +o pipefail
