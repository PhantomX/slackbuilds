
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
[ "${SB_SYSTEMD}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Use-systemd-to-start-usbmuxd.patch

set +e +o pipefail
