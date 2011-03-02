
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/f2c-20090411.patch
patch -p1 -d libf2c -E --backup --verbose -i ${SB_PATCHDIR}/20090407-main.patch

set +e +o pipefail
