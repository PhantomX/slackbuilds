
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.15.2b-abxtest-tempfile.patch.gz | patch -p0 -E --backup --verbose
zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --verbose
patch -p1 -i debian/patches/00_ucs4.diff
zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --verbose

set +e +o pipefail
