
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.1.rc4-prefix.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.1.rc4-libx11.patch

set +e +o pipefail
