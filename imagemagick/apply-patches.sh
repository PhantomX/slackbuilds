
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/ImageMagick-6.4.0-multilib.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
