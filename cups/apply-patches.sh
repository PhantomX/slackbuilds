
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-no-gzip-man.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-multilib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-serial.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-banners-slk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-serverbin-compat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-no-export-ssllibs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-direct-usb.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-lpr-help.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-peercred.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-pid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-eggcups.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-getpass.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-driverd-timeout.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-strict-ppd-line-length.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-logrotate.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-usb-paperout.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-build.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-res_init.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-filter-debug.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-uri-compat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-cups-get-classes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-str3382.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-str3947.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-0755.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-snmp-quirks.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-hp-deviceid-oid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-dnssd-deviceid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-ricoh-deviceid-oid.patch
# Avahi support in the dnssd backend.
patch -p1 -E --backup --verbose -z .avahi -i ${SB_PATCHDIR}/cups-avahi-1-config.patch
patch -p1 -E --backup --verbose -z .avahi -i ${SB_PATCHDIR}/cups-avahi-2-backend.patch
patch -p1 -E --backup --verbose -z .avahi -i ${SB_PATCHDIR}/cups-avahi-3-timeouts.patch
patch -p1 -E --backup --verbose -z .avahi -i ${SB_PATCHDIR}/cups-avahi-4-poll.patch
patch -p1 -E --backup --verbose -z .avahi -i ${SB_PATCHDIR}/cups-avahi-5-services.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-icc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-systemd-socket.patch
# Avoid GIF reader loop (CVE-2011-2896, STR #3914, bug #727800).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-CVE-2011-2896.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-str3921.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-ps-command-filter.patch

## SECURITY PATCHES:

set +e +o pipefail
