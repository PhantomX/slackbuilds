
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
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-mount-check-for-NULL-before-reading-pm-what.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-shared-util-fix-off-by-one-error-in-tag_to_udev_node.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-journald-fix-minor-memory-leak.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-journal-fix-minor-memory-leak.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-systemd-fix-memory-leak-in-cgroup-code.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-memory-leak-in-stdout-journal-streams.patch

### Arch
# Fix lingering user managers
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-login-Don-t-stop-a-running-user-manager-from-garbage.patch
# Backport changes in fstab passno handling
# Basically, we only need 0001 and 0007, but 0007 is based on earlier patches,
# and it doesn't hurt to backport them all.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-fstab-generator-When-parsing-the-root-cmdline-option.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-fstab-generator-Generate-explicit-dependencies-on-sy.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-gpt-auto-generator-Generate-explicit-dependencies-on.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Remove-FsckPassNo-from-systemd-fsck-root.service.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-mount-service-drop-FsckPassNo-support.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-efi-boot-generator-hookup-to-fsck.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-fsck-root-only-run-when-requested-in-fstab.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-fstab-generator-Do-not-try-to-fsck-non-devices.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
