
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Slackware

## Fedora
zcat ${SB_PATCHDIR}/${NAME}-shadowconfig-man.patch.gz | patch -p1 --verbose --backup
if [ "${SB_RH}" = "YES" ]; then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5-redhat.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5-uflg.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-id-alloc.patch
fi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-goodname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-info-parent-dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5-2ndskip.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-backup-mode.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-logmsg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.3.1-manfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-userdel-helpfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.1-date-parsing.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-ingroup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.5.1-move-home.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.1-usermod-unlock.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.1-no-lock-dos.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.3.1-defs-chroot.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.1-null-tm.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.3.1-process-defaults.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/924cc346475dea7dc394316cd7c3d5d0414e538e.patch

set +e +o pipefail
