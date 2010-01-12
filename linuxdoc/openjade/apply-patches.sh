  
SB_PATCHDIR=${CWD}/patches

#do not link against -lnsl
zcat ${SB_PATCHDIR}/openjade-1.3.1-nsl.patch.gz | patch -p1 -E --backup --verbose || exit 1
#Fix dependent libs for libogrove (bug #198232).
zcat ${SB_PATCHDIR}/openjade-deplibs.patch.gz | patch -p1 -E --backup --verbose || exit 1
#do not require OpenSP libosp.la file for build(#485114)
zcat ${SB_PATCHDIR}/openjade-nola.patch.gz | patch -p1 -E --backup --verbose || exit 1
