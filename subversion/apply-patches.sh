
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.0-rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.0-pie.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.0-kwallet.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.0-rubybind.patch

set +e +o pipefail
