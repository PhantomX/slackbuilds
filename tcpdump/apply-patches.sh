
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.0.0-ipv6-build.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.0-icmp6msec.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.9.8-gethostby.patch

set +e +o pipefail
