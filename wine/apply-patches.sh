  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-rpath.patch.gz | patch -p0 -E --backup --verbose || exit 1
# http://art.ified.ca/downloads/winepulse-0.17-configure.ac.patch
zcat ${SB_PATCHDIR}/winepulse-0.17-configure.ac.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://art.ified.ca/downloads/winepulse-0.21.patch
zcat ${SB_PATCHDIR}/winepulse-0.21.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://art.ified.ca/downloads/adding-pulseaudio-to-winecfg.patch
zcat ${SB_PATCHDIR}/adding-pulseaudio-to-winecfg.patch.gz | patch -p1 -E --backup --verbose || exit 1
