
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patches from Mageia
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.1-dirprefix.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.1-mageia-boost-filesystem.patch

set +e +o pipefail
