
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff

# Upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-acpi-fptd-fix-memory-leak-in-acpi_get_boot_usec.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-fix-lingering-references-to-var-lib-backlight-random.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-acpi-make-sure-we-never-free-an-uninitialized-pointe.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-cryptsetup-fix-OOM-handling-when-parsing-mount-optio.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-journald-add-missing-error-check.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-bus-fix-potentially-uninitialized-memory-access.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-dbus-fix-return-value-of-dispatch_rqueue.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-modules-load-fix-error-handling.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-mkdir-pass-a-proper-function-pointer-to-mkdir_safe_i.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-tmpfiles.d-include-setgid-perms-for-run-log-journal.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-systemd-order-remote-mounts-from-mountinfo-before-re.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
