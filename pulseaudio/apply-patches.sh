
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#for patch in ${SB_PATCHDIR}/0*-*.patch ;do
  #patch -p1 -E --backup --verbose -i ${patch} || exit 1
#done
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pulseaudio-activation.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-alsa-support-fixed-latency-range-in-alsa-modules.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-alsa-fixed-latency-range-handling-for-udev-detect.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-alsa-fixed_latency_range-modarg-for-module-alsa-card.patch

set +e +o pipefail
