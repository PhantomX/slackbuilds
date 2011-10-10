
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhclient-script.PATH.diff

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-remove-bind.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-errwarn-message.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-options.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-release-by-ifup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-dhclient-decline-backoff.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-unicast-bootp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-dhclient-usage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-default-requested-options.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-xen-checksum.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-manpages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-CLOEXEC.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-inherit-leases.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-garbage-chars.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-missing-ipv6-not-fatal.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-add_timeout_when_NULL.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-64_bit_lease_parse.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-capability.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-logpid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-UseMulticast.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-sendDecline.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-retransmission.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-rfc3442-classless-static-routes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-honor-expired.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-noprefixavail.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-sharedlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-PPP.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-lpf-ib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-improved-xid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-gpxe-cid.patch

set +e +o pipefail
