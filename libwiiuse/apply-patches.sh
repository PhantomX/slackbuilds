
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wiiuse_zero_addr_012.patch

set +e +o pipefail
