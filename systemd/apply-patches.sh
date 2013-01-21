
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-udev-net_id-skip-stacked-network-devices.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-dbus-fix-serialization-of-calendar-timers.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-journald-use-automatic-cleanup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-service-for-Type-forking-services-ignore-exit-status.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
