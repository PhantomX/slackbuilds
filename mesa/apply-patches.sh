
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nv50-fix-build.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-9.2-hardware-float.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-10.2-evergreen-big-endian.patch

# https://bugs.freedesktop.org/show_bug.cgi?id=75797#c1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-mesa-Don-t-optimize-out-glClear-if-drawbuffer-size-i.patch
# https://bugs.freedesktop.org/show_bug.cgi?id=73512
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-opencl-use-versioned-.so-in-mesa.icd.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/radeonsi-llvm-version-hack.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
