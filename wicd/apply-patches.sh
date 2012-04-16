
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.0-remove-WHEREAREMYFILES.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.1-dbus-failure.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.1-DaemonClosing.patch

set +e +o pipefail
