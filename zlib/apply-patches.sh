
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zlib-1.2.5-minizip-fixuncrypt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zlib-1.2.7-optimized-s390.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zlib-1.2.7-z-block-flush.patch

set +e +o pipefail
