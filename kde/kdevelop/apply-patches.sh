
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# remove set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE) line
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.81-no-rpath.patch
# Include unistd.h (gcc 4.7 issue)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.81-include-unistd-h.patch

set +e +o pipefail
