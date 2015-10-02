
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ffms2-ffmpeg-1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ffms2-ffmpeg-2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ffms2-ffmpeg-3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ffms2-ffmpeg-4.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
