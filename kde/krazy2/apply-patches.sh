
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-prefix.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
