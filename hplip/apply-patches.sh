
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## Patches from Fedora
# The pstotiff filter is rubbish so replace it.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-pstotiff-is-rubbish.patch
# Fix compilation.
zcat ${SB_PATCHDIR}/hplip-strstr-const.patch.gz | patch -p1 -E --backup --verbose
# Make utils.checkPyQtImport() look for the gui sub-package.
zcat ${SB_PATCHDIR}/hplip-ui-optional.patch.gz | patch -p1 -E --backup --verbose
# Make sure to avoid handwritten asm.
zcat ${SB_PATCHDIR}/hplip-no-asm.patch.gz | patch -p1 -E --backup --verbose
# Corrected several IEEE 1284 Device IDs using foomatic data.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-deviceIDs-drv.patch
# Stopped hpcups pointlessly trying to read spool files directly.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-mucks-with-spooldir.patch
# Removed SYSFS use in udev rules and actually made them work.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-udev-rules.patch
# Retry when connecting to device fails.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-retry-open.patch
# Fixed hp-setup traceback when discovery page is skipped.
zcat ${SB_PATCHDIR}/hplip-discovery-method.patch.gz | patch -p1 -E --backup --verbose
# Fixed bogus low ink warnings from hpijs driver
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-hpijs-marker-supply.patch
# Give up trying to print a job to a reconnected device.
zcat ${SB_PATCHDIR}/hplip-device-reconnected.patch.gz | patch -p1 -E --backup --verbose
# Clear old printer-state-reasons we used to manage.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-clear-old-state-reasons.patch
# Avoid busy loop in hpcups when backend has exited.
zcat ${SB_PATCHDIR}/hplip-hpcups-sigpipe.patch.gz | patch -p1 -E --backup --verbose
# Fixed Device ID parsing code in hpijs's dj9xxvip.c.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-bad-low-ink-warning.patch

for ppd_file in $(grep '^diff' ${SB_PATCHDIR}/hplip-deviceIDs-ppd.patch | cut -d " " -f 4);
do
  gunzip ${ppd_file#*/}.gz
done
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-deviceIDs-ppd.patch
for ppd_file in $(grep '^diff' ${SB_PATCHDIR}/hplip-deviceIDs-ppd.patch | cut -d " " -f 4);
do
  gzip -n ${ppd_file#*/}
done

# Hpcups (ljcolor) was putting black lines where should be blank lines.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-skip-blank-lines.patch
# Added missing newline to string argument in dbglog() call.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-dbglog-newline.patch
# Wait longer to see if a system tray becomes available.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-no-system-tray.patch
# Prevent segfault in cupsext when opening PPD file.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-openPPD.patch
# Fix ImageableArea for Laserjet 8150/9000 (bug #596298).
for ppd_file in $(grep '^diff' ${SB_PATCHDIR}/hplip-ppd-ImageableArea.patch | cut -d " " -f 4);
do
  gunzip ${ppd_file#*/}.gz
done
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-ppd-ImageableArea.patch
for ppd_file in $(grep '^diff' ${SB_PATCHDIR}/hplip-ppd-ImageableArea.patch | cut -d " " -f 4);
do
  gzip -n ${ppd_file#*/}
done
# Increase timeouts for curl, wget, ping for high latency networks
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-network-timeout.patch
# utils.addgroup() was returning string instead of array
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-addgroup.patch
# Fixed traceback on error condition in device.py
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-raw_deviceID-traceback.patch
# Avoid UnicodeDecodeError in printsettingstoolbox.py
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-UnicodeDecodeError.patch

set +e +o pipefail
