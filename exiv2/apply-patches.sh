
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.25-cmake_LIB_SUFFIX.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.24-cmake_mandir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.24-doxygen_config.patch

set +e +o pipefail
