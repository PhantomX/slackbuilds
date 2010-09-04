
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tbb-2.2-20090809-cxxflags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tbb-2.2-mfence.patch

set +e +o pipefail
