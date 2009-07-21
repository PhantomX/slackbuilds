  
SB_PATCHDIR=${CWD}/patches

# build patches
zcat ${SB_PATCHDIR}/${NAME}-version.patch.gz | sed -e "s/__RPM_VERSION_INTERNAL__/${VERSION_INTERNAL}/" | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/mozilla-build.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/mozilla-191-path.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/mozilla-jemalloc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/mozilla-about-firefox-version.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fedora specific patches
zcat ${SB_PATCHDIR}/mozilla-191-pkgconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Upstream patches
zcat ${SB_PATCHDIR}/mozilla-ps-pdf-simplify-operators.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/067-force-bundled-ply.patch.gz | patch -p1 -E --backup --verbose || exit 1

# From Arch
zcat ${SB_PATCHDIR}/fix-mozilla-launcher.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nsThreadUtils.patch.gz | patch -p1 -E --backup --verbose || exit 1
