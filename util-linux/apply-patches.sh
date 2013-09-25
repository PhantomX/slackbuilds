
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
# v2.24 backport: #950497 - problem umounting loop device
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/2.24-libmount-canonicalize-for-conversion-from-loopdev.patch
# v2.24 backport: #921498 - multiple internal testsuite failures
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/2.24-tests-portability.patch
# v2.24 backport: #1005566 - recount_geometry: Process /usr/sbin/fdisk was killed by signal 8 (SIGFPE)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/2.24-libfdisk-fix-SIGFPE.patch
# v2.24 backport: #1005194 - su generates incorrect log entries
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/2.24-su-fix-lastlog-and-btmp-logging.patch

### Upstream Patches
###

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
