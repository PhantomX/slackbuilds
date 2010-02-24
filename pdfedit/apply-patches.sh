  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/pdfedit-destdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/pdfedit-fix-includes.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/pdfedit-0.4.3-zlib.patch.gz | patch -p1 -E --backup --verbose || exit 1
#Patch to fix several security issues
zcat ${SB_PATCHDIR}/xpdf-3.02pl4.patch.gz | patch -p1 -E --backup --verbose || exit 1
