
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-udev-path_id-export-path-for-platform-block-devices.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-tmpfiles-also-look-in-lib-tmpfiles.d-on-split-usr-sy.patch

set +e +o pipefail
