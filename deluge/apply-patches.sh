
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fixes hangs when closing deluge (from Arch)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_freeze.patch

set +e +o pipefail
