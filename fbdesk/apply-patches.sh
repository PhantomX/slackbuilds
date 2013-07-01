
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/10-gcc4.3-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/20-include-header-cassert.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/40-option-v.patch
zcat ${SB_PATCHDIR}/${NAME}-1.4.1-png14.patch.gz | patch -p0 -E --backup --verbose 
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.1-libpng15.patch

set +e +o pipefail
