
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.5.0-cachegrind-improvements.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.0-openat.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.0-glibc-2.10.1.patch.gz | patch -p1 -E --backup --verbose || exit 1
