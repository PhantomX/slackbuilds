  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.18.50.0.8-place-orphan.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.18.50.0.8-symbolic-envvar-revert.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.18.50.0.9-largefile.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.18.50.0.9-set-long-long.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.18.50.0.9-upstream.patch.gz | patch -p0 -E --backup --verbose || exit 1
