
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .droproot --verbose -i ${SB_PATCHDIR}/tcpdump-4.2.0-droproot.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcpdump-4.0.0-portnumbers.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.0-icmp6msec.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.9.8-gethostby.patch

set +e +o pipefail
