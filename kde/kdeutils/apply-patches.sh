
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# add support for automatic printer driver installation (Tim Waugh, #576660)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-printer-applet-InstallPrinterDrivers.patch

# default to gpg2 in kgpg, todo: support gpg *or* gpg2
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.80-gpg2.patch

set +e +o pipefail
