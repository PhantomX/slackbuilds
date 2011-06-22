
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# build patches
zcat ${SB_PATCHDIR}/${NAME}-version.patch.gz | sed -e "s/__RPM_VERSION_INTERNAL__/${GECKO_DIR_VER}/" | patch -p1 -E --backup --verbose
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-build.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-build-sbrk.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0-secondary-jit.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0-chromium-types.patch

# Fedora specific patches
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-193-pkgconfig.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-libjpeg-turbo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wmclass.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-crashreporter-static.patch

# Upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-4.0-moz-app-launcher.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-4.0-gnome3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xulrunner-2.0-network-link-service.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xulrunner-2.0-NetworkManager09.patch
patch -p1 -E --backup -z .omnijar --verbose -i ${SB_PATCHDIR}/${NAME}-5.0-omnijar.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xulrunner-system-bzip2.patch

# From Arch
zcat ${SB_PATCHDIR}/fix-mozilla-launcher.patch.gz | patch -p0 -E --backup --verbose

# OpenSuse kde integration support
install -m 644 ${SB_PATCHDIR}/kde.js browser/app/profile/kde.js
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-cross-desktop.patch
patch -p1 -E --backup -z .fx-kde --verbose -i ${SB_PATCHDIR}/firefox-kde.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-browser-css.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-nongnome-proxies.patch
patch -p1 -E --backup -z .moz-kde --verbose -i ${SB_PATCHDIR}/mozilla-kde.patch

set +e +o pipefail
