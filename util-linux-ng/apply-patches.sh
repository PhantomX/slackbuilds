
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Changing the fdisk -l output (this was done prior to util-linux-ng) broke
# our installation scripts, so we have changed the name of partition type
# 83 back to "Linux swap":
zcat ${SB_PATCHDIR}/util-linux-ng.fdisk-no-solaris.diff.gz | patch -p1 -E --backup --verbose

# add note about ATAPI IDE floppy to fdformat.8
zcat ${SB_PATCHDIR}/util-linux-ng-2.13-fdformat-man-ide.patch.gz | patch -p1 -E --backup --verbose
# 151635 - makeing /var/log/lastlog
zcat ${SB_PATCHDIR}/util-linux-ng-2.13-login-lastlog.patch.gz | patch -p1 -E --backup --verbose
# 199745 - Non-existant simpleinit(8) mentioned in ctrlaltdel(8)
zcat ${SB_PATCHDIR}/util-linux-ng-2.13-ctrlaltdel-man.patch.gz | patch -p1 -E --backup --verbose
# 231192 - ipcs is not printing correct values on pLinux
zcat ${SB_PATCHDIR}/util-linux-ng-2.15-ipcs-32bit.patch.gz | patch -p1 -E --backup --verbose

### Upstream Patches
###
# 598631 - shutdown, reboot, halt and C-A-D don't work
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-ng-2.17-agetty-clocal.patch
# 618957 - ISO images listed in fstab are mounted twice at boot
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-ng-2.17-mount-loopdev.patch

# Borrowed from Arch
# fix findmnt
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-findmnt.patch
# add nilfs2 support, included in next upstream release
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-ng-nilfs2.patch
# fix cfdisk partition changing, included in next upsream release
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-ng-cfdisk.patch

set +e +o pipefail
