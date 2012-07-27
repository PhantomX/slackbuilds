
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# libgphoto2-2.5 support patch from
# https://bugs.kde.org/show_bug.cgi?id=303427
patch -p1 -E --backup --verbose -d core -i ${SB_PATCHDIR}/${NAME}-2.7.0-libgphoto2_25.patch

## upstreamable patches

## upstream patches

set +e +o pipefail
