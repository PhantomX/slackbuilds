
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Revert this, this is only for linux > 3.0
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/0001-util-use-new-VT-ESC-sequence-to-clear-scrollback-buf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-systemctl-fix-double-unref-of-a-dbus-message.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-cryptsetup-generator-fix-etc-cryptsetup-options.patch

set +e +o pipefail
