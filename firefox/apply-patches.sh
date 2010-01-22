  
SB_PATCHDIR=${CWD}/patches

# Upstream patches
zcat ${SB_PATCHDIR}/firefox-version.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/firefox-version.patch.gz | sed \
  -e "s/__RPM_VERSION_INTERNAL__/${VERSION_INTERNAL}/" | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/mozilla-jemalloc-526152.patch.gz | patch -p1 -E --backup --verbose || exit 1
