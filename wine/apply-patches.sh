  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-rpath.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.1.15-winegcc.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Pulseaudio patches from http://art.ified.ca/downloads
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PPASRCARCHIVE} || exit 1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PPASRCARCHIVE2} || exit 1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PPASRCARCHIVE3} || exit 1
