
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/use_libtool-2.7.16.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gsoap-2.7-openssl.patch

set +e +o pipefail
