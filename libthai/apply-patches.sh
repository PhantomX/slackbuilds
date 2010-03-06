
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libthai-0.1.9-doxygen-segfault.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libthai-0.1.9-multilib.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
