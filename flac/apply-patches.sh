
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/flac-1.2.1-asm.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/flac-1.2.1-gcc43.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/flac-1.2.1-cflags.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/flac-1.2.1-hidesyms.patch.gz | patch -p1 -E --backup --verbose || exit 1
# reduce number of tests
zcat ${SB_PATCHDIR}/flac-1.2.1-tests.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/flac-1.2.1-bitreader.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/flac.man.diff.gz | patch -p1 -E --backup --verbose || exit 1
