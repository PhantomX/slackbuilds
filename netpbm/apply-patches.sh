  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-10.17-time.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-9.24-strip.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.19-message.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.47-security2.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-10.23-security.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.24-nodoc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.28-gcc4.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.27-bmptopnm.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.28-CAN-2005-2471.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.31-xwdfix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.33-ppmtompeg.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-10.33-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.34-pamscale.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.35-glibc.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-10.35-gcc43.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-10.35-rgbtxt.patch.gz | patch -p1 -E --backup --verbose || exit 1

#zcat ${SB_PATCHDIR}/${NAME}-10.35-pnmmontagefix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.35-pnmtofiasco-stdin.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-10.35-64bitfix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.35-ximtoppmsegfault.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-10.35-svgtopam.patch.gz | patch -p1 -E --backup --verbose || exit 1
