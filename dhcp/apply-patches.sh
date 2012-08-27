
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhclient-script.PATH.diff

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-remove-bind.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-P1-remove-dst.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-errwarn-message.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-options.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-release-by-ifup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-dhclient-decline-backoff.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-unicast-bootp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-dhclient-usage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-default-requested-options.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-xen-checksum.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-manpages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-CLOEXEC.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-garbage-chars.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-missing-ipv6-not-fatal.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-add_timeout_when_NULL.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-64_bit_lease_parse.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-capability.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-logpid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-UseMulticast.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-sendDecline.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-retransmission.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-rfc3442-classless-static-routes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-honor-expired.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-sharedlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-PPP.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.3-paranoia.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-lpf-ib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-improved-xid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-gpxe-cid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.3-dhclient-decline-onetry.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.3-P2-log_perror.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-getifaddrs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-send_release.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.3-P2-rfc5970-dhcpv6-options-for-network-boot.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-failOverPeer.patch 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-P1-dhclient6-leases_semicolon_expected.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-P1-interval.patch 

set +e +o pipefail
