
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# remove set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE) line
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.3-no-rpath.patch

set +e +o pipefail
