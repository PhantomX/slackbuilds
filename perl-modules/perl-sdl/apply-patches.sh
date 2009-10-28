  
SB_PATCHDIR=${CWD}/patches

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --verbose || exit 1

patch -p1 -b -z .deb < debian/patches/030_glu_nurbs.diff || exit 1

zcat ${SB_PATCHDIR}/perl-sdl-no-mixertest.patch.gz | patch -p0 -E --backup --verbose || exit 1

