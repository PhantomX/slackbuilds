
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhclient-script.PATH.diff

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-errwarn-message.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-options.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-release-by-ifup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-dhclient-decline-backoff.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-unicast-bootp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-dhclient-usage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-default-requested-options.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-xen-checksum.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-manpages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-CLOEXEC.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-inherit-leases.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-garbage-chars.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-invalid-dhclient-conf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-missing-ipv6-not-fatal.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-IFNAMSIZ.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-add_timeout_when_NULL.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-64_bit_lease_parse.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-capability.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-logpid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-UseMulticast.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-sendDecline.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-retransmission.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-initialization-delay.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-rfc3442-classless-static-routes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-PIE-RELRO.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-honor-expired.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-noprefixavail.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp420-rh637017.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp420-sharedlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-PPP.patch

set +e +o pipefail
