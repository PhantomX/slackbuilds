
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Set to test (some patches require others, so, is not 100%)
DRYRUN=${DRYRUN:-NO}

if [ "${DRYRUN}" = "YES" ] ; then
  DRYRUN_OPT="--dry-run"
fi

if [ "${VERBOSE}" = "YES" ] ; then
  VERBOSE_OPT="--verbose"
fi

if [ "${SVERBOSE}" = "YES" ] ; then
  set -o xtrace
fi

PATCHCOM="patch ${DRYRUN_OPT} -p1 -F1 -s ${VERBOSE_OPT}"

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

IgnorePatch() {
  if [ -n "{IGNORE}" ] ;then
    for patchnumber in ${IGNORE} ;do
      sed -e "/^${patchnumber}/d" -i $1
    done
  fi
}

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
ApplyPatch 0001-maint-post-release-administrivia.patch
ApplyPatch 0002-libparted-check-PMBR-before-GPT-partition-table.patch
ApplyPatch 0003-tests-add-t0301-overwrite-gpt-pmbr.sh.patch
ApplyPatch 0004-tests-remove-bogus-envvar-setting-from-t0300-dos-on-.patch
ApplyPatch 0005-gpt-fix-endianness-bug-in-gpt_get_max_supported_part.patch
ApplyPatch 0006-tests-add-a-test-to-exercise-just-fixed-code.patch
ApplyPatch 0007-maint-avoid-new-syntax-check-failure-re-xref.patch
ApplyPatch 0008-maint-don-t-prohibit-strncpy-just-yet.patch
ApplyPatch 0010-build-prefer-AM_CPPFLAGS-over-INCLUDES.patch
ApplyPatch 0011-build-don-t-list-files-with-unknown-suffix-in-_SOURC.patch
ApplyPatch 0012-build-prefer-pattern-rules-over-suffix-rules.patch
ApplyPatch 0013-build-enable-subdir-objects-Automake-option-globally.patch
ApplyPatch 0014-tests-prefer-AM_TESTS_ENVIRONMENT-over-TESTS_ENVIRON.patch
ApplyPatch 0015-tests-remove-unused-AM_TESTS_ENVIRONMENT-entries.patch
ApplyPatch 0019-maint-remove-unnecessary-wcslen-use.patch
ApplyPatch 0020-tests-clarify-a-comment-_reading_-gpt-tables-on-tiny.patch
ApplyPatch 0021-gpt-require-first_usable_LBA-last_usable_LBA.patch
ApplyPatch 0022-tests-update-t7000-scripting.sh-to-avoid-new-FP.patch
ApplyPatch 0023-gpt-permit-mklabel-gpt-on-a-67-sector-device.patch
ApplyPatch 0024-gpt-when-mklabel-gpt-fails-always-provide-a-diagnost.patch
ApplyPatch 0025-tests-show-that-small-dev-now-evokes-mklabel-gpt-dia.patch
ApplyPatch 0026-tests-avoid-syntax-check-failure-for-reversed-compar.patch
ApplyPatch 0027-mac-don-t-let-larger-partition-table-specified-block.patch
ApplyPatch 0028-tests-mac-exercise-the-just-fixed-bug.patch
ApplyPatch 0029-add-support-for-a-new-Linux-specific-GPT-partition-t.patch
ApplyPatch 0030-tests-clean-up-tests.patch
ApplyPatch 0031-doc-libparted-disk.c-correct-doxygen-comment-typo.patch
ApplyPatch 0032-tests-stop-using-private-dev-directory-for-losetup.patch
ApplyPatch 0034-tests-improve-test-for-partitionable-loop-devices.patch
ApplyPatch 0035-tests-t8001-do-not-rely-on-modprobe-loop.patch
ApplyPatch 0036-build-do-not-rely-on-automake-s-AM_TESTS_ENVIRONMENT.patch
ApplyPatch 0038-partprobe-remove-no-update-long-option.patch
ApplyPatch 0039-doc-update-partprobe-manpage.patch
ApplyPatch 0040-partprobe-remove-partitions-when-there-is-no-partiti.patch
ApplyPatch 0041-maint-use-AM_V_GEN-to-cut-down-on-build-noise.patch
ApplyPatch 0043-tests-cleanup-losetup-usage.patch
ApplyPatch 0045-libparted-refactor-device-mapper-partition-sync-code.patch
ApplyPatch 0046-libparted-remove-extraneous-blkpg-add-partition-ped-.patch
ApplyPatch 0047-libparted-don-t-probe-every-dm-device-in-probe_all.patch
ApplyPatch 0048-tests-make-t6003-dm-hide-work-reliably-on-F17.patch
ApplyPatch 0049-doc-1MiB-alignment-is-not-enough-for-cheap-flash-dri.patch
ApplyPatch 0052-maint-avoid-new-warning-error-with-gcc-4.8.0-2013010.patch
ApplyPatch 0053-dos-improve-MBR-signature-generation.patch
ApplyPatch 0055-parted-fix-EOF-and-ctrl-c-handling.patch
ApplyPatch 0056-tests-t6003-dm-hide-don-t-hang-on-exception.patch
ApplyPatch 0057-gpt-Revert-small-device-commits.patch

