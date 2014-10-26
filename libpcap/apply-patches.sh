
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-man-tcpdump-and-tcpslice-have-manpages-in-man8.patch
patch -p1 -E --backup -z .multilib --verbose -i ${SB_PATCHDIR}/0002-pcap-config-mitigate-multilib-conflict.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-pcap-linux-apparently-ctc-interfaces-on-s390-has-eth.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-pcap-linux-don-t-use-TPACKETV3-for-memory-mmapped-ca.patch

set +e +o pipefail
