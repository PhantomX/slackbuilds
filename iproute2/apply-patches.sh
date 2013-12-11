
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/man-pages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.4.0-kernel.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.4.0-sharepath.patch
zcat ${SB_PATCHDIR}/${NAME}-2.6.31-tc_modules.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.9.0-IPPROTO_IP_for_SA.patch
zcat ${SB_PATCHDIR}/${NAME}-example-cbq-service.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.35-print-route.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.39-create-peer-veth-without-a-name.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.12.0-lnstat-dump-to-stdout.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.10.0-rtnl_send.patch
# Rejected by upstream <http://thread.gmane.org/gmane.linux.network/284101>
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.11.0-tc-ok.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.11.0-rtt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.12.0-lnstat-interval.patch

set +e +o pipefail
