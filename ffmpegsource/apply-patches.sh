
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ffmpeg.patch
# https://aur.archlinux.org/packages.php?ID=52798 - by kozec
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ffmpeg-2.patch
patch -p1 -E --backup --verbose -z .ffmpeg -i ${SB_PATCHDIR}/${NAME}-ffmpeg-3.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
