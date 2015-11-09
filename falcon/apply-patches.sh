
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Falcon-0.9.6.8-mongo-cmake-linux-x64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Falcon-0.9.6.8-mongo-stdint.patch

set +e +o pipefail
