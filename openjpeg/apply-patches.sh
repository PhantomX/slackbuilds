
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## upstreamable patches
# libopenjpeg has undefined references, http://bugzilla.redhat.com/467661
# http://groups.google.com/group/openjpeg/browse_thread/thread/fba9ad2a35b12e6a
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.4-no_undefined.patch
# Use soversion 3 (instead of 1.4)
# http://groups.google.com/group/openjpeg/browse_thread/thread/b9a1d1bfb6f8d09a
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.4-cmake_soversion_3.patch
# fix cmake to install pkgconfig file(s)
# http://groups.google.com/group/openjpeg/browse_thread/thread/545a90cf2b0e4af2
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.4-cmake_pkgconfig.patch
# fix cmake create_symlink usage
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.4-cmake_symlink_fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.4-OpenJPEGConfig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.4-libpng15.patch

set +e +o pipefail
