
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
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-udev-log-error-if-chmod-chown-of-static-dev-nodes-fa.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-udev-static_node-don-t-touch-permissions-uneccessari.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-tmpfiles-support-passing-prefix-multiple-times.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-tmpfiles-introduce-exclude-prefix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-tmpfiles-setup-exclude-dev-prefixes-files.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
