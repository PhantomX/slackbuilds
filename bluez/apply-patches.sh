  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-utils-oui-usage.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-try-utf8-harder.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://thread.gmane.org/gmane.linux.bluez.kernel/1754
zcat ${SB_PATCHDIR}/${NAME}-activate-wacom-mode2.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-socket-mobile-cf-connection-kit.patch.gz | patch -p1 -E --backup --verbose || exit 1
