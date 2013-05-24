
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff

# Upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-systemctl-does-not-expand-u-so-revert-back-to-I.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-sd-journal-check-if-the-pointers-passed-are-the-same.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-journalctl-add-k-dmesg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-units-rework-systemd-random-seed-load-save-.service-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-utmp-turn-systemd-update-utmp-shutdown.service-into-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-service-kill-processes-with-SIGKILL-on-watchdog-fail.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-systemctl-make-systemctl-is-enabled-work-for-templat.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
