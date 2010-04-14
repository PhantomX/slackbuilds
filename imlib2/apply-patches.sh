
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.3.0-multilib.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
