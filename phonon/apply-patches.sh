
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.7.0-rpath_use_link_path.patch 
# better upstream fix (pulled from master branch currently)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/import-relative-dir-resolution-workaround-from-CMake.patch

## upstream patches

set +e +o pipefail
