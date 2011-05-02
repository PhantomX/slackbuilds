
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://bugs.gentoo.org/show_bug.cgi?id=359735
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/libdc1394-videodev.h.patch

set +e +o pipefail
