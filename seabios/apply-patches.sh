
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/seabios-usb_fix_boot_paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/seabios-do-not-advertise-S4-S3-in-DSDT.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/seabios-virtio-scsi.patch

set +e +o pipefail
