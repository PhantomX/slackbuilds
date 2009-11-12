  
SB_PATCHDIR=${CWD}/patches

zcat ${CWD}/rule_generator.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/udev-118-sysconf.patch.gz | patch -p1 --verbose || exit 1

