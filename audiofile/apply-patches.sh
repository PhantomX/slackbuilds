
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/audiofile-multilib.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
