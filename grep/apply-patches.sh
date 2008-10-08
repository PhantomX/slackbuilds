  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-mem-exhausted.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-empty-pattern.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-egf-speedup.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.3-yesno-test-fix.patch.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 --verbose || exit 1
sed -i -e '/^#@@/d' debian/patches/64-egf-speedup.patch
mv debian/patches/75-dfa_calloc.patch debian/patches/75-dfa_calloc.patchp1
for i in debian/patches/*.patch; do
  patch -p0 --verbose --backup --suffix=".pdeb" -i ${i} || exit 1
done
patch -p1 -i debian/patches/75-dfa_calloc.patchp1
