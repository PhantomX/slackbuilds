
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Cherry picks from upstream git which hopefully fix rhbz#815581
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-fix-v4l2_munmap.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-clear_DISCONT_flag.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=677516
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-v4l2src-fix.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=677722
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-v4l2object-Don-t-probe-UVC-devices-for-being-interla.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gst-plugins-good-linux36.patch

set +e +o pipefail
