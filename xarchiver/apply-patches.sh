
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## From Fedora
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.2-no-donators-menu.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.2-default-archive-format.patch
# add_xz_support.patch by Robby Workman taken from
# http://slackbuilds.org/slackbuilds/13.1/system/xarchiver/xarchiver-0.5.2-add_xz_support.patch
# sent upstream through
# https://sourceforge.net/tracker/?func=detail&aid=2847624&group_id=140153&atid=745600
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.2-add_xz_support.patch
# rpm2cpio.patch by Daniel Hokka Zakrisson
# taken from https://bugzilla.redhat.com/show_bug.cgi?id=577480
# sent upstream through
# https://sourceforge.net/tracker/?func=detail&aid=3310768&group_id=140153&atid=745602
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.2-rpm2cpio.patch
# segfault-open-with.patch by Bastiaan Jacques
# taken from https://bugzilla.redhat.com/show_bug.cgi?id=690012
# sent upstream through
# https://sourceforge.net/tracker/?func=detail&aid=3310778&group_id=140153&atid=745600
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.2-segfault-open-with.patch
# fix-7z-support.patch by taken from
# https://sourceforge.net/tracker/?func=detail&aid=3137589&group_id=140153&atid=745602
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.2-fix_7z_support.patch

set +e +o pipefail
