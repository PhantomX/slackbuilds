  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libtool-2.2.4-nomovedwarning.patch.gz | patch -p1 --verbose || exit 1 
zcat ${SB_PATCHDIR}/libtool-2.2.6a-rpath.patch.gz | patch -p1 --verbose || exit 1 
