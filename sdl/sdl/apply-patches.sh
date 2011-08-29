
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/SDL-1.2.14-byteorder.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/SDL-1.2.12-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/SDL-1.2.12-disable_yasm.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/SDL-1.2.14-audiodriver.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.14-xio_error-rh603984.patch
# From upstream <http://bugzilla.libsdl.org/show_bug.cgi?id=894>, rh556608
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.14-x11_grab_down_button.patch
# Newer Linux has bigger structure for joystick, in upstream, sdl900, rh624241
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.14-linux_2.6_joystick.patch
# Do not call memcpy() on overlapping areas, in upstream, sdl1090, rh669844
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.14-SDL_BlitCopyOverlap_memcpy.patch
# nasm-2.09 aliased elf to elf32, in upstream, sdl1152, rh678818
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.14-nasm-2.09-compat.patch
# Submitted to upstream as sdl1155, rh480065
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.10-GrabNotViewable.patch

if [ "${SB_ALSA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/SDL-1.2.14-default-alsa.patch.gz | patch -p0 -E --backup --verbose
fi

set +e +o pipefail
