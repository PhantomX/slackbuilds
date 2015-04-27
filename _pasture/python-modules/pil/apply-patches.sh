  
SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/python-imaging-no-xv.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/python-imaging-lib64.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/python-imaging-giftrans.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/python-imaging-1.1.6-sane-types.patch.gz | patch -p1 -E --backup --verbose  || exit 1
