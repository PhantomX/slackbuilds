
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhclient-script.PATH.diff

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-remove-bind.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-P1-remove-dst.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-errwarn-message.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-dhclient-options.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-release-by-ifup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-dhclient-decline-backoff.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-unicast-bootp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-default-requested-options.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-xen-checksum.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-manpages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-CLOEXEC.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-garbage-chars.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-add_timeout_when_NULL.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-64_bit_lease_parse.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-capability.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-logpid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-UseMulticast.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-sendDecline.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.1-retransmission.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-rfc3442-classless-static-routes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.0-honor-expired.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-sharedlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-PPP.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-paranoia.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-lpf-ib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-improved-xid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.2-gpxe-cid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.3-dhclient-decline-onetry.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.3-P2-log_perror.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-getifaddrs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-omapi-leak.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-rfc5970-dhcpv6-options-for-network-boot.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-failOverPeer.patch 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-P1-interval.patch 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-P2-conflex-do-forward-updates.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.4-P2-dupl-key.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-range6.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-4.2.5-next-server.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-bindtodevice-inet6.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dhcp-no-subnet-error2info.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
