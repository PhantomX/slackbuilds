  
SB_PATCHDIR=${CWD}/patches

touch -r m4/optimizations.m4 m4/optimizations.m4.stamp
zcat ${SB_PATCHDIR}/${NAME}-1.1.3-optflags.patch.gz | patch -p1 -E --backup --verbose || exit 1
touch -r m4/optimizations.m4.stamp m4/optimizations.m4
touch -r m4/pthreads.m4 m4/pthreads.m4.stamp
touch -r m4/pthreads.m4.stamp m4/pthreads.m4
zcat ${SB_PATCHDIR}/${NAME}-1.1.1-deepbind-939.patch.gz | patch -p1 -E --backup --verbose || exit 1
