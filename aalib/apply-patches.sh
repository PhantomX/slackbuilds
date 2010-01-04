  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/aalib-aclocal.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/aalib-config-rpath.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/aalib-1.4rc5-bug149361.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/aalib-1.4rc5-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/aalib-1.4rc5-x_libs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/aalib-1.4rc5-libflag.patch.gz | patch -p0 -E --backup --verbose || exit 1
