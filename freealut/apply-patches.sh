
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-openal.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/freealut-multiarch.patch

set +e +o pipefail
