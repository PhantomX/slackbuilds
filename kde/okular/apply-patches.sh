
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# don't hardcode paths in OkularConfig.cmake
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdegraphics-4.5.80-OkularConfig-dont-hardcode-paths.patch

## upstream patches

set +e +o pipefail
