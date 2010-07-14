
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dont-build-example.patch
# Remove unnecessary linkage to libQtGui
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dont-link-qtgui.patch

set +e +o pipefail
