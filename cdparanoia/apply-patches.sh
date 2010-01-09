  
SB_PATCHDIR=${CWD}/patches

for patch in $(<patches/series) ;do
  patch -p1 -E --backup --verbose -i patches/${patch} || exit 1
done
