
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fpc-2.6.2-r22920.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fpmake-lib64.diff

set +e +o pipefail
