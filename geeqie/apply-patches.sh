
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

set +e +o pipefail
