
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

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

# 533874 - RFE: libblkid should allow the developer to ask for scanning of slow devices (eg. cdroms)
zcat ${SB_PATCHDIR}/util-linux-ng-2.17-blkid-removable.patch.gz | patch -p1 -E --backup --verbose
# 575734 - use microsecond resolution for blkid cache entries
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-ng-2.17-blkid-usec.patch
# 580296 - "rtcwake" does miss the "off" option
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-ng-2.17-rtcwake-off.patch

set +e +o pipefail
