  
SB_PATCHDIR=${CWD}/patches

zcat ${CWD}/rule_generator.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/udev-118-sysconf.patch.gz | patch -p1 --verbose || exit 1
# Some ancient apps expects js in /dev, so revert to old behavior (symlink in /dev)
zcat ${SB_PATCHDIR}/udev-136-old-js-behavior.patch.gz | patch -p0 --verbose || exit 1
