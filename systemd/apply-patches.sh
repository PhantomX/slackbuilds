
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
ApplyPatch 0001-systemctl-fail-in-the-case-that-no-unit-files-were-f.patch
ApplyPatch 0002-build-remove-repeated-KMOD-section.patch
ApplyPatch 0003-machine-id-setup-don-t-try-to-read-UUID-from-VM-cont.patch
ApplyPatch 0004-resolved-dns-rr-fix-typo.patch
ApplyPatch 0005-resolved-fix-which-return-codes-we-check.patch
ApplyPatch 0006-journal-remote-remove-unreachable-code.patch
ApplyPatch 0007-util-return-after-freeing-all-members-of-array.patch
ApplyPatch 0008-journal-upload-make-sure-that-r-is-initialized.patch
ApplyPatch 0009-resolved-write-resolv.conf-search-switch-arguments.patch
ApplyPatch 0001-service-don-t-invoke-functions-at-the-same-time-as-d.patch
ApplyPatch 0001-service-use-the-right-timeout-for-stop-processes-we-.patch
ApplyPatch 0001-udev-hwdb-do-not-look-at-usb_device-parents.patch
ApplyPatch 0001-networkctl-do-not-mix-dns-and-ntp-servers.patch

### Arch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
