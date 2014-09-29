
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-pkgcmake.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-pkgcmake2.patch
#http://code.opencv.org/issues/2720
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.4.4-pillow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.9-ts_static.patch
# fix/simplify cmake config install location (upstreamable)
# https://bugzilla.redhat.com/1031312
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.7-cmake_paths.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0550-bomb-commit-of-gstreamer-videocapture-and-videowrite.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0552-eliminated-warnings.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0587-Fix-build-with-gstreamer-0.10.28.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0865-gstreamer-cleaning-up-resources.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0871-allow-for-arbitraty-number-of-sources-and-sinks.patch

set +e +o pipefail
