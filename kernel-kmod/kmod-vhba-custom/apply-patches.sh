
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/vhba-1.2.1-kernel-2.6.33.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/vhba-1.2.1-kernel-2.6.34.patch

set +e +o pipefail
