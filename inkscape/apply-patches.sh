
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.48.2-libwpg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.48.1-libpng15.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-poppler20.patch

set +e +o pipefail
