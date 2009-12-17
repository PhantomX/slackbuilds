  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/apr-0.9.7-deepbind.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/apr-1.2.2-locktimeout.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/apr-1.2.2-libdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/apr-1.2.7-pkgconf.patch.gz | patch -p1 -E --backup --verbose || exit 1
