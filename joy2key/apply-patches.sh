
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/button_list_segfault.patch

set +e +o pipefail
