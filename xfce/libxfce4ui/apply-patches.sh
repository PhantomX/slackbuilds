
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# add more keyboard shortcuts to make multimedia keyboards work out of the box (Fedora)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libxfce4ui-4.10.0-keyboard-shortcuts.patch

set +e +o pipefail
