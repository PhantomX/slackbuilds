
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#http://code.opencv.org/issues/2720
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.4.4-pillow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.9-ts_static.patch
# fix/simplify cmake config install location (upstreamable)
# https://bugzilla.redhat.com/1031312
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.7-cmake_paths.patch
# Fix macro usage of "list_filterout"
# https://github.com/pld-linux/opencv/commit/dadee4672641272b129410bc097f5c199bb4fb43
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.11-listfilterout.patch

set +e +o pipefail
