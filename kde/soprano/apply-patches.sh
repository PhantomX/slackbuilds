
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.3-missing-qdebug-header.patch

set +e +o pipefail
