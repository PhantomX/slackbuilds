  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.19.50.0.1-symbolic-envvar-revert.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.19.50.0.1-set-long-long.patch.gz | patch -p0 -E --backup --verbose || exit 1
