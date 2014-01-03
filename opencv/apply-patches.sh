
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-pkgcmake.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-pkgcmake2.patch
#http://code.opencv.org/issues/2720
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.4.4-pillow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.7-ts_static.patch
# fix/simplify cmake config install location (upstreamable)
# https://bugzilla.redhat.com/1031312
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.7-cmake_paths.patch

set +e +o pipefail
