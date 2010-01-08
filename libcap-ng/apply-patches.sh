  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libcap-ng-0.6.3-euid.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libcap-ng-0.6.3-setpcap.patch.gz | patch -p1 -E --backup --verbose || exit 1
