
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-shadowconfig-man.patch.gz | patch -p1 --verbose --backup
zcat ${SB_PATCHDIR}/${NAME}.login.defs.diff.gz | patch -p0 --verbose --backup
if [ "${SB_RH}" = "YES" ]; then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5-redhat.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5-uflg.patch
fi

patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}-4.1.5-goodname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4.2-infoParentDir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5-man.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5-grremove.patch

set +e +o pipefail
