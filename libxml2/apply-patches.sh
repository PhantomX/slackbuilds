
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libxml2-multilib.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libxml2-2.9.0-do-not-check-crc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libxml2-2.9.2-catalog-revert.patch

set +e +o pipefail
