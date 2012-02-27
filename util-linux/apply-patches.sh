
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

### Upstream Patches
###

set +e +o pipefail
