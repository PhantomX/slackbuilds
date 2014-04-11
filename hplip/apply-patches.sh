
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## Patches from Fedora
# The pstotiff filter is rubbish so replace it.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-pstotiff-is-rubbish.patch
# Fix compilation.
zcat ${SB_PATCHDIR}/hplip-strstr-const.patch.gz | patch -p1 -E --backup --verbose
# Make utils.checkPyQtImport() look for the gui sub-package.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-ui-optional.patch
# Make sure to avoid handwritten asm.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-no-asm.patch
# Corrected several IEEE 1284 Device IDs using foomatic data.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-deviceIDs-drv.patch
mv prnt/drv/hpijs.drv.in{,.deviceIDs-drv-hpijs}
./copy-deviceids.py prnt/drv/hpcups.drv.in \
  prnt/drv/hpijs.drv.in.deviceIDs-drv-hpijs \
  > prnt/drv/hpijs.drv.in
# Removed SYSFS use in udev rules and actually made them work.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-udev-rules.patch
# Retry when connecting to device fails.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-retry-open.patch
# Mark SNMP quirks in PPD for HP OfficeJet Pro 8500.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-snmp-quirks.patch
# Fixed bogus low ink warnings from hpijs driver
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-hpijs-marker-supply.patch
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

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hplip-scan-tmp.patch

set +e +o pipefail
