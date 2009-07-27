  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/c_cpp_reference-2.0.2-config.patch.gz | patch -p0 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-2.1.5_for_KDE_3.1-doc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.0-svn.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.4-gcc44.patch.gz | patch -p2 -E --backup --verbose || exit 1
