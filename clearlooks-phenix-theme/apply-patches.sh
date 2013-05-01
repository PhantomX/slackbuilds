
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix strange padding with gtk-3.0 theme.
patch -p0 -E --verbose -i ${SB_PATCHDIR}/${NAME}-padding.patch

set +e +o pipefail
