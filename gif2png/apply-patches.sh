
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-overflow.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.4-libpng15.patch

set +e +o pipefail
