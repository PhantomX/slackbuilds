  
SB_PATCHDIR=${CWD}/patches

# Changing the fdisk -l output (this was done prior to util-linux-ng) broke
# our installation scripts, so we have changed the name of partition type
# 83 back to "Linux swap":
zcat ${SB_PATCHDIR}/util-linux-ng.fdisk-no-solaris.diff.gz | patch -p1 -E --backup --verbose || exit 1

# add note about ATAPI IDE floppy to fdformat.8
zcat ${SB_PATCHDIR}/util-linux-ng-2.13-fdformat-man-ide.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 151635 - makeing /var/log/lastlog
zcat ${SB_PATCHDIR}/util-linux-ng-2.13-login-lastlog.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 199745 - Non-existant simpleinit(8) mentioned in ctrlaltdel(8)
zcat ${SB_PATCHDIR}/util-linux-ng-2.13-ctrlaltdel-man.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 231192 - ipcs is not printing correct values on pLinux
zcat ${SB_PATCHDIR}/util-linux-ng-2.15-ipcs-32bit.patch.gz | patch -p1 -E --backup --verbose || exit 1

