  
SB_PATCHDIR=${CWD}/patches

for patch in ${SB_PATCHDIR}/0*-*.patch ;do
  patch -p1 -E --backup --verbose -i ${patch} || exit 1
done
