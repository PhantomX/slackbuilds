
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/psemu-gpupeopsmesagl-1.78-gcc44.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
