  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/gdbm-1.8.3-libtool.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gdbm-1.8.0-jbj.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gdbm-1.8.3-compat-linking.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gdbm-1.8.3-build.patch.gz | patch -p0 -E --backup --verbose || exit 1
