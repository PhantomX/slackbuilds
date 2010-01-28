  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-1.2.7-CFLAGS.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-1.1.1-pkgconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-1.2.7-libv4l2.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-1.2.8-tweak.patch.gz | patch -p1 -E --backup --verbose || exit 1
if [ "${SB_PNG14}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/directfb-1.4.3-png14.patch.gz | patch -p0 -E --backup --verbose || exit 1
fi
