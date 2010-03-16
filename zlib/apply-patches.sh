
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/zlib-1.2.3-autotools.patch.gz | patch -p1 -E --backup -z.auto --verbose
mkdir m4
zcat ${SB_PATCHDIR}/minizip-1.2.3-malloc.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
