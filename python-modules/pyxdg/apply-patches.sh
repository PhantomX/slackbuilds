
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/pyxdg-wine.patch
# Remove strxfrm, crashing with unicode strings
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pyxdg-remove-strxfrm.patch

set +e +o pipefail
