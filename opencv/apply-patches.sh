
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fedora cmake macros define -DLIB_SUFFIX=64 on 64 bits platforms
patch -p1 -E --backup -z .libdir --verbose -i ${SB_PATCHDIR}/${NAME}-cmake-libdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.1-nointrernal.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.1-lapack.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.1-rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/opencv-2.1.0-opencvconfig.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libpng-1.4.patch

set +e +o pipefail
