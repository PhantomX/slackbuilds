
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.9.0-rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.9.0-pie.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.9.0-kwallet.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.0-rubybind.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.5-swigplWall.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.13-swigpython.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.11-ruby22-fixes.patch

set +e +o pipefail
