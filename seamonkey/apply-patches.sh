  
SB_PATCHDIR=${CWD}/patches

# Upstream patches
zcat ${SB_PATCHDIR}/mozilla-191-path.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/mozilla-jemalloc.patch.gz | patch -p0 -E --backup --verbose || exit 1
