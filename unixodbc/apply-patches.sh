  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/depcomp.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/multilib-config.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/parserupdate.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.2.11-stricmp.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Remove bundled libltdl copy
zcat ${SB_PATCHDIR}/360-${PNAME}-2.2.12-libltdlfixes.patch.gz | patch -p1 -E --backup --verbose || exit 1
rm -rf libltdl

