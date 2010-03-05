
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

if [ "${SB_PA}" = "YES" ] ;then
  # Make PulseAudio the default when listed by the Xine backend and native
  #zcat ${SB_PATCHDIR}/${NAME}-4.3.80-pulseaudio-device-priorities.patch.gz | patch -p1 -E --backup --verbose
  # bump PulseAudio's priority in the xine backend
  #zcat ${SB_PATCHDIR}/${NAME}-4.3.50-xine_pulseaudio.patch.gz | patch -p1 -E --backup --verbose
  true
fi

## Mandriva/upstreamable patches
zcat ${SB_PATCHDIR}/${NAME}-4.3.50-fix-decodebin-usage.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.50-gstreamer-fix-seekable-query-failed.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.50-phonon-allow-stop-empty-source.patch.gz | patch -p1 -E --backup --verbose
# https://bugs.kde.org/213710
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-subtitles-files-phonon-xine.patch.gz | patch -p1 -E --backup -z subtitles --verbose

set +e +o pipefail
