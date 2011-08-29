
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-3.45-gcc-4.3.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
