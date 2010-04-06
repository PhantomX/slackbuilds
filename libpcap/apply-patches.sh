
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# From Gentoo
zcat ${SB_PATCHDIR}/${NAME}-1.0.0-cross-linux.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libpcap-multilib.patch
zcat ${SB_PATCHDIR}/${NAME}-man.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.8.3-ppp.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
