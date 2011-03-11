
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# build patches
zcat ${SB_PATCHDIR}/${NAME}-version.patch.gz | sed -e "s/__RPM_VERSION_INTERNAL__/${GECKO_DIR_VER}/" | patch -p1 -E --backup --verbose
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-build.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-build-sbrk.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0-64bit-big-endian.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0-secondary-jit.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0-chromium-types.patch

# Fedora specific patches
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-193-pkgconfig.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-libjpeg-turbo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wmclass.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-crashreporter-static.patch

# Upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-omnijar.patch

# From Arch
zcat ${SB_PATCHDIR}/fix-mozilla-launcher.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
