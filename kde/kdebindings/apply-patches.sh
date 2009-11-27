  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/kde-python-2.6.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.10-syntaxfix.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.10-gcc44.patch.gz | patch -p0 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-3.5.10-libgcj.patch.gz | patch -p0 -E --backup --verbose || exit 1
