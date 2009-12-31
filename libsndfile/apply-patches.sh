  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libsndfile-1.0.17-regtests-need-sqlite.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libsndfile-1.0.18-less_strict_tests.patch.gz | patch -p1 -E --backup --verbose || exit 1
