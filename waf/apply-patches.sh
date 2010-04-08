
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/waf-1.5.15-libdir.patch

set +e +o pipefail
