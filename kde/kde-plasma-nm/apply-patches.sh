
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/plasma-nm-openconnect.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/plasma-nm-item-text.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/plasma-nm-bluetooth-icon.patch

set +e +o pipefail
