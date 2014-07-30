
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/amp-0.7.6-gcc43.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
