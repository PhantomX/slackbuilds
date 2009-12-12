  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/flite-1.3-sharedlibs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/flite-1.3-doc_texinfo.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/flite-1.3-alsa_support.patch.gz | patch -p1 -E --backup --verbose || exit 1
