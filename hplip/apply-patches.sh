
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
mv prnt/drv/hpijs.drv.in{,.deviceIDs-drv-hpijs}
./copy-deviceids.py prnt/drv/hpcups.drv.in \
  prnt/drv/hpijs.drv.in.deviceIDs-drv-hpijs \
  > prnt/drv/hpijs.drv.in
# Stopped hpcups pointlessly trying to read spool files directly.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-mucks-with-spooldir.patch
# Removed SYSFS use in udev rules and actually made them work.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-udev-rules.patch
# Retry when connecting to device fails.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-retry-open.patch
# Mark SNMP quirks in PPD for HP OfficeJet Pro 8500.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-snmp-quirks.patch
# Fixed hp-setup traceback when discovery page is skipped.
zcat ${SB_PATCHDIR}/hplip-discovery-method.patch.gz | patch -p1 -E --backup --verbose
# Fixed bogus low ink warnings from hpijs driver
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-hpijs-marker-supply.patch
# Clear old printer-state-reasons we used to manage.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-clear-old-state-reasons.patch
# Catch DBusException in hp-systray (bug #746024).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-systray-dbus-exception.patch
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
# Release parport if unsupported model connected (bug #699052).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-release-parport.patch
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
# Fixed traceback on error condition in device.py
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-raw_deviceID-traceback.patch
# Avoid UnicodeDecodeError in printsettingstoolbox.py
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-UnicodeDecodeError.patch
# Call cupsSetUser in cupsext's addPrinter method before connecting so
# that we can get an authentication callback.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-addprinter.patch
# Catch D-Bus exceptions in fax dialog.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-dbus-exception.patch
# Catch GError exception when notification showing failed.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-notification-exception.patch
# Applied patch to fix CVE-2010-4267, remote stack overflow vulnerability.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-CVE-2010-4267.patch
# Avoid KeyError in ui4/wifisetupdialog.py (bug #680939).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-wifisetup.patch
# Don't run 'chgrp lp /var/log/hp' in makefile
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-makefile-chgrp.patch
# Pay attention to the SANE localOnly flag in hpaio (bug #743593).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-hpaio-localonly.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-ipp-accessors.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-IEEE-1284-4.patch

set +e +o pipefail
