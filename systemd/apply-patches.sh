
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_VERBOSE_OPT
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch -p1 -s --backup ${PATCH_VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  echo "Applying ${patch}"
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff

# Upstream
ApplyPatch 0001-acpi-fptd-fix-memory-leak-in-acpi_get_boot_usec.patch
ApplyPatch 0002-fix-lingering-references-to-var-lib-backlight-random.patch
ApplyPatch 0003-acpi-make-sure-we-never-free-an-uninitialized-pointe.patch
ApplyPatch 0001-cryptsetup-fix-OOM-handling-when-parsing-mount-optio.patch
ApplyPatch 0002-journald-add-missing-error-check.patch
ApplyPatch 0003-bus-fix-potentially-uninitialized-memory-access.patch
ApplyPatch 0004-dbus-fix-return-value-of-dispatch_rqueue.patch
ApplyPatch 0005-modules-load-fix-error-handling.patch
ApplyPatch 0001-mkdir-pass-a-proper-function-pointer-to-mkdir_safe_i.patch
ApplyPatch 0001-tmpfiles.d-include-setgid-perms-for-run-log-journal.patch
ApplyPatch 0001-systemd-order-remote-mounts-from-mountinfo-before-re.patch
ApplyPatch 0001-mount-check-for-NULL-before-reading-pm-what.patch
ApplyPatch 0001-shared-util-fix-off-by-one-error-in-tag_to_udev_node.patch
ApplyPatch 0001-journald-fix-minor-memory-leak.patch
ApplyPatch 0001-journald-remove-rotated-file-from-hashmap-when-rotat.patch
ApplyPatch 0001-journal-fix-minor-memory-leak.patch
ApplyPatch 0001-cgroup-run-PID-1-in-the-root-cgroup.patch
ApplyPatch 0002-shutdown-trim-the-cgroup-tree-on-loop-iteration.patch
ApplyPatch 0001-acpi-fpdt-break-on-zero-or-negative-length-read.patch
ApplyPatch 0001-systemd-fix-memory-leak-in-cgroup-code.patch
ApplyPatch 0001-activate-mention-E-in-the-help-text.patch
ApplyPatch 0002-activate-fix-crash-when-s-is-passed.patch
ApplyPatch 0001-Resolve-dev-console-to-the-active-tty-instead-of-jus.patch
ApplyPatch 0002-Only-disable-output-on-console-during-boot-if-needed.patch
ApplyPatch 0003-Fix-possible-lack-of-status-messages-on-shutdown-reb.patch
ApplyPatch 0001-Fix-RemainAfterExit-services-keeping-a-hold-on-conso.patch
ApplyPatch 0001-systemd-treat-reload-failure-as-failure.patch
ApplyPatch 0001-Fix-memory-leak-in-stdout-journal-streams.patch

### Arch
# Fix lingering user managers
ApplyPatch 0001-login-Don-t-stop-a-running-user-manager-from-garbage.patch
# Backport changes in fstab passno handling
# Basically, we only need 0001 and 0007, but 0007 is based on earlier patches,
# and it doesn't hurt to backport them all.
ApplyPatch 0001-fstab-generator-When-parsing-the-root-cmdline-option.patch
ApplyPatch 0002-fstab-generator-Generate-explicit-dependencies-on-sy.patch
ApplyPatch 0003-gpt-auto-generator-Generate-explicit-dependencies-on.patch
ApplyPatch 0004-Remove-FsckPassNo-from-systemd-fsck-root.service.patch
ApplyPatch 0005-mount-service-drop-FsckPassNo-support.patch
ApplyPatch 0006-efi-boot-generator-hookup-to-fsck.patch
ApplyPatch 0007-fsck-root-only-run-when-requested-in-fstab.patch
ApplyPatch 0001-fstab-generator-Do-not-try-to-fsck-non-devices.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
