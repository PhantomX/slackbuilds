
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.1-rangecheck.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6-libpng-1.5.patch

set +e +o pipefail
