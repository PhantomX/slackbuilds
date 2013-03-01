
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tntnet-conf-fedora.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/tntnet-gcc47_fixes.patch

set +e +o pipefail
