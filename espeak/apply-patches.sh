  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.23-makefile_nostaticlibs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.40.02-gcc_no_libstdc++.patch.gz | patch -p1 -E --backup --verbose || exit 1
if [ "${SB_PA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-1.40.02-pulseaudio.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
