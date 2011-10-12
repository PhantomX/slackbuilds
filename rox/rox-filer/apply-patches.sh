
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/rox-2.6.1-nostrip.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
