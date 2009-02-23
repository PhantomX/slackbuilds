  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-mem-exhausted.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-empty-pattern.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 --verbose || exit 1
sed -i -e '/^#@@/d' debian/patches/64-egf-speedup.patch
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i} || exit 1
done
