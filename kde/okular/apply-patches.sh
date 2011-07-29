
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# don't hardcode paths in OkularConfig.cmake
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdegraphics-4.5.80-OkularConfig-dont-hardcode-paths.patch
# fix printing of landscape documents in Okular (#509645, kde#181290)
# https://git.reviewboard.kde.org/r/101513/
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdegraphics-4.6.90-okular-landscape.patch

## upstream patches

set +e +o pipefail
