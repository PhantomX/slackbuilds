
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/pulseaudio-4.99.4-systemd209.patch
#for patch in ${SB_PATCHDIR}/0*-*.patch ;do
  #patch -p1 -E --backup --verbose -i ${patch} || exit 1
#done

### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pulseaudio-4.0-kde_autostart_phase.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pulseaudio-x11_device_manager.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
