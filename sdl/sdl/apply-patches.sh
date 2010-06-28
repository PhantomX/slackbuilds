
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/SDL-1.2.14-byteorder.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/SDL-1.2.12-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/SDL-1.2.12-disable_yasm.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/SDL-1.2.14-audiodriver.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.14-xio_error-rh603984.patch

if [ "${SB_ALSA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/SDL-1.2.14-default-alsa.patch.gz | patch -p0 -E --backup --verbose
fi

set +e +o pipefail
