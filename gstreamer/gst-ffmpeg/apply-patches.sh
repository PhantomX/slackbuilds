
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-configure.ac-Fix-for-new-libav.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-gstffmpegutils-Fix-include.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-gstffmpegdec-Re-enable-MT-decoding-by-default.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-ffmpeg-fix-pad-template-ref-leaks.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-ffmpegdec-Report-latency-if-B-frames-are-present.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-ffmpeg-Channel-layouts-are-now-set-for-DTS-and-E-AC3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-ffmpegdemux-fix-caps-leak.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-ffdec-Only-set-get_buffer-function-for-video.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0009-codecmap-Add-mapping-for-Indeo-4-video-codec.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0010-ffmpegdec-Use-auto-threads-if-available-and-only-sli.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0011-ffmux-Use-correct-enum-type-for-return-value.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0012-ffdec-don-t-flush-buffers-on-DISCONT.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gst-ffmpeg-0.10.12-ChangeLog-UTF-8.patch

set +e +o pipefail