# XXX Locally modified patch to apply without date changes
ApplyPatch 0058-libparted-handle-logical-partitions-starting-immedia.patch
ApplyPatch 0059-libparted-fix-gpt-end-of-disk-handling.patch
ApplyPatch 0060-libparted-allow-some-common-errors-to-be-ignored.patch
ApplyPatch 0061-Revert-linux-commit-do-not-unnecessarily-open-partit.patch
ApplyPatch 0062-libparted-avoid-disturbing-partitions.patch
ApplyPatch 0063-Fix-test-compilation.patch
ApplyPatch 0064-GPT-add-support-for-PReP-GUID.patch
ApplyPatch 0065-libparted-make-sure-not-to-treat-percentages-as-exac.patch
ApplyPatch 0066-bug-15591-PATCH-libparted-handle-i18n-gpt-partition-.patch
ApplyPatch 0067-Fix-help-text-for-disk_-set-toggle.patch
ApplyPatch 0068-libparted-copy-pmbr_boot-when-duplicating-GPT-disk.patch
ApplyPatch 0069-tests-test-creating-20-device-mapper-partitions-8031.patch
ApplyPatch 0070-libparted-use-dm_udev_wait-698121.patch
ApplyPatch 0071-libparted-preserve-the-uuid-on-dm-partitions-832145.patch
ApplyPatch 0072-tests-Make-sure-dm-UUIDs-are-not-erased.patch
ApplyPatch 0073-libparted-don-t-canonicalize-dev-md-paths-872361.patch
ApplyPatch 0074-tests-rewrite-t6001-to-use-dev-mapper.patch
ApplyPatch 0075-libparted-Add-Intel-Rapid-Start-Technology-partition.patch
ApplyPatch 0076-libparted-Add-UEFI-System-Partition-flag.patch
ApplyPatch 0077-libparted-Recognize-btrfs-filesystem.patch
ApplyPatch 0078-tests-Add-btrfs-and-xfs-to-the-fs-probe-test.patch
ApplyPatch 0079-tests-Restrict-gpt-header-munge-to-little-endian-sys.patch
ApplyPatch 0080-libparted-don-t-require-a-system-id-string.patch
ApplyPatch 0081-libparted-sync-partitions-16.patch
ApplyPatch 0082-ui-switch-to-new-style-readline-typedef.patch
ApplyPatch 0083-libparted-add-support-for-implicit-FBA-DASD-partitio.patch
ApplyPatch 0084-libparted-add-support-for-EAV-DASD-partitions.patch
ApplyPatch 0085-libparted-mklabel-to-support-EAV-DASD.patch
ApplyPatch 0086-libparted-Avoid-dasd-as-default-disk-type-while-prob.patch
ApplyPatch 0087-libparted-mklabel-to-support-EDEV-DASD.patch
ApplyPatch 0088-libparted-Fix-check-for-backup-header-location.patch
ApplyPatch 0089-libparted-Use-common-function-to-calculate-PTE-secto.patch
ApplyPatch 0090-tests-Add-emit_superuser_warning-for-gpt-tests.patch
ApplyPatch 0091-tests-Use-msdos-overlap-to-setup-t0283.patch
ApplyPatch 0092-testing-Use-little-endian-packing-in-gpt-tests.patch
ApplyPatch 0093-libparted-fix-several-integer-overflows-with-dvh-lab.patch
ApplyPatch 0094-tests-Use-force-for-xfs-in-t1700-and-a-larger-file.patch
ApplyPatch 0095-tests-t1700-change-count-to-seek.patch
ApplyPatch 0096-tests-Make-t4100-xfs-filesystem-larger-and-sparse.patch
ApplyPatch 0097-libparted-Fix-part-dupe-with-empty-name.patch
ApplyPatch 0098-tests-check-name-when-duplicating.patch
ApplyPatch 0099-tests-Add-ntfs-vfat-hfsplus-to-t1700-probe-test.patch
ApplyPatch 0100-GPT-strings-are-UCS-2LE-not-UTF-16.patch
ApplyPatch 0101-libparted-remove-last_usable_if_grown.patch
ApplyPatch 0102-tests-fix-t2310-dos-extended-2-sector-min-offset.sh.patch
ApplyPatch 0103-Fix-filesystem-detection-on-non-512-byte-sectors.patch
ApplyPatch 0104-libparted-don-t-detect-fat-and-ntfs-boot-sectors-as-.patch
ApplyPatch 0105-libparted-remove-old-partitions-first-before-adding-.patch
ApplyPatch 0106-libparted-remove-all-old-partitions-even-if-new-labe.patch
ApplyPatch 0107-libparted-fix-loop-labels-to-not-vanish.patch
ApplyPatch 0108-libparted-don-t-create-partition-on-loop-label.patch
ApplyPatch 0109-partprobe-do-not-skip-loop-labels.patch
ApplyPatch 0110-libparted-give-correct-partition-device-name-on-loop.patch
ApplyPatch 0111-libparted-don-t-trash-filesystem-when-writing-loop-l.patch
ApplyPatch 0112-tests-test-loop-labels.patch
ApplyPatch 0113-tests-Use-mkfs.xfs-to-create-files-1101112.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
