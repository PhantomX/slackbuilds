  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.3.8-relative-mouse.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.3.8-sasl-auth.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.3.8-sasl-auth-tunnel.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.3.8-ungrab.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.3.8-ungrab-2.patch.gz | patch -p1 -E --backup --verbose || exit 1
