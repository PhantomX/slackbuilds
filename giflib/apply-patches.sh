
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/giflib-4.1.6-gif2rle.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/giflib-4.1.6-giffix-null-Extension-fix.patch

set +e +o pipefail
