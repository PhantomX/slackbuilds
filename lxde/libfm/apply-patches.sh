
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/libfm-0.1.11-wrong-linkage.patch

set +e +o pipefail
