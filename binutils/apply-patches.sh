  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.19.50.0.1-symbolic-envvar-revert.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.18.50.0.9-set-long-long.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.18.50.0.9-linkonce-r-discard.patch.gz | patch -p0 -E --backup --verbose || exit 1
