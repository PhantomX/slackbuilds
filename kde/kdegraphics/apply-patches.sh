
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.2.2-workaround-kolorpaintcrash.patch.gz | patch -p1 -E --backup --verbose
# don't hardcode paths in OkularConfig.cmake
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.80-OkularConfig-dont-hardcode-paths.patch
# use cmake_try_compile to grok version
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.2-libjpeg_version.patch
# fix printing of landscape documents in Okular (#509645, kde#181290)
# https://git.reviewboard.kde.org/r/101513/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.3-okular-landscape.patch

## upstream patches
# From gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/okular-4.6.4-update.patch

set +e +o pipefail
