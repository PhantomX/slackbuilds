
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/1.6-makefile-cflags.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
