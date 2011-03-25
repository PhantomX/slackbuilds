
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc-44.patch

set +e +o pipefail
