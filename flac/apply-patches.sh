
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.2.1-asm.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.2.1-cflags.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.2.1-hidesyms.patch.gz | patch -p1 -E --backup --verbose || exit 1
# reduce number of tests
zcat ${SB_PATCHDIR}/${NAME}-1.2.1-tests.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}.man.diff.gz | patch -p1 -E --backup --verbose || exit 1
