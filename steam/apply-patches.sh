
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/steam-launcher.patch

### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/alsa_sdl_audiodriver.patch

set +e +o pipefail
