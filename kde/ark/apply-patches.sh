
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# libkerfuffle namelink_skip
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ark-4.7.80-namelink_skip.patch

set +e +o pipefail
