
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-dvb-Fix-spelling-errors-found-by-lintian.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-libv4lconvert-Fix-decoding-of-160x120-Pixart-JPEG-im.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Revert-tinyjpeg-Better-luminance-quantization-table-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-libv4lconvert-Dynamic-quantization-tables-for-Pixart.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-libv4lconvert-Drop-Pixart-JPEG-frames-with-changing-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-libv4lconvert-Further-Pixart-JPEG-decompression-twea.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-libv4lconvert-Fix-interpretation-of-bit-7-of-the-Pix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-libv4lcontrol-Add-another-USB-ID-to-ASUS-table.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0009-libv4lcontrol-Add-Lenovo-Thinkpad-X220-Tablet-to-ups.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0010-libv4l2-Improve-VIDIOC_-_FMT-logging.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0011-libv4lconvert-replace-strndupa-with-more-portable-st.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0012-libdvbv5-Add-missing-includes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0013-libv4l2-Ensure-we-always-set-buf-length-when-convert.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0014-libv4l2-dqbuf-Don-t-requeue-buffers-which-we-are-ret.patch

set +e +o pipefail
