
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Changing the fdisk -l output (this was done prior to util-linux-ng) broke
# our installation scripts, so we have changed the name of partition type
# 83 back to "Linux swap":
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-ng.fdisk-no-solaris.diff

# 151635 - makeing /var/log/lastlog
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-ng-2.22-login-lastlog.patch
### Backport from v2.24 + #972457
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/util-linux-2.23-agetty-clocal.patch

### Upstream Patches
###

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
