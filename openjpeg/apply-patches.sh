
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# revert soname bump compared to 1.5.0 release (for now)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.5.1-soname.patch

## upstreamable patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.5.1-cmake_libdir.patch

## upstream patches:
# http://code.google.com/p/openjpeg/issues/detail?id=155
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.5-r2029.patch
# http://code.google.com/p/openjpeg/issues/detail?id=152
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.5-r2031.patch
# http://code.google.com/p/openjpeg/issues/detail?id=169
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.5-r2032.patch
# http://code.google.com/p/openjpeg/issues/detail?id=166
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/openjpeg-1.5-r2033.patch

set +e +o pipefail
