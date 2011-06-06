
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.3-dirtyfix.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup -z .gcc46 --verbose -i ${SB_PATCHDIR}/${NAME}-0.3-gcc46.patch

set +e +o pipefail
