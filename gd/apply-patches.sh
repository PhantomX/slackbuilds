  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.0.33-freetype.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.0.34-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-loop.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.0.35-overflow.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.0.35-AALineThick.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.0.33-BoxBound.patch.gz | patch -p1 -E --backup --verbose || exit 1
if [ "${SB_PNG14}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/gd-libpng14.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
