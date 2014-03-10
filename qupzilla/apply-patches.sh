
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/QupZilla-1.6.3-kwallet-include.patch
# No tabs on top by default
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.3-disable-TabsOnTop.patch

set +e +o pipefail
