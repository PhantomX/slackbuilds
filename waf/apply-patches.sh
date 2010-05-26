
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/waf-1.5.17-libdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/waf-1.5.17-install_3rdparty.patch

set +e +o pipefail
