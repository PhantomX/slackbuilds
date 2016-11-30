
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-preferences-chinfo.patch

# Build patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-install-dir.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-build.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-build-prbool.patch

# Unable to install addons from https pages
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/rhbz-966424.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-enable-addons.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/rhbz-1173156.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-35.0-flash-click-to-play.patch

if [ "${SB_UA}" = "YES" ] ;then
  sed \
    -e "s|FIREFOX_SLK_LENGTH|${SLKLENGHT}|g" \
    -e "s|FIREFOX_SLK_DIST|${SLKDIST}|g" \
    ${SB_PATCHDIR}/firefox-chinfo-ua.patch | patch -p2 -E --backup --verbose
fi

#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rhbz-1291190-appchooser-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-1170092.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-1005640-accept-lang.patch

### OpenSUSE
# http://www.rosenauer.org/hg/mozilla/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-branded-icons.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/toolkit-download-folder.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-nongnome-proxies.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-no-stdcxx-check.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-libproxy.patch

# Upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-1253216.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-1196777.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-256180.patch

# Debian patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-440908.patch

# OpenSuse kde integration support
if [ "${SB_KDE}" = "YES" ] ;then
  patch -p1 -E --backup -z .fx-kde --verbose -i ${SB_PATCHDIR}/mozilla-kde.patch
  patch -p1 -E --backup -z .fx-kde --verbose -i ${SB_PATCHDIR}/firefox-kde.patch
fi

set +e +o pipefail
