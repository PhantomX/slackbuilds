
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gajim-0.13.3-gnome-keyring-CancelledError.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gajim-0.13.4-pygtk-crash-python2.7-workaround.patch

set +e +o pipefail
