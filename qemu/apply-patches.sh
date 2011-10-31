
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-char-Split-out-tcp-socket-close-code-in-a-separate-f.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-char-Add-a-QemuChrHandlers-struct-to-initialise-char.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-iohandlers-Add-enable-disable_write_fd_handler-funct.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-char-Add-framework-for-a-write-unblocked-callback.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-char-Update-send_all-to-handle-nonblocking-chardev-w.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-char-Equip-the-unix-tcp-backend-to-handle-nonblockin.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-char-Throttle-when-host-connection-is-down.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-virtio-console-Enable-port-throttling-when-chardev-i.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0009-spice-qemu-char.c-add-throttling.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0010-spice-qemu-char.c-remove-intermediate-buffer.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0011-usb-redir-Add-flow-control-support.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0012-spice-add-worker-wrapper-functions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0013-spice-add-qemu_spice_display_init_common.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0014-spice-qxl-move-worker-wrappers.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0015-qxl-fix-surface-tracking-locking.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0016-qxl-add-io_port_to_string.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0017-qxl-error-handling-fixes-and-cleanups.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0018-qxl-make-qxl_guest_bug-take-variable-arguments.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0019-qxl-only-disallow-specific-io-s-in-vga-mode.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0020-qxl-async-io-support-using-new-spice-api.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0021-qxl-add-QXL_IO_FLUSH_-SURFACES-RELEASE-for-guest-S3-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0022-qxl-bump-pci-rev.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0023-virtio-serial-bus-replay-guest_open-on-migration.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0024-qemu-char-make-qemu_chr_event-public.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0025-spice-qemu-char-Generate-chardev-open-close-events.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0026-usb-redir-Call-qemu_chr_guest_open-close.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0027-usb-redir-Device-disconnect-re-connect-robustness-fi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0028-usb-redir-Don-t-try-to-write-to-the-chardev-after-a-.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qemu-Allow-to-leave-type-on-default-in-machine.patch

set +e +o pipefail
