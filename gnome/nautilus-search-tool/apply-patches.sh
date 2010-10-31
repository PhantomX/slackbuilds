
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.2-headers.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-no-eels.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
