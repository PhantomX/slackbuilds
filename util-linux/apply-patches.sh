
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Changing the fdisk -l output (this was done prior to util-linux-ng) broke
# our installation scripts, so we have changed the name of partition type
# 83 back to "Linux swap":
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-ng.fdisk-no-solaris.diff

# add note about ATAPI IDE floppy to fdformat.8
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-2.20-fdformat-man-ide.patch
# 151635 - makeing /var/log/lastlog
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-ng-2.21-login-lastlog.patch
# 231192 - ipcs is not printing correct values on pLinux
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-2.21-ipcs-32bit.patch

### Upstream Patches
###
# 889888 - wipefs does not completely wipe btrfs volume
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libblkid-add-support-for-btrfs-backup-superblock.patch
# 882305 - agetty: unstable /dev/tty* permissions
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/agetty-replace-perms-660-to-620.patch
# 885314 - hexdump segfault
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hexdump-do-not-segfault-when-iterating-over-an-empty.patch
# 896447 - No newlines in piped "cal" command
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cal-don-t-mix-ncurses-output-functions-and-printf.patch
# upstream patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libblkid-remove-optimization-from-verify-function.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
