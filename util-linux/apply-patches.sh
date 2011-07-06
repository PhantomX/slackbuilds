
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Changing the fdisk -l output (this was done prior to util-linux-ng) broke
# our installation scripts, so we have changed the name of partition type
# 83 back to "Linux swap":
zcat ${SB_PATCHDIR}/util-linux-ng.fdisk-no-solaris.diff.gz | patch -p1 -E --backup --verbose

# add note about ATAPI IDE floppy to fdformat.8
zcat ${SB_PATCHDIR}/util-linux-ng-2.13-fdformat-man-ide.patch.gz | patch -p1 -E --backup --verbose
# 199745 - Non-existant simpleinit(8) mentioned in ctrlaltdel(8)
zcat ${SB_PATCHDIR}/util-linux-ng-2.13-ctrlaltdel-man.patch.gz | patch -p1 -E --backup --verbose
# 151635 - makeing /var/log/lastlog
zcat ${SB_PATCHDIR}/util-linux-ng-2.13-login-lastlog.patch.gz | patch -p1 -E --backup --verbose
# 231192 - ipcs is not printing correct values on pLinux
zcat ${SB_PATCHDIR}/util-linux-ng-2.15-ipcs-32bit.patch.gz | patch -p1 -E --backup --verbose

### Upstream Patches
###
# kernel "3.0"
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-2.19-kernel-version.patch
# 709319 - 'mount -a' mounts already mounted directories
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-2.19-libmount-mounted.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-2.19-mount-a-bind.patch
# 709681 - failure to mount if a mount point ends with a slash in /etc/fstab
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-2.19-mount-fsname.patch
# 716483 - /var/tmp --(BIND-mounted)--> /tmp disrupts/hangs bootup
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-2.19-mount-mountpoint.patch

set +e +o pipefail
