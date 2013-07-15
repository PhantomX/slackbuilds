
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff

# Upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-disable-the-cgroups-release-agent-when-shutting-down.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-cgroups-agent-remove-ancient-fallback-code-turn-conn.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-suppress-status-message-output-at-shutdown-when-quie.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-cgroup-downgrade-error-message-when-we-cannot-remove.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-systemctl-suppress-error-messages-when-checking-whet.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-systemctl-suppress-error-message-when-doing-systemct.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-core-send-out-Reloading-signal-before-and-after-doin.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-cgroup-when-uninstalling-agent-actually-turn-it-off-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-core-uninstall-cgroup-agent-only-if-we-are-running-o.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-cgroup-don-t-ever-try-to-destroy-the-cgroup-of-the-r.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
