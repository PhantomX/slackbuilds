
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-make-3.82-compatibility-r0.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-yuv-crash-r1.patch

set +e +o pipefail
