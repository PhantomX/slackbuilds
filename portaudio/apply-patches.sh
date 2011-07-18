
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/portaudio-doxynodate.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/portaudio-pkgconfig-alsa.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/audacity-portmixer.patch

set +e +o pipefail
