
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

## Mandriva/upstreamable patches
zcat ${SB_PATCHDIR}/${NAME}-4.3.50-gstreamer-fix-seekable-query-failed.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.50-phonon-allow-stop-empty-source.patch.gz | patch -p1 -E --backup --verbose
# https://bugs.kde.org/213710
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-subtitles-files-phonon-xine.patch.gz | patch -p1 -E --backup -z subtitles --verbose

# Mandriva
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0102-pulse-Hopefully-solve-erronious-error-message-relati.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0103-pulse-Some-signal-emission-protection-and-some-debug.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0104-gstreamer-Rejig-the-PulseAudio-detection-and-handlin.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0105-gstreamer-Move-some-code-inside-pointer-protection.patch

## Upstream patches
#  phonon-backend-xine-4.4.1 (with pulseaudio) = no audio, http://bugs.kde.org/235193
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-kde235193.patch

set +e +o pipefail
