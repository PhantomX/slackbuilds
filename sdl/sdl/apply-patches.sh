
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
zcat ${SB_PATCHDIR}/SDL-1.2.12-multilib.patch.gz | patch -p1 -E --backup --verbose
# Submitted to upstream as sdl1155, rh480065
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.10-GrabNotViewable.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sdl-1.2.14-fix-mouse-clicking.patch
# Proposed to upstream as sdl1680, rh891973
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.15-x11-Bypass-SetGammaRamp-when-changing-gamma.patch
# Proposded to upstream as sdl1769
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.15-const_XData32.patch
# Upstream fix for sdl1486, rh990677
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.15-ignore_insane_joystick_axis.patch
# Do not use backing store by default, sdl2383, rh1073057, rejected by
# upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.15-no-default-backing-store.patch

### Debian
# http://bugzilla.libsdl.org/show_bug.cgi?id=1460
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_joystick_misc_axes.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_window_resizing.diff

if [ "${SB_ALSA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/SDL-1.2.14-default-alsa.patch.gz | patch -p0 -E --backup --verbose
fi

set +e +o pipefail
