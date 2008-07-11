  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.18.50.0.6-build-fixes.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.18.50.0.6-place-orphan.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.18.50.0.6-symbolic-envvar-revert.patch.gz | patch -p0 -E --backup --verbose || exit 1
