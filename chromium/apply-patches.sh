
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ppapi-r0.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gcc47.patch

set +e +o pipefail
