
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tbb-3.0-cxxflags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tbb-4.0-mfence.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tbb-4.3-dont-snip-Wall.patch

set +e +o pipefail
