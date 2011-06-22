
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Build patches
sed \
  -e "s/__RPM_VERSION_INTERNAL__/${FF_DIR_VER}/" \
  ${SB_PATCHDIR}/firefox-version.patch | patch -p1 -E --backup --verbose

patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-stub.patch
# http://rpms.famillecollet.com/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox5-disable-broken-cache-gen.patch

# Upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-4.0-moz-app-launcher.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-4.0-gnome3.patch
patch -p1 -E --backup -z .omnijar --verbose -i ${SB_PATCHDIR}/xulrunner-5.0-omnijar.patch

# OpenSuse kde integration support
install -m 644 ${SB_PATCHDIR}/kde.js browser/app/profile/kde.js
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-cross-desktop.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-kde.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-browser-css.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-nongnome-proxies.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-kde.patch

set +e +o pipefail
