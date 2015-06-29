
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# default to xdg picturesPath instead of hard-coded ~/Images
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.3-xdg_picturesPath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.1-gcc5.patch

set +e +o pipefail
