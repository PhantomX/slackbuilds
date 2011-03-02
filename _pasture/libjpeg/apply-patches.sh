
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/jpeg-c++.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libjpeg-buf-oflo.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
