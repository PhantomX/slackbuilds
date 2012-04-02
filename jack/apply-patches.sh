
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# No-date-footer hack to remove dates from doxygen documentation
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-audio-connection-kit-no_date_footer.patch
# Build fix
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-doxygen-output-dir-fix.patch
# We don't want the internal API documentation
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-apidoc-only.patch
# Enable ffado buffersize change at runtime. From upstream trunk
# https://github.com/jackaudio/jack2/commit/96e025123
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-ffado-buffersize.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-realtime-compat.patch
# Fix jack-connect segfault when invoked with no arguments. From upstream trunk
# https://github.com/jackaudio/jack2/commit/00280570a
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-fix-connect-segfault.patch
# Fix ppc64 mpd startup issue RHBZ#799552
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-ppc64-long.patch
# uc_regs no longer available on ppc64
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-audio-connection-kit-ppc-uc_regs.patch 

set +e +o pipefail
