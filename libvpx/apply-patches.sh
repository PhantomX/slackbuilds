
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libvpx-0.9.0-no-explicit-dep-on-static-lib.patch

set +e +o pipefail
