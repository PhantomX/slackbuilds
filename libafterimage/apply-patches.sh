
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${PNAME}-Makefile-ldconfig.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-afterimage-config.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-multiarch.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libpng15.patch

set +e +o pipefail
