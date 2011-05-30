
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Revert this, this is only for linux > 2.6.40
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/0001-util-use-new-VT-ESC-sequence-to-clear-scrollback-buf.patch

set +e +o pipefail
