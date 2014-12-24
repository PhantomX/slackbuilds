
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Modified from upstream
patch -p0 -E --backup --verbose -z .ffmpeg -i ${SB_PATCHDIR}/gegl-0.2.0-ffmpeg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gegl-0.2.0-lua-5.2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gegl-0.2.0-CVE-2012-4433.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gegl-0.2.0-remove-src-over-op.patch

set +e +o pipefail
