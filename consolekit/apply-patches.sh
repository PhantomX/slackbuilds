
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/nodaemon.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/reorder-initialization.patch.gz | patch -p1 -E --backup --verbose || exit 1

set +e +o pipefail
