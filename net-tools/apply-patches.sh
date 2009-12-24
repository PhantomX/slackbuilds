  
SB_PATCHDIR=${CWD}/patches

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose || exit 1
for patch in $(<debian/patches/series) ;do
  patch -p1 -i "debian/patches/${patch}" || exit 1
done
