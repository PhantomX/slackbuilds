
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.3.0-openat.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.3.0-helgrind-p_b_w.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.4.0-glibc27-dlhack.patch.gz | patch -p1 -E --backup --verbose || exit 1
