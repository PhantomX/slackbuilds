
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhclient-script.PATH.diff

patch -p1 -i ${LSRCDIR}/dhcp-${VERSION}-ldap.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-errwarn-message.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-options.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-release-by-ifup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-dhclient-decline-backoff.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-unicast-bootp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-failover-ports.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-dhclient-usage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-default-requested-options.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-xen-checksum.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-dhclient-anycast.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-manpages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-CLOEXEC.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-inherit-leases.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-garbage-chars.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-invalid-dhclient-conf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-missing-ipv6-not-fatal.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-IFNAMSIZ.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-add_timeout_when_NULL.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-64_bit_lease_parse.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-capability.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-logpid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-UseMulticast.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-sendDecline.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.1.1-retransmission.patch

set +e +o pipefail
