
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Upstream dropped toolbar/icons size settings...
# So change here.
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/gtk+3-3.10.0-sizedefs.patch
### Debian
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/016_no_offscreen_widgets_grabbing.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/017_no_offscreen_device_grabbing.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/060_ignore-random-icons.patch

set +e +o pipefail
