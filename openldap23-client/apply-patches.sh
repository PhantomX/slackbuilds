  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/openldap-2.4.6-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/openldap-2.3.43-gcc44fix.patch.gz | patch -p0 -E --backup --verbose || exit 1
