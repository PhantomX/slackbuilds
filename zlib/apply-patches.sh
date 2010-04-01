
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup -z.auto --verbose -i ${SB_PATCHDIR}/zlib-1.2.4-autotools.patch
mkdir contrib/minizip/m4
cp minigzip.c contrib/minizip

set +e +o pipefail
