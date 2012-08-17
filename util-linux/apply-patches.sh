
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Changing the fdisk -l output (this was done prior to util-linux-ng) broke
# our installation scripts, so we have changed the name of partition type
# 83 back to "Linux swap":
zcat ${SB_PATCHDIR}/util-linux-ng.fdisk-no-solaris.diff.gz | patch -p1 -E --backup --verbose

# add note about ATAPI IDE floppy to fdformat.8
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-2.20-fdformat-man-ide.patch
# 151635 - makeing /var/log/lastlog
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-ng-2.21-login-lastlog.patch
# 231192 - ipcs is not printing correct values on pLinux
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-2.21-ipcs-32bit.patch

# From Slackware
# Fix loop encryption:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-mount-old-fix-encryption-usage.patch
# Fix fdisk granularity on 512 byte sector size devices:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-fdisk-don-t-ignore-1MiB-granularity-on-512-byte-sect.patch
# 20120814 bkw: fix "column --separator <anything>" segfault
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/column-fix_long_opts.diff

### Upstream Patches
###

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
