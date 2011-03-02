
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fedora cmake macros define -DLIB_SUFFIX=64 on 64 bits platforms
patch -p1 -E --backup -z .libdir --verbose -i ${SB_PATCHDIR}/${PNAME}-2.2-libdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.2-nointrernal.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.2-fixpc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/opencv-2.1.0-opencvconfig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.2-numpy.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.2-gcc46.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.2-nov4l1.patch

set +e +o pipefail
