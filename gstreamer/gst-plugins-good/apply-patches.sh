
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gstreamer-plugins-good-0.10.30-flacparse_tell_baseparse.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gstreamer-plugins-good-0.10.30-flacdec_also_try_upstream.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gstreamer-plugins-good-0.10.30-flacparse_conversions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gstreamer-plugins-good-0.10.30-flacparse_fix_conversions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gstreamer-plugins-good-0.10.30-off_by_one.patch

set +e +o pipefail
