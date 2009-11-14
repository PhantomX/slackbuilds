
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/SDL-1.2.14-byteorder.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/SDL-1.2.12-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/SDL-1.2.12-disable_yasm.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/SDL-1.2.14-audiodriver.patch.gz | patch -p1 -E --backup --verbose || exit 1

if [ "${SB_ALSA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/SDL-1.2.14-default-alsa.patch.gz | patch -p0 -E --backup --verbose || exit 1
fi
