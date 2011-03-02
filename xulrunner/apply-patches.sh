
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# build patches
zcat ${SB_PATCHDIR}/${NAME}-version.patch.gz | sed -e "s/__RPM_VERSION_INTERNAL__/${VERSION_INTERNAL}/" | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mozilla-build.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mozilla-jemalloc.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mozilla-about-firefox-version.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/xulrunner-1.9.2.1-build.patch.gz | patch -p2 -E --backup --verbose
zcat ${SB_PATCHDIR}/mozilla-build-sbrk.patch.gz | patch -p2 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-gdk-pixbuf.patch

# Fedora specific patches
zcat ${SB_PATCHDIR}/mozilla-192-pkgconfig.patch.gz | patch -p1 -E --backup --verbose
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-libjpeg-turbo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-crashreporter-static.patch

# Upstream patches

# From Arch
zcat ${SB_PATCHDIR}/fix-mozilla-launcher.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/enable-x86_64-tracemonkey.patch

set +e +o pipefail
