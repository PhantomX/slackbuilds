
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-udev-systemd-udev-settle.service-fix-After.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-vconsole-setup-enable-utf-8-mode-explicitly.patch

set +e +o pipefail
