  
SB_PATCHDIR=${CWD}/patches

# build patches
zcat ${SB_PATCHDIR}/mozilla-build.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-path.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-version.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/mozilla-sqlite.patch.gz | patch -p1 -E --backup --verbose || exit 1
autoconf-2.13 || exit 1
zcat ${SB_PATCHDIR}/mozilla-mochitest.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fedora specific patches
zcat ${SB_PATCHDIR}/mozilla-pkgconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Upstream patches
zcat ${SB_PATCHDIR}/mozilla-ps-pdf-simplify-operators.patch.gz | patch -p1 -E --backup --verbose || exit 1
