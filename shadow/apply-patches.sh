  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-shadowconfig-man.patch.gz | patch -p1 --verbose --backup || exit 1
zcat ${SB_PATCHDIR}/${NAME}.login.defs.diff.gz | patch -p0 --verbose --backup || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.1.3-redhat1.patch.gz | patch -p1 --verbose --backup || exit 1
if [ "${SB_RH}" = "YES" ]; then
  zcat ${SB_PATCHDIR}/${NAME}-4.1.3-redhat2.patch.gz | patch -p1 --verbose --backup || exit 1
fi

zcat ${SB_PATCHDIR}/${NAME}-4.1.3-goodname.patch.gz | patch -p1 --verbose --backup || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.1.3-lastlog.patch.gz | patch -p1 --verbose --backup || exit 1
