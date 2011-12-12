
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Build patches
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-install-dir.patch
filterdiff -p2 -x browser/installer/package-manifest.in ${SB_PATCHDIR}/firefox-7.0-cache-build.patch \
 | patch -p2 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-5.0-asciidel.patch

# Upstream patches

# OpenSuse kde integration support
install -m 644 ${SB_PATCHDIR}/kde.js browser/app/profile/kde.js
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-cross-desktop.patch
sed -e '/BrowserApplication/s|mozilla-firefox|icecat|g' ${SB_PATCHDIR}/firefox-kde.patch \
  | patch -p1 -E --backup --verbose 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-browser-css.patch

set +e +o pipefail
