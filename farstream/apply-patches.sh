
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/farstream-prefer-vp8.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Gtk-doc-tags-belong-after-the-description.patch

set +e +o pipefail
