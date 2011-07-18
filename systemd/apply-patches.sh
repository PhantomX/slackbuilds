
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Revert this, this is only for linux > 3.0
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Revert-use-new-VT-ESC-sequence-to-clear-scroll.patch

set +e +o pipefail
