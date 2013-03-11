
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_DRYRUN_OPT PATCH_VERBOSE_OPT

[ "${PATCH_DRYRUN}" = "YES" ] && PATCH_DRYRUN_OPT="--dry-run"
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch ${PATCH_DRYRUN_OPT} -p1 -F1 -s ${PATCH_VERBOSE_OPT}"

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

# Flow control series
ApplyPatch 0001-char-Split-out-tcp-socket-close-code-in-a-separate-f.patch
ApplyPatch 0002-char-Add-a-QemuChrHandlers-struct-to-initialise-char.patch
ApplyPatch 0003-iohandlers-Add-enable-disable_write_fd_handler-funct.patch
ApplyPatch 0004-char-Add-framework-for-a-write-unblocked-callback.patch
ApplyPatch 0005-char-Update-send_all-to-handle-nonblocking-chardev-w.patch
ApplyPatch 0006-char-Equip-the-unix-tcp-backend-to-handle-nonblockin.patch
ApplyPatch 0007-virtio-console-Enable-port-throttling-when-chardev-i.patch
ApplyPatch 0008-spice-qemu-char.c-add-throttling.patch
ApplyPatch 0009-spice-qemu-char.c-remove-intermediate-buffer.patch
ApplyPatch 0010-usb-redir-Add-flow-control-support.patch
ApplyPatch 0011-char-Disable-write-callback-if-throttled-chardev-is-.patch
ApplyPatch 0012-hw-virtio-serial-bus-replay-guest-open-on-destinatio.patch

# qemu-kvm migration compat (posted upstream)
ApplyPatch 0101-configure-Add-enable-migration-from-qemu-kvm.patch
ApplyPatch 0102-acpi_piix4-Drop-minimum_version_id-to-handle-qemu-kv.patch
ApplyPatch 0103-i8254-Fix-migration-from-qemu-kvm-1.1.patch
ApplyPatch 0104-pc_piix-Add-compat-handling-for-qemu-kvm-VGA-mem-siz.patch
# Fix migration w/ qxl from qemu-kvm 1.2 (solution pending upstream)
ApplyPatch 0105-qxl-Add-rom_size-compat-property-fix-migration-from-.patch
# Fix generating docs with texinfo 5 (posted upstream)
ApplyPatch 0106-docs-Fix-generating-qemu-doc.html-with-texinfo-5.patch
# Fix test ordering with latest glib
ApplyPatch 0107-rtc-test-Fix-test-failures-with-recent-glib.patch

set +e +o pipefail
