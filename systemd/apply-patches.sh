
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff

# Upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-remove-left-over-initrd-time-stamp-handling.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-remove-systemd-timestamp-from-sources.patch
rm -f src/timestamp/timestamp.c

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
