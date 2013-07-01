
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## RPM Fusion
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.3.1-gcc47.patch

set +e +o pipefail
