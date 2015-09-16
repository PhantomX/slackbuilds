
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# try to ensure kmix autostart is after pulseaudio
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kmix-4.11.97-autostart.patch

## upstream patches

set +e +o pipefail
