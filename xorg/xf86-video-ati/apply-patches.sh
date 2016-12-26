
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-dri-removal.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/radeon-6.12.2-lvds-default-modes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-default-modes.patch

set +e +o pipefail
