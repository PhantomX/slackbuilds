
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_VERBOSE_OPT
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch -p1 -s -F1 --backup ${PATCH_VERBOSE_OPT}"

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
ApplyPatch 0001-core-add-global-settings-for-enabling-CPUAccounting-.patch
ApplyPatch 0002-core-expose-architecture-as-a-bus-property-so-that-w.patch
ApplyPatch 0003-hostnamectl-read-virtualization-architecture-from-re.patch
ApplyPatch 0004-Remove-dead-lines-in-various-places.patch

### Arch
ApplyPatch 0001-login-fix-pos-array-allocation.patch
ApplyPatch 0002-login-set-pos-slot-to-fallback-on-pos-eviction.patch
ApplyPatch 0003-login-Allow-calling-org.freedesktop.login1.Seat.Swit.patch
ApplyPatch 0004-fix-typo-in-iDRAC-network-interface-name-irdac-idrac.patch
ApplyPatch 0007-mount-don-t-send-out-PropertiesChanged-message-if-ac.patch
ApplyPatch 0008-mount-don-t-fire-PropertiesChanged-signals-for-mount.patch
ApplyPatch 0009-logs-show-fix-corrupt-output-with-empty-messages.patch
ApplyPatch 0010-journalctl-refuse-extra-arguments-with-verify-and-si.patch
ApplyPatch 0011-cdrom_id-use-the-old-MMC-fallback.patch
ApplyPatch 0012-nspawn-fix-detection-of-missing-proc-self-loginuid.patch
ApplyPatch 0013-Fix-systemd-stdio-bridge-symlink.patch
ApplyPatch 0014-execute-free-directory-path-if-we-fail-to-remove-it-.patch
ApplyPatch 0015-journal-assume-that-next-entry-is-after-previous-ent.patch
ApplyPatch 0016-journal-forget-file-after-encountering-an-error.patch
ApplyPatch 0017-core-correctly-unregister-PIDs-from-PID-hashtables.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
