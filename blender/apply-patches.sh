  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.49-scons.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.44-bid.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Both patches are forwarded to upstream via email
zcat ${SB_PATCHDIR}/${NAME}-2.46rc3-cve-2008-1103-1.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.48a-cve-2008-4863.patch.gz | patch -p1 -E --backup --verbose || exit 1
