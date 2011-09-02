
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.4-no_rpath.patch

# https://bugs.kde.org/213710
patch -p1 -E --backup -z .subtitles --verbose -i ${SB_PATCHDIR}/phonon-4.5.0-subtitles-files-phonon-xine.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.3.50-phonon-allow-stop-empty-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.5.0-fix-capture-devices.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.5.0-fix-device-categories.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.5.0-pulse-qpow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.5.0-fix-capture-categories.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.5.0-fix-capture-device-pulseaudio-order.patch

## Upstream patches

set +e +o pipefail
