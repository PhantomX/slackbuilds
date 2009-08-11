  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.2.4-samplecfg_32and64bit.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.2.4-stackexecute.patch.gz | patch -p0 -E --backup --verbose || exit 1
