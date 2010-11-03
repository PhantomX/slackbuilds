
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libtiger-0.3.3-check.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
