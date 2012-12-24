
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fpc-2.6.2rc1-r22920.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fpcdocs-2.6.2rc1-r954.patch

set +e +o pipefail
