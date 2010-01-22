  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.2.0-fedora-gtest.patch.gz | patch -p2 -E --backup --verbose || exit 1
