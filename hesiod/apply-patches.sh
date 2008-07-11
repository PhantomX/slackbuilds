  
SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/${NAME}-3.1.0-classes.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.0.2-env.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.1.0-str.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.1.0-dnsparse.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.1.0-libresolv.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.1.0-perms.patch.gz | patch -p1 -E --backup --verbose || exit 1
