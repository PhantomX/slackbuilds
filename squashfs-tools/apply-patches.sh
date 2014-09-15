
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/PAE.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mem-overflow.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/2gb.patch

set +e +o pipefail
