
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# in upstream patch tracker
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-lfs-autoconf.patch
# reported upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-exif-filecache.patch
# bz 632243, reported upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-sidecars-case.patch
#
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-vflist-refresh.patch
# bz 728802
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-exif-728802.patch
# nadvornik master tree
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-filedata-compare.patch
# upstream stable tree
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-copy-chown.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-ui_pathsel.patch
# add -Wl,--as-needed
# this touches both Makefile.in and Makefile.am as autoreconf is used
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-LDFLAGS.patch


set +e +o pipefail
