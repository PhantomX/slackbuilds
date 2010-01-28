  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.serial.group.is.uucp.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.12.1-var.patch .gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.12.2-open.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.12.3-clio.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/pilot-link-png14.patch.gz | patch -p1 --verbose || exit 1
