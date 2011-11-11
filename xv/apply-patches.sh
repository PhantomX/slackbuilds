
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Apply 20070520 jumbo enhancement patch
patch -p1 -i ${JUMBO_PATCH}

# Fix compiler options, install directories; enable JPEG 2000 support
zcat ${SB_PATCHDIR}/xv-jumbo-20070520-makefile.patch.gz | patch -p1 -E --backup --verbose
# Interim jumbo patch update
patch -p1 -E --backup --verbose -i ${CWD}/${PSRCARCHIVE2}
# Clean up code
zcat ${SB_PATCHDIR}/xv-3.10a-cleanup.patch.gz | patch -p1 -E --backup --verbose
# Add FLmask feature
zcat ${SB_PATCHDIR}/xv-FLmask.v2.1.patch.gz | patch -p1 -E --backup --verbose

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/xv-3.10a-libpng15.patch

set +e +o pipefail
