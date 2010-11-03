
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libcdaudio-0.99.12-buffovfl.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/libcdaudio-0.99.12p2-libdir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libcdaudio-0.99-CAN-2005-0706.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
