
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Slackare
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.crypt.glibc217.v2.diff
## Fedora
zcat ${SB_PATCHDIR}/${NAME}-shadowconfig-man.patch.gz | patch -p1 --verbose --backup
if [ "${SB_RH}" = "YES" ]; then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5-redhat.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5-uflg.patch
fi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-goodname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-info-parent-dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5-2ndskip.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-backup-mode.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-merge-group.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-logmsg.patch

set +e +o pipefail
