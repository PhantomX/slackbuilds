  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/jpeg-c++.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libjpeg-cflags.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libjpeg-buf-oflo.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libjpeg-autoconf.patch.gz | patch -p1 -E --backup --verbose || exit 1
