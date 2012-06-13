
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcpdump-4.0.0-portnumbers.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.0-icmp6msec.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.9.8-gethostby.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.1-eperm.patch

set +e +o pipefail
