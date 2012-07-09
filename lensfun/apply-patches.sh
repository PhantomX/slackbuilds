
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstreamable patches
# add LIB_SUFFIX support (and not hardcode prefix/lib)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.6-cmake_LIB_SUFFIX.patch
# add pkgconfig support
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.6-cmake_pkgconfig.patch

set +e +o pipefail
