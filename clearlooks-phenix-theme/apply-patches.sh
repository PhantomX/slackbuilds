
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix strange padding with gtk-3.0 theme.
patch -p0 -E --verbose -i ${SB_PATCHDIR}/${NAME}-padding.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-nautilus-bg-image.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-firefox-tooltip-transparency.patch

set +e +o pipefail
