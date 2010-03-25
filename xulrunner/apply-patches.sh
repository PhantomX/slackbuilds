
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# build patches
zcat ${SB_PATCHDIR}/${NAME}-version.patch.gz | sed -e "s/__RPM_VERSION_INTERNAL__/${VERSION_INTERNAL}/" | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mozilla-build.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mozilla-jemalloc.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mozilla-about-firefox-version.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mozilla-jemalloc-526152.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/xulrunner-1.9.2.1-build.patch.gz | patch -p2 -E --backup --verbose
zcat ${SB_PATCHDIR}/mozilla-plugin.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mozilla-build-sbrk.patch.gz | patch -p2 -E --backup --verbose

# Fedora specific patches
zcat ${SB_PATCHDIR}/mozilla-192-pkgconfig.patch.gz | patch -p1 -E --backup --verbose

# Upstream patches
zcat ${SB_PATCHDIR}/mozilla-ps-pdf-simplify-operators.patch.gz | patch -p1 -E --backup --verbose

# From Arch
zcat ${SB_PATCHDIR}/fix-mozilla-launcher.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
