  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-0.10-nowerror.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-0.10-no_libs_on_ldflags.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-0.10-nodebug.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-0.10-gmake.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-0.10-kernelver.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-0.10-newkernel.patch.gz | patch -p0 -E --backup --verbose || exit 1
