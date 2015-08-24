
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.3-remove-WHEREAREMYFILES.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.3-dbus-failure.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.2.4-dbus-policy.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.3-DaemonClosing.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.3-unicode.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.3-sanitize.patch

### Arch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.3-urwid-1.3.0.patch

set +e +o pipefail
