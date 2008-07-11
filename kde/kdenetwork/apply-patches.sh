  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.1-desktop.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.1-buildroot.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.2.3-resolv.patch.gz | patch -p1 -E --backup --verbose || exit 1
# include more/proper ppp headers
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-ppp.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-krfb_httpd.patch.gz | patch -p1 -E --backup --verbose || exit 1
