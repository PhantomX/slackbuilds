
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fix slow progress bar on cards that do not implement server-side gradients
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/01_fix_slowness.patch

set +e +o pipefail
