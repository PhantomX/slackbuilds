
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nm-polkit-permissive.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nss-error.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/initialize-GError.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dont-fight-over-ipv6.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nm-dbus-fix-modem-interface-permissions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nm-dbus-remove-max_replies_per_connection-limit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/02-dbus_access_network_manager.patch

# https://bugzilla.gnome.org/show_bug.cgi?id=387832
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.2.0-pre-sleep.patch
# Fix quote handling for global data (Bug #410821)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.4.0-fix-quote-handling.patch
# Fix uninitialized variables in libnm-glib
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.4.0-libnm-glib-ensure_inited.patch
# Fix building against linux-headers-3.4, #417055
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.4.0-ip_ppp.h.patch

set +e +o pipefail
