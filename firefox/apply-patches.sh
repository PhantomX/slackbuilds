
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://www.linuxquestions.org/questions/linux-from-scratch-13/blfs-xulrunner-firefox-21-0-and-search-4175462532/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-search-box.patch

# Build patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-install-dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-5.0-asciidel.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-15.0-enable-addons.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-duckduckgo.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/toolkit-download-folder.patch

# Upstream patches

# OpenSuse kde integration support
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-browser-css.patch
if [ "${SB_KDE}" = "YES" ] ;then
  patch -p1 -E --backup -z .fx-kde --verbose -i ${SB_PATCHDIR}/mozilla-kde.patch
  patch -p1 -E --backup -z .fx-kde --verbose -i ${SB_PATCHDIR}/firefox-kde.patch
fi

set +e +o pipefail
