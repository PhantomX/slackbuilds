  
SB_PATCHDIR=${CWD}/patches

# build patches
zcat ${SB_PATCHDIR}/mozilla-build.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-path.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-version.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/mozilla-sqlite.patch.gz | patch -p1 -E --backup --verbose || exit 1
autoconf-2.13 || exit 1
zcat ${SB_PATCHDIR}/mozilla-mochitest.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/mozilla-about-firefox-version.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fedora specific patches
zcat ${SB_PATCHDIR}/mozilla-pkgconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fix build with system hunspell (from gentoo)
zcat ${SB_PATCHDIR}/mozilla-system-hunspell-corrections.patch.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/090_unaligned.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/667_typeahead-broken-v4.patch.gz | patch -p0 -E --backup --verbose || exit 1

# From Arch
zcat ${SB_PATCHDIR}/fix-mozilla-launcher.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nsThreadUtils.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Upstream patches
zcat ${SB_PATCHDIR}/mozilla-ps-pdf-simplify-operators.patch.gz | patch -p1 -E --backup --verbose || exit 1
