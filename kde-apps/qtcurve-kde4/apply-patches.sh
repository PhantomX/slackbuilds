
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#https://gitorious.org/chakra-packages/apps/blobs/master/qtcurve/fix-kwin_decoration-macro.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-kwin_decoration-macro.patch

set +e +o pipefail
