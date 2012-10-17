
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0_2_1-rc3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.0-rpcuser.patch

set +e +o pipefail
