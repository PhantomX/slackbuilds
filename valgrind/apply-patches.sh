
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.4.1-cachegrind-improvements.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.4.1-openat.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.4.1-x86_64-ldso-strlen.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}--3.4.1-glibc-2.10.1.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}--3.4.1-dwarf3.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}--3.4.1-dwarf-cfa-remember-state1.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}--3.4.1-dwarf-cfa-remember-state2.patch.gz | patch -p1 -E --backup --verbose || exit 1
