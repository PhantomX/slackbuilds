
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-shadowconfig-man.patch.gz | patch -p1 --verbose --backup
zcat ${SB_PATCHDIR}/${NAME}.login.defs.diff.gz | patch -p0 --verbose --backup
if [ "${SB_RH}" = "YES" ]; then
  zcat ${SB_PATCHDIR}/${NAME}-4.1.4.2-redhat2.patch.gz | patch -p1 --verbose --backup
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4.2-uflg.patch
fi

patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-4.1.4.3-goodname.patch
zcat ${SB_PATCHDIR}/${NAME}-4.1.4.2-leak.patch.gz | patch -p1 --verbose --backup
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4.2-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4.2-infoParentDir.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4.3-semange.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4.2-acl.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4.2-underflow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4.2-gshadow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4.3-nopam.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4.3-IDs.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4.3-man.patch

for patch in ${SB_PATCHDIR}/r3*.diff ;do
  patch -p0 -i ${patch}
done

set +e +o pipefail
