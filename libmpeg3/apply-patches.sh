  
SB_PATCHDIR=${CWD}/patches

#zcat ${CWD}/${NAME}-1.6-makefile.patch.gz | patch -p1 -E --backup --verbose || exit 1
cat ${NAME}-1.7-mpeg3split.patch | patch -p0 -E --backup --verbose || exit 1
cat ${NAME}-1.7-textrel.patch | patch -p1 -E --backup --verbose || exit 1
cat ${NAME}-1.7-gnustack.patch | patch -p1 -E --backup --verbose || exit 1
cat ${NAME}-1.7-a52.patch | patch -p0 -E --backup --verbose || exit 1
cat ${NAME}-1.7-all_gcc4.patch | patch -p1 -E --backup --verbose || exit 1
cat ${NAME}-1.7-all_pthread.patch | patch -p0 -E --backup --verbose || exit 1
