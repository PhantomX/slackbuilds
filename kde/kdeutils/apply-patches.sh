
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# add support for automatic printer driver installation (Tim Waugh, #576660)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-printer-applet-InstallPrinterDrivers.patch

set +e +o pipefail
