
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Revert ca6fc415788f3a2d4d8ff4c97f297eebf1f668ed, see
# http://thread.gmane.org/gmane.linux.bluez.kernel/5092/focus=5118
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Revert-Fix-the-session-is-shutdown-when-the-agent-ex.patch

set +e +o pipefail
