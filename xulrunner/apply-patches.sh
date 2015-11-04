
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# build patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xulrunner-install-dir.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-build.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-build-prbool.patch

# Fedora specific patches
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-193-pkgconfig.patch
# Unable to install addons from https pages
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/rhbz-966424.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/rhbz-1173156.patch

# Gentoo

# OpenSUSE
# http://www.rosenauer.org/hg/mozilla/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/toolkit-download-folder.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-nongnome-proxies.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-no-stdcxx-check.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-libproxy.patch

# Upstream patches

# OpenSuse kde integration support
if [ "${SB_KDE}" = "YES" ] ;then
  patch -p1 -E --backup -z .moz-kde --verbose -i ${SB_PATCHDIR}/mozilla-kde.patch
fi

set +e +o pipefail
