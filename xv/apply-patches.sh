  
SB_PATCHDIR=${CWD}/patches

# Apply 20070520 jumbo enhancement patch
patch -p1 -i ${JUMBO_PATCH} || exit 1

# Fix compiler options, install directories; enable JPEG 2000 support
zcat ${SB_PATCHDIR}/xv-jumbo-20070520-makefile.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Interim jumbo patch update
patch -p1 -E --backup --verbose -i ${CWD}/${PSRCARCHIVE2} || exit 1
# Clean up code
zcat ${SB_PATCHDIR}/xv-3.10a-cleanup.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Add FLmask feature
zcat ${SB_PATCHDIR}/xv-FLmask.v2.1.patch.gz | patch -p1 -E --backup --verbose || exit 1
