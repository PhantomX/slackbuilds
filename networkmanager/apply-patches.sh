
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nm-polkit-permissive.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nss-error.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/02-dbus_access_network_manager.patch

# https://bugzilla.gnome.org/show_bug.cgi?id=387832
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.2.0-pre-sleep.patch

set +e +o pipefail
