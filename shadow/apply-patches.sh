  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.shadowconfig.diff.gz | patch -p1 --verbose --backup || exit 1
zcat ${SB_PATCHDIR}/${NAME}-shadowconfig-man.patch.gz | patch -p1 --verbose --backup || exit 1
zcat ${SB_PATCHDIR}/${NAME}.login.defs.diff.gz | patch -p0 --verbose --backup || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.1.2-redhat1.patch.gz | patch -p1 --verbose --backup || exit 1
if [ "${SB_RH}" = "YES" ; then
  zcat ${SB_PATCHDIR}/${NAME}-4.1.2-redhat2.patch.gz | patch -p1 --verbose --backup || exit 1
fi
zcat ${SB_PATCHDIR}/${NAME}-4.1.2-goodname.patch.gz | patch -p1 --verbose --backup || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.1.2-sysAccountDownhill.patch.gz | patch -p1 --verbose --backup || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.1.2-gmSEGV.patch.gz | patch -p1 --verbose --backup || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.1.2-audit.patch.gz | patch -p1 --verbose --backup || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.1.2-checkName.patch.gz | patch -p1 --verbose --backup || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.1.2-gmNoGroup.patch.gz | patch -p1 --verbose --backup || exit 1
