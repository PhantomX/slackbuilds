
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstreamable patches
# https://bugzilla.redhat.com/show_bug.cgi?id=739642
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdeutils-4.7.1-job-originating-user-name.patch

## upstream patches
## trunk, added to trunk/4.7, add support for automatic printer driver installation (Tim Waugh, #576660)
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdeutils-4.4.1-printer-applet-InstallPrinterDrivers.patch

set +e +o pipefail
