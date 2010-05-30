
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.9.8-pkgconfig.patch
zcat ${SB_PATCHDIR}/${NAME}-1.9.8-gcc44.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.9.7-system-zlib.patch.gz | patch -p0 -E --backup --verbose
rm -rf src/lib/zlib

set +e +o pipefail
