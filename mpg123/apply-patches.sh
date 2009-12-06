  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/mpg123-1.9.2-libtool.patch.gz | patch -p0 -E --backup --verbose || exit 1
