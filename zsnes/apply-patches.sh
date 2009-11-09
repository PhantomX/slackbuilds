  
SB_PATCHDIR=${CWD}/patches

# Fixing compilation without libpng installed
zcat ${SB_PATCHDIR}/${NAME}-1.51-libpng.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.51-archopt-july-23-update.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.51-gcc43.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-1.51-libao-thread.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.51-depbuild.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.51-CC-quotes.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.51-FORTIFY_SOURCE.patch.gz | patch -p2 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.51-pulseaudio.patch.gz | patch -p2 -E --backup --verbose || exit 1
