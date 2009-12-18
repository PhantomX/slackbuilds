  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/portaudio-non-mmap-alsa.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/portaudio-doxynodate.patch.gz | patch -p1 -E --backup --verbose || exit 1
