
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.1.22-ldflags.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
